use std::path::PathBuf;

use chrono::{DateTime, Duration, Utc};
use serde::{Deserialize, Serialize};
use serde_with::serde_as;

#[serde_with::serde_as]
#[derive(Debug, Deserialize, Serialize)]
pub struct Collection {
    pub display_name: String,
    pub minecraft_version: String,
    pub mod_loader: ModLoader,
    pub created_at: DateTime<Utc>,
    pub updated_at: DateTime<Utc>,
    #[serde_as(as = "serde_with::DurationSeconds<i64>")]
    pub play_time: Duration,
    pub advanced_options: AdvancedOptions,

    #[serde(skip)]
    pub path: PathBuf,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct AdvancedOptions {}

#[derive(Debug, Deserialize, Serialize)]
pub enum ModLoader {
    Forge { version: String },
    NeoForge { version: String },
    Fabric { version: String },
    Quilt { version: String },
}
