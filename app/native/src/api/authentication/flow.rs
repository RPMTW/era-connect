use anyhow::Ok;
use flutter_rust_bridge::StreamSink;
use oauth2::basic::{BasicClient, BasicErrorResponseType, BasicTokenType};
use oauth2::reqwest::async_http_client;
use oauth2::{
    AuthUrl, ClientId, DeviceAuthorizationUrl, EmptyExtraTokenFields, RevocationErrorResponseType,
    Scope, StandardDeviceAuthorizationResponse, StandardErrorResponse, StandardRevocableToken,
    StandardTokenIntrospectionResponse, StandardTokenResponse, TokenResponse, TokenUrl,
};
use serde::Deserialize;
use serde_json::json;
use tokio::time::sleep;

use super::account::MinecraftAccount;
use super::{
    MINECRAFT_AUTH_URL, MSA_CLIENT_ID, MSA_DEVICE_CODE_URL, MSA_SCOPE, MSA_TOKEN_URL, MSA_URL,
    XBOX_LIVE_AUTH_URL, XBOX_LIVE_XSTS_URL,
};

#[derive(Debug, Clone)]
pub enum LoginFlowEvent {
    Progress(LoginFlowProgress),
    DeviceCode(LoginFlowDeviceCode),
    Error(XstsTokenError),
    Success(MinecraftAccount),
}

#[derive(Debug, Clone)]
pub struct LoginFlowDeviceCode {
    pub verification_uri: String,
    pub user_code: String,
}

#[derive(Debug, Clone)]
pub struct LoginFlowProgress {
    pub state: LoginFlowState,
    pub progress: f64,
}

#[derive(Debug, Clone)]
pub enum LoginFlowState {
    FetchingDeviceCode,
    WaitingForUser,
    AuthenticatingXboxLive,
    FetchingXstsToken,
    FetchingMinecraftToken,
    Success,
}

type OAuthClient = oauth2::Client<
    StandardErrorResponse<BasicErrorResponseType>,
    StandardTokenResponse<EmptyExtraTokenFields, BasicTokenType>,
    BasicTokenType,
    StandardTokenIntrospectionResponse<EmptyExtraTokenFields, BasicTokenType>,
    StandardRevocableToken,
    StandardErrorResponse<RevocationErrorResponseType>,
>;

#[derive(Debug, Deserialize)]
struct XboxLiveResponse {
    #[serde(rename = "Token")]
    token: String,
    #[serde(rename = "DisplayClaims")]
    display_claims: XboxLiveDisplayClaims,
}

#[derive(Debug, Deserialize)]
struct XboxLiveDisplayClaims {
    xui: Vec<XboxLiveDisplayClaimsXui>,
}

#[derive(Debug, Deserialize)]
struct XboxLiveDisplayClaimsXui {
    uhs: String,
}

pub enum XstsResponse {
    Success(String),
    Error(XstsTokenError),
}

#[derive(Debug, Clone, Deserialize)]
pub struct XstsTokenError {
    #[serde(rename = "Identity")]
    pub identity: String,
    #[serde(rename = "XErr")]
    pub xerr: XstsTokenErrorType,
    #[serde(rename = "Message")]
    pub message: String,
    #[serde(rename = "Redirect")]
    pub redirect: String,
}

#[derive(Debug, Deserialize)]
struct MinecraftTokenResponse {
    username: String,
    access_token: String,
    expires_in: i64,
}

/// Reference: https://wiki.vg/Microsoft_Authentication_Scheme
#[derive(Debug, Clone, Deserialize)]
#[repr(usize)]
pub enum XstsTokenErrorType {
    /// The account doesn't have an Xbox account. Once they sign up for one (or login through minecraft.net to create one) then they can proceed with the login. This shouldn't happen with accounts that have purchased Minecraft with a Microsoft account, as they would've already gone through that Xbox signup process.
    DoesNotHaveXboxAccount = 2148916233,
    /// The account is from a country where Xbox Live is not available/banned.
    CountryNotAvailable = 2148916235,
    /// The account needs adult verification on Xbox page. (South Korea)
    NeedsAdultVerificationKR1 = 2148916236,
    /// The account needs adult verification on Xbox page. (South Korea)
    NeedsAdultVerificationKR2 = 2148916237,
    /// The account is a child (under 18) and cannot proceed unless the account is added to a Family by an adult. This only seems to occur when using a custom Microsoft Azure application. When using the Minecraft launchers client id, this doesn't trigger.
    ChildAccount = 2148916238,
}

