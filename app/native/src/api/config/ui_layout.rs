pub use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use super::config_loader::ConfigLoader;

const UI_LAYOUT_FILE_NAME: &str = "ui_layout.json";

#[derive(Serialize, Deserialize, Default, Clone, Debug)]
#[serde(default)]
pub struct UILayout {
    pub fail: String,
    pub completed_setup: bool,
}

#[derive(Clone, Copy)]
pub enum Key {
    CompletedSetup,
}

#[derive(Clone, Copy)]
pub enum Value {
    CompletedSetup(bool),
}

impl UILayout {
    pub const fn get_value(&self, key: Key) -> Value {
        match key {
            Key::CompletedSetup => Value::CompletedSetup(self.completed_setup),
        }
    }

    pub fn set_value(&mut self, value: Value) {
        match value {
            Value::CompletedSetup(x) => self.completed_setup = x,
        }
    }

    pub fn load() -> anyhow::Result<Self> {
        let loader = ConfigLoader::new(UI_LAYOUT_FILE_NAME);
        loader.load()
    }

    pub fn save(&self) -> anyhow::Result<()> {
        let loader = ConfigLoader::new(UI_LAYOUT_FILE_NAME);
        loader.save(&self)
    }
}
