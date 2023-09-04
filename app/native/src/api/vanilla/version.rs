use anyhow::Context;
use chrono::{DateTime, Utc};
use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use crate::api::download::download_file;

const VERSION_MANIFEST_URL: &str =
    "https://piston-meta.mojang.com/mc/game/version_manifest_v2.json";

#[derive(Debug, Deserialize)]
pub struct VersionsManifest {
    pub latest: LatestVersion,
    pub versions: Vec<VersionMetadata>,
}

#[derive(Debug, Deserialize)]
pub struct LatestVersion {
    pub release: String,
    pub snapshot: String,
}

#[derive(Debug, Deserialize, Serialize, Clone)]
#[serde(rename_all = "camelCase")]
#[frb[dart_metadata = ("freezed")]]
pub struct VersionMetadata {
    /// A unique identifier of the version, for example `1.20.1` or `23w33a`.
    pub id: String,
    #[serde(rename = "type")]
    pub version_type: VersionType,
    /// A direct link to the detailed metadata file for this version.
    pub url: String,
    #[serde(rename = "time")]
    pub uploaded_time: DateTime<Utc>,
    pub release_time: DateTime<Utc>,
    pub sha1: String,
    pub compliance_level: u32,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
#[serde(rename_all = "snake_case")]
pub enum VersionType {
    Release,
    Snapshot,
    OldBeta,
    OldAlpha,
}

pub async fn get_versions() -> anyhow::Result<Vec<VersionMetadata>> {
    let response = download_file(VERSION_MANIFEST_URL, None)
        .await
        .context("Failed to download version manifest")?;
    let version_manifest: VersionsManifest =
        serde_json::from_slice(&response).context("Failed to parse version manifest")?;

    Ok(version_manifest.versions)
}