pub async fn login_flow(skin: &StreamSink<LoginFlowEvent>) -> anyhow::Result<()> {
    skin.add(LoginFlowEvent::Progress(LoginFlowProgress {
        state: LoginFlowState::FetchingDeviceCode,
        progress: 0.0,
    }));

    // Device Code Flow
    let client = create_oauth_client()?;
    let device_auth_response = fetch_device_code(&client).await?;
    skin.add(LoginFlowEvent::DeviceCode(LoginFlowDeviceCode {
        verification_uri: device_auth_response.verification_uri().to_string(),
        user_code: device_auth_response.user_code().secret().to_string(),
    }));
    skin.add(LoginFlowEvent::Progress(LoginFlowProgress {
        state: LoginFlowState::WaitingForUser,
        progress: 10.0,
    }));

    // Microsoft Authentication Flow
    let (microsoft_token, refresh_token) =
        fetch_microsoft_token(&client, &device_auth_response).await?;
    skin.add(LoginFlowEvent::Progress(LoginFlowProgress {
        state: LoginFlowState::AuthenticatingXboxLive,
        progress: 25.0,
    }));

    // Xbox Live Authentication Flow
    let (xbl_token, user_hash) = authenticate_xbox_live(&microsoft_token).await?;
    skin.add(LoginFlowEvent::Progress(LoginFlowProgress {
        state: LoginFlowState::FetchingXstsToken,
        progress: 40.0,
    }));

    // XSTS Authentication Flow
    let xsts_response = fetch_xsts_token(&xbl_token).await?;
    let xsts_token: String = match xsts_response {
        XstsResponse::Success(token) => {
            skin.add(LoginFlowEvent::Progress(LoginFlowProgress {
                state: LoginFlowState::FetchingMinecraftToken,
                progress: 60.0,
            }));

            token
        }
        XstsResponse::Error(e) => {
            skin.add(LoginFlowEvent::Error(e));
            return Ok(());
        }
    };

    // Minecraft Authentication Flow
    fetch_minecraft_token(xsts_token, user_hash).await?;

    Ok(())
}

pub fn create_oauth_client() -> anyhow::Result<OAuthClient> {
    let client = BasicClient::new(
        ClientId::new(MSA_CLIENT_ID.to_owned()),
        None,
        AuthUrl::new(MSA_URL.to_owned())?,
        Some(TokenUrl::new(MSA_TOKEN_URL.to_owned())?),
    )
    .set_device_authorization_url(DeviceAuthorizationUrl::new(MSA_DEVICE_CODE_URL.to_owned())?);

    Ok(client)
}

pub async fn fetch_device_code(
    client: &OAuthClient,
) -> anyhow::Result<StandardDeviceAuthorizationResponse> {
    let response: StandardDeviceAuthorizationResponse = client
        .exchange_device_code()?
        .add_scope(Scope::new(MSA_SCOPE.to_owned()))
        .request_async(async_http_client)
        .await?;

    Ok(response)
}

pub async fn fetch_microsoft_token(
    client: &OAuthClient,
    auth_response: &StandardDeviceAuthorizationResponse,
) -> anyhow::Result<(String, String)> {
    let response: StandardTokenResponse<EmptyExtraTokenFields, BasicTokenType> = client
        .exchange_device_access_token(auth_response)
        .request_async(async_http_client, sleep, None)
        .await?;

    Ok((
        response.access_token().secret().to_owned(),
        response
            .refresh_token()
            .expect("refresh token not found")
            .secret()
            .to_owned(),
    ))
}

pub async fn authenticate_xbox_live(ms_access_token: &String) -> anyhow::Result<(String, String)> {
    let client = reqwest::Client::new();

    let payload = json!({
        "Properties": {
            "AuthMethod": "RPS",
            "SiteName": "user.auth.xboxlive.com",
            "RpsTicket": format!("d={}", ms_access_token)
        },
        "RelyingParty": "http://auth.xboxlive.com",
        "TokenType": "JWT",
    });

    let response = client
        .post(XBOX_LIVE_AUTH_URL)
        .json(&payload)
        .header("Content-Type", "application/json")
        .header("Accept", "application/json")
        .send()
        .await?;
    let response = response.json::<XboxLiveResponse>().await?;

    let xbl_token = response.token;
    let user_hash = response
        .display_claims
        .xui
        .first()
        .expect("Xbox Live user hash not found")
        .uhs
        .to_owned();

    Ok((xbl_token, user_hash))
}

pub async fn fetch_xsts_token(xbl_token: &String) -> anyhow::Result<XstsResponse> {
    let client = reqwest::Client::new();

    let payload = json!({
        "Properties": {
            "SandboxId": "RETAIL",
            "UserTokens": [xbl_token],
        },
        "RelyingParty": "rp://api.minecraftservices.com/",
        "TokenType": "JWT",
    });

    let response = client
        .post(XBOX_LIVE_XSTS_URL)
        .json(&payload)
        .header("Content-Type", "application/json")
        .header("Accept", "application/json")
        .send()
        .await?;

    if response.status() == 401 {
        let response = response.json::<XstsTokenError>().await?;
        return Ok(XstsResponse::Error(response));
    }

    let response = response.json::<XboxLiveResponse>().await?;
    let xsts_token = response.token;

    Ok(XstsResponse::Success(xsts_token))
}

pub async fn fetch_minecraft_token(
    xsts_token: String,
    user_hash: String,
) -> anyhow::Result<String> {
    let client = reqwest::Client::new();

    let payload = json!({
        "identityToken": format!("XBL3.0 x={};{}", user_hash, xsts_token),
    });

    let response = client
        .post(MINECRAFT_AUTH_URL)
        .json(&payload)
        .header("Content-Type", "application/json")
        .header("Accept", "application/json")
        .send()
        .await?;
    let response = response.json::<MinecraftTokenResponse>().await?;

    Ok(response.access_token)
}
