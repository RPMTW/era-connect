use anyhow::Ok;
use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};

use crate::api::backend_exclusive::download::download_file;

use super::assets::AssetIndex;
use super::library::Library;
use super::rules::Rule;
use super::version::VersionType;

#[derive(Debug, Deserialize, Clone)]
#[serde(rename_all = "camelCase")]
pub struct GameManifest {
    pub arguments: Arguments,
    pub asset_index: AssetIndex,
    pub assets: String,
    pub downloads: Downloads,
    pub id: String,
    pub java_version: JavaVersion,
    pub libraries: Vec<Library>,
    pub main_class: String,
    pub minimum_launcher_version: u32,
    pub release_time: DateTime<Utc>,
    pub time: DateTime<Utc>,
    #[serde(rename = "type")]
    pub version_type: VersionType,
}

#[derive(Debug, PartialEq, Eq, Deserialize, Serialize, Clone)]
pub struct Arguments {
    pub game: Vec<Argument>,
    pub jvm: Vec<Argument>,
}

#[derive(Debug, PartialEq, Eq, Deserialize, Serialize, Clone)]
#[serde(untagged)]
pub enum Argument {
    General(String),
    Ruled {
        rules: Vec<Rule>,
        value: ArgumentRuledValue,
    },
}

#[derive(Debug, PartialEq, Eq, Deserialize, Serialize, Clone)]
#[serde(untagged)]
pub enum ArgumentRuledValue {
    Single(String),
    Multiple(Vec<String>),
}

#[derive(Debug, Deserialize, Clone)]
pub struct Downloads {
    pub client: DownloadMetadata,
    pub client_mappings: DownloadMetadata,
    pub server: DownloadMetadata,
    pub server_mappings: DownloadMetadata,
}

#[derive(Debug, Deserialize, Clone)]
pub struct DownloadMetadata {
    pub sha1: String,
    pub size: usize,
    pub url: String,
}

#[derive(Debug, Deserialize, Clone)]
#[serde(rename_all = "camelCase")]
pub struct JavaVersion {
    pub component: String,
    pub major_version: u32,
}

pub async fn fetch_game_manifest(url: &str) -> anyhow::Result<GameManifest> {
    let response = download_file(url, None).await?;
    let p = serde_json::from_slice(&response)?;

    Ok(p)
}
