//! MSA -> Microsoft Authorization

pub mod account;
pub mod msa_flow;

/// By using the `MSA_CLIENT_ID` in your application builds, you agree to the Terms of the Microsoft Identity Platform.
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
pub const MINECRAFT_GAME_OWNERSHIP_URL: &str =
    "https://api.minecraftservices.com/entitlements/mcstore";
pub const MINECRAFT_USER_PROFILE_URL: &str = "https://api.minecraftservices.com/minecraft/profile";

pub const MOJANG_PUBLIC_KEY: &[u8] = br#"
-----BEGIN PUBLIC KEY-----
MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAtz7jy4jRH3psj5AbVS6W
NHjniqlr/f5JDly2M8OKGK81nPEq765tJuSILOWrC3KQRvHJIhf84+ekMGH7iGlO
4DPGDVb6hBGoMMBhCq2jkBjuJ7fVi3oOxy5EsA/IQqa69e55ugM+GJKUndLyHeNn
X6RzRzDT4tX/i68WJikwL8rR8Jq49aVJlIEFT6F+1rDQdU2qcpfT04CBYLM5gMxE
fWRl6u1PNQixz8vSOv8pA6hB2DU8Y08VvbK7X2ls+BiS3wqqj3nyVWqoxrwVKiXR
kIqIyIAedYDFSaIq5vbmnVtIonWQPeug4/0spLQoWnTUpXRZe2/+uAKN1RY9mmaB
pRFV/Osz3PDOoICGb5AZ0asLFf/qEvGJ+di6Ltt8/aaoBuVw+7fnTw2BhkhSq1S/
va6LxHZGXE9wsLj4CN8mZXHfwVD9QG0VNQTUgEGZ4ngf7+0u30p7mPt5sYy3H+Fm
sWXqFZn55pecmrgNLqtETPWMNpWc2fJu/qqnxE9o2tBGy/MqJiw3iLYxf7U+4le4
jM49AUKrO16bD1rdFwyVuNaTefObKjEMTX9gyVUF6o7oDEItp5NHxFm3CqnQRmch
HsMs+NxEnN4E9a8PDB23b4yjKOQ9VHDxBxuaZJU60GBCIOF9tslb7OAkheSJx5Xy
EYblHbogFGPRFU++NrSQRX0CAwEAAQ==
-----END PUBLIC KEY-----
"#;
