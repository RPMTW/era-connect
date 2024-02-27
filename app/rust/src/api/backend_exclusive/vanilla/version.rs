use anyhow::Context;
use chrono::{DateTime, Utc};
use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use crate::api::backend_exclusive::download::download_file;

const VERSION_MANIFEST_URL: &str = "https://meta.modrinth.com/minecraft/v0/manifest.json";

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

#[derive(Debug, Deserialize, Serialize, Clone, PartialEq, Eq)]
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

pub enum PossibleJavaVersions {
    Six,
    Eight,
    Seventeen,
}

impl ToString for PossibleJavaVersions {
    fn to_string(&self) -> String {
        match self {
            Self::Six => 6.to_string(),
            Self::Eight => 8.to_string(),
            Self::Seventeen => 17.to_string(),
        }
    }
}

impl VersionMetadata {
    pub fn get_recommended_java_version(&self) -> PossibleJavaVersions {
        let java_6_max = DateTime::parse_from_rfc3339("2016-12-20T14:05:34Z")
            .unwrap()
            .to_utc();
        let java_8_max = DateTime::parse_from_rfc3339("2021-01-14T16:05:32Z")
            .unwrap()
            .to_utc();

        if self.release_time <= java_6_max {
            PossibleJavaVersions::Six
        } else if self.release_time <= java_8_max {
            PossibleJavaVersions::Eight
        } else {
            PossibleJavaVersions::Seventeen
        }
    }
}

#[derive(Debug, Deserialize, Serialize, Clone, PartialEq, Eq)]
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
