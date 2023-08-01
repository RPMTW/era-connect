pub use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use super::config_loader::ConfigLoader;

const UI_LAYOUT_FILE_NAME: &str = "ui_layout.json";

#[frb(dart_metadata=("freezed"))]
#[derive(Serialize, Deserialize, Default, Clone, Debug)]
#[serde(default)]
pub struct UILayout {
    pub fail: String,
    pub completed_setup: bool,
}
pub enum Key {
    Fail,
    CompletedSetup,
}
pub enum Value {
    Fail(String),
    CompletedSetup(bool),
}

impl UILayout {
    pub fn get_value(&self, key: Key) -> Value {
        match key {
            Key::Fail => Value::Fail(self.fail.clone()),
            Key::CompletedSetup => Value::CompletedSetup(self.completed_setup),
        }
    }
    pub fn load() -> anyhow::Result<Self> {
        let loader = ConfigLoader::new(UI_LAYOUT_FILE_NAME);
        loader.load()
    }

    pub fn save(&self) -> anyhow::Result<()> {
        let loader = ConfigLoader::new(UI_LAYOUT_FILE_NAME);
        loader.save(self)
    }
}
