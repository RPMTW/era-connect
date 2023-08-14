pub use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use super::config_loader::{ConfigInstance, ConfigLoader};

const UI_LAYOUT_FILE_NAME: &str = "ui_layout.json";

#[derive(Serialize, Deserialize, Default, Clone, Debug)]
#[serde(default)]
pub struct UILayout {
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

impl ConfigInstance<Self> for UILayout {
    fn file_name() -> &'static str {
        UI_LAYOUT_FILE_NAME
    }

    fn save(&self) -> anyhow::Result<()> {
        let loader = ConfigLoader::new(UI_LAYOUT_FILE_NAME.to_owned());
        loader.save(&self)
    }
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
}
