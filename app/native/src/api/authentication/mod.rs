pub mod account;
pub mod flow;

/// MSA -> Microsoft Authorization

/// By using the MSA_CLIENT_ID in your application builds, you agree to the Terms of the Microsoft Identity Platform.
/// See also: https://docs.microsoft.com/en-us/legal/microsoft-identity-platform/terms-of-use
pub const MSA_CLIENT_ID: &str = "b7df55b4-300f-4409-8ea9-a172f844aa15";

pub const MSA_URL: &str = "https://login.microsoftonline.com/consumers/oauth2/v2.0/authorize";
pub const MSA_TOKEN_URL: &str = "https://login.microsoftonline.com/common/oauth2/v2.0/token";
pub const MSA_DEVICE_CODE_URL: &str =
    "https://login.microsoftonline.com/consumers/oauth2/v2.0/devicecode";
pub const MSA_SCOPE: &str = "XboxLive.signin offline_access";

pub const XBOX_LIVE_AUTH_URL: &str = "https://user.auth.xboxlive.com/user/authenticate";
pub const XBOX_LIVE_XSTS_URL: &str = "https://xsts.auth.xboxlive.com/xsts/authorize";

pub const MINECRAFT_AUTH_URL: &str =
    "https://api.minecraftservices.com/authentication/login_with_xbox";
