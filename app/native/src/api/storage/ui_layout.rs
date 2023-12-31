pub use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};
use struct_key_value_pair::VariantStruct;

use super::storage_loader::{StorageInstance, StorageLoader};

const UI_LAYOUT_FILE_NAME: &str = "ui_layout.json";

#[derive(Serialize, Deserialize, Default, Clone, Debug, VariantStruct)]
#[serde(default)]
pub struct UILayout {
    pub completed_setup: bool,
}

impl StorageInstance<Self> for UILayout {
    fn file_name() -> &'static str {
        UI_LAYOUT_FILE_NAME
    }

    fn save(&self) -> anyhow::Result<()> {
        let loader = StorageLoader::new(UI_LAYOUT_FILE_NAME.to_owned());
        loader.save(&self)
    }
}
