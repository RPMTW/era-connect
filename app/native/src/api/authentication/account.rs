use anyhow::Context;
use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};
use uuid::Uuid;

use crate::api::DATA_DIR;

#[frb(dart_metadata=("freezed"))]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MinecraftAccount {
    pub username: String,
    pub uuid: Uuid,
    pub access_token: AccountToken,
    pub refresh_token: AccountToken,
    pub skins: Vec<MinecraftSkin>,
    pub capes: Vec<MinecraftCape>,
}

#[frb(dart_metadata=("freezed"))]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MinecraftSkin {
    pub id: Uuid,
    pub state: String,
    pub url: String,
    pub variant: MinecraftSkinVariant,
}

#[frb(dart_metadata=("freezed"))]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum MinecraftSkinVariant {
    #[serde(rename = "CLASSIC")]
    Classic,
    #[serde(rename = "SLIM")]
    Slim,
}

#[frb(dart_metadata=("freezed"))]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MinecraftCape {
    pub id: Uuid,
    pub state: String,
    pub url: String,
    pub alias: String,
}

#[frb(dart_metadata=("freezed"))]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AccountToken {
    pub token: String,
    pub expires_at: i64,
}

impl MinecraftSkin {
    async fn download_skin(&self) -> anyhow::Result<()> {
        let response = reqwest::get(&self.url)
            .await
            .context("Failed to download skin")?;
        let bytes = response.bytes().await.context("Failed to get skin bytes")?;

        let file_path = DATA_DIR.join("skins").join(format!("{}.png", self.id));
        std::fs::write(file_path, bytes).context("Failed to save skin")?;

        Ok(())
    }
}
