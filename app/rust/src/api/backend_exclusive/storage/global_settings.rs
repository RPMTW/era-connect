use std::{borrow::Cow, path::PathBuf};

pub use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};
use smart_default::SmartDefault;
use struct_key_value_pair::VariantStruct;

use super::storage_loader::{StorageInstance, StorageLoader};

const GLOBAL_SETTINGS_FILENAME: &str = "global_setings.json";

#[derive(Serialize, Deserialize, SmartDefault, Clone, Debug)]
pub struct GlobalSettings {
    pub appearances: Appearances,
    #[default = true]
    pub auto_java: bool,
    pub ui_layout: UILayout,
    pub download: Download,
}

impl StorageInstance<Self> for GlobalSettings {
    fn file_name() -> &'static str {
        GLOBAL_SETTINGS_FILENAME
    }

    fn save(&self) -> anyhow::Result<()> {
        let storage =
            StorageLoader::new(Self::file_name().to_owned(), Cow::Owned(Self::base_path()));
        storage.save(self)
    }
}

#[derive(Serialize, Deserialize, Clone, Debug, SmartDefault)]
#[serde(default)]
pub struct Download {
    #[default = 64]
    pub max_simultatneous_download: usize,
    pub download_speed_limit: Option<Speed>,
}

#[derive(Serialize, Deserialize, Clone, Debug, SmartDefault)]
pub enum Speed {
    #[default]
    MegabytePerSecond(#[default = 12.0] f64),
    MebibytePerSecond(f64),
    KilobytePerSecond(f64),
    KibiBytePerSecond(f64),
}

impl Speed {
    // FIXME: Naive translation
    pub fn to_mebibyte(&self) -> f64 {
        match self {
            Speed::MegabytePerSecond(x) => *x,
            Speed::MebibytePerSecond(x) => *x,
            Speed::KilobytePerSecond(x) => *x / 1024.,
            Speed::KibiBytePerSecond(x) => *x / 1000.,
        }
    }
}

#[derive(Serialize, Deserialize, Default, Clone, Debug)]
pub struct Appearances {
    pub dark_lightmode: DarkLightMode,
    pub day_light_darkmode: bool,
    pub default_background_picture: PathBuf,
    pub blur: bool,
    pub adaptive_background: bool,
    pub high_contrast: bool,
    pub greyscale: bool,
    pub disable_background_picture: bool,
    pub animation: bool,
}

#[derive(Serialize, Deserialize, Default, Clone, Debug)]
pub enum DarkLightMode {
    #[default]
    Dark,
    Light,
}

#[derive(Serialize, Deserialize, Default, Clone, Debug, VariantStruct)]
#[serde(default)]
pub struct UILayout {
    pub completed_setup: bool,
    pub shows_recommendation: bool,
    pub sidebar_preivew: bool,
}
