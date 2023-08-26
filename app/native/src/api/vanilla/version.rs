use anyhow::Context;
use chrono::{DateTime, Utc};
use serde::Deserialize;

use crate::api::download::download_file;

const VERSION_MANIFEST_URL: &str =
    "https://piston-meta.mojang.com/mc/game/version_manifest_v2.json";

#[derive(Debug, Deserialize)]
pub struct VersionManifest {
    pub latest: LatestVersion,
    pub versions: Vec<BasicVersionMetadata>,
}

#[derive(Debug, Deserialize)]
pub struct LatestVersion {
    pub release: String,
    pub snapshot: String,
}

#[derive(Debug, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct BasicVersionMetadata {
    /// A unique identifier of the version, for example `1.20.1` or `23w33a`.
    pub id: String,
    pub r#type: VersionType,
    /// A direct link to the detailed metadata file for this version.
    pub url: String,
    #[serde(rename = "time")]
    pub uploaded_time: DateTime<Utc>,
    pub release_time: DateTime<Utc>,
    pub sha1: String,
    pub compliance_level: u32,
}

#[derive(Debug, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum VersionType {
    Release,
    Snapshot,
    OldBeta,
    OldAlpha,
}

pub async fn get_versions() -> anyhow::Result<Vec<BasicVersionMetadata>> {
    let response = download_file(VERSION_MANIFEST_URL, None)
        .await
        .context("Failed to download version manifest")?;
    let version_manifest: VersionManifest =
        serde_json::from_slice(&response).context("Failed to parse version manifest")?;

    Ok(version_manifest.versions)
}
