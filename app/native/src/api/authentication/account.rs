use serde::{Deserialize, Serialize};
use uuid::Uuid;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MinecraftAccount {
    pub username: String,
    pub uuid: Uuid,
    pub access_token: String,
    pub refresh_token: String,
    pub expires_at: i64,
    pub skins: Vec<MinecraftSkin>,
    pub capes: Vec<MinecraftCape>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MinecraftSkin {
    pub id: Uuid,
    pub state: String,
    pub url: String,
    pub variant: MinecraftSkinVariant,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum MinecraftSkinVariant {
    #[serde(rename = "CLASSIC")]
    Classic,
    #[serde(rename = "SLIM")]
    Slim,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MinecraftCape {
    pub id: Uuid,
    pub state: String,
    pub url: String,
    pub alias: String,
}
