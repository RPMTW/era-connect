pub use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};
use struct_key_value_pair::VariantStruct;

use super::config_loader::ConfigLoader;

const UI_LAYOUT_FILE_NAME: &str = "ui_layout.json";

#[derive(Serialize, Deserialize, Default, Clone, Debug, VariantStruct)]
#[serde(default)]
pub struct UILayout {
    pub completed_setup: bool,
}

impl UILayout {
    pub fn load() -> anyhow::Result<Self> {
        let loader = ConfigLoader::new(UI_LAYOUT_FILE_NAME.to_owned());
        loader.load()
    }

    pub fn save(&self) -> anyhow::Result<()> {
        let loader = ConfigLoader::new(UI_LAYOUT_FILE_NAME.to_owned());
        loader.save(&self)
    }
}
