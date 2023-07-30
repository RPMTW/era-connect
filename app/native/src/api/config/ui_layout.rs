use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use super::config_loader::ConfigLoader;

const UI_LAYOUT_FILE_NAME: &str = "ui_layout.json";

#[frb(dart_metadata=("freezed"))]
#[derive(Serialize, Deserialize, Default, Copy, Clone, Debug)]
#[serde(default)]
pub struct UILayout {
    pub completed_setup: bool,
}

impl UILayout {
    pub fn load() -> anyhow::Result<Self> {
        let loader = ConfigLoader::new(UI_LAYOUT_FILE_NAME);
        loader.load()
    }

    pub fn save(&self) -> anyhow::Result<()> {
        let loader = ConfigLoader::new(UI_LAYOUT_FILE_NAME);
        loader.save(self)
    }
}
