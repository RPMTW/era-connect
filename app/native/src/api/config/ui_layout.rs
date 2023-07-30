use serde::{Deserialize, Serialize};

use super::config_loader::ConfigLoader;

#[derive(Serialize, Deserialize, Default, Copy, Clone, Debug)]
pub struct UILayout {
    pub completed_setup: bool,
}

impl UILayout {
    pub fn new() -> Self {
        let loader = ConfigLoader::new("ui_layout.json".to_string());
        loader.load().unwrap()
    }

    // pub fn test(&self) -> bool {
    //     self.completed_setup
    // }
}
