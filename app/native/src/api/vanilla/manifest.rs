use chrono::{DateTime, Utc};
use serde::Deserialize;

use crate::api::download::download_file;

use super::assets::AssetIndex;
use super::library::Library;
use super::rules::Rule;
use super::version::{GetVersionError, VersionType};

#[derive(Debug, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct GameManifest {
    pub arguments: Arguments,
    pub asset_index: AssetIndex,
    pub assets: String,
    pub compliance_level: u32,
    pub downloads: Downloads,
    pub id: String,
    pub java_version: JavaVersion,
    pub libraries: Vec<Library>,
    pub logging: LoggingConfig,
    pub main_class: String,
    pub minimum_launcher_version: u32,
    pub release_time: DateTime<Utc>,
    pub time: DateTime<Utc>,
    #[serde(rename = "type")]
    pub version_type: VersionType,
}

#[derive(Debug, Deserialize)]
pub struct Arguments {
    pub game: Vec<Argument>,
    pub jvm: Vec<Argument>,
}

#[derive(Debug, PartialEq, Deserialize)]
#[serde(untagged)]
pub enum Argument {
    General(String),
    Ruled {
        rules: Vec<Rule>,
        value: ArgumentValue,
    },
}

#[derive(Debug, PartialEq, Deserialize)]
#[serde(untagged)]
pub enum ArgumentValue {
    Single(String),
    Multiple(Vec<String>),
}

#[derive(Debug, Deserialize)]
pub struct Downloads {
    pub client: DownloadMetadata,
    pub client_mappings: DownloadMetadata,
    pub server: DownloadMetadata,
    pub server_mappings: DownloadMetadata,
}

#[derive(Debug, Deserialize)]
pub struct DownloadMetadata {
    pub sha1: String,
    pub size: usize,
    pub url: String,
}

#[derive(Debug, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct JavaVersion {
    pub component: String,
    pub major_version: u32,
}

#[derive(Debug, Deserialize)]
pub struct LoggingConfig {
    pub client: LoggingClientConfig,
}

#[derive(Debug, Deserialize)]
pub struct LoggingClientConfig {
    pub argument: String,
    pub file: LoggingFile,
    #[serde(rename = "type")]
    pub logging_type: String,
}

#[derive(Debug, Deserialize)]
pub struct LoggingFile {
    pub id: String,
    pub sha1: String,
    pub size: u64,
    pub url: String,
}

pub async fn fetch_game_manifest(url: &str) -> Result<GameManifest, GetVersionError> {
    let response = download_file(url, None).await?;

    Ok(serde_json::from_slice(&response)?)
}
