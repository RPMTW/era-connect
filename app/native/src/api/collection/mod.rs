use std::{
    fs::{create_dir_all, File},
    io::BufWriter,
    path::PathBuf,
    sync::Arc,
};

use chrono::{DateTime, Duration, Utc};
use serde::{Deserialize, Serialize};
use serde_json::json;
use serde_with::serde_as;
use struct_key_value_pair::VariantStruct;
use tokio::fs;

use super::{storage::storage_loader::StorageLoader, DATA_DIR};

#[serde_with::serde_as]
#[derive(Debug, Deserialize, Serialize, VariantStruct)]
pub struct Collection {
    pub display_name: String,
    pub minecraft_version: String,
    pub mod_loader: Option<ModLoader>,
    pub created_at: DateTime<Utc>,
    pub updated_at: DateTime<Utc>,
    #[serde_as(as = "serde_with::DurationSeconds<i64>")]
    pub played_time: Duration,
    pub advanced_options: AdvancedOptions,
}

impl Default for Collection {
    fn default() -> Self {
        Self {
            display_name: String::new(),
            minecraft_version: String::new(),
            mod_loader: None,
            created_at: Utc::now(),
            updated_at: Utc::now(),
            played_time: Duration::seconds(0),
            advanced_options: AdvancedOptions::new(),
        }
    }
}

const COLLECTION_NAME: &str = "collections.json";
const COLLECTION_BASE: &str = "collections";

impl Collection {
    fn get_path_str(&self) -> String {
        format!("{}_hash", self.display_name)
    }
    pub fn new(s: String) -> anyhow::Result<()> {
        let collection_base_dir = DATA_DIR.join(COLLECTION_BASE);
        let collection = Self {
            display_name: s,
            ..Default::default()
        };
        let base_path = collection_base_dir.join(collection.get_path_str());
        let file = File::create(base_path)?;
        let writer = BufWriter::new(file);
        serde_json::to_writer(writer, &collection)?;
        Ok(())
    }
    pub fn scan() -> anyhow::Result<Vec<StorageLoader>> {
        let mut loaders = Vec::new();
        let collection_base_dir = DATA_DIR.join(COLLECTION_BASE);
        create_dir_all(collection_base_dir);
        let dirs = collection_base_dir.read_dir()?;

        if dirs.count() == 0 {
            return Ok(Vec::new());
        }

        for base_entry in dirs {
            let base_entry_path = base_entry?.path();

            for file in base_entry_path.read_dir()? {
                let file_name = file?.file_name().to_string_lossy().to_string();

                if file_name == COLLECTION_NAME {
                    loaders.push(StorageLoader::new(
                        file_name,
                        collection_base_dir.join(base_entry_path),
                    ));
                }
            }
        }
        Ok(loaders)
    }
}

#[derive(Debug, Deserialize, Serialize, Clone)]
pub struct ModLoader {
    #[serde(rename = "type")]
    pub modloader_type: ModLoaderType,
    pub version: String,
}

#[derive(Debug, Deserialize, Serialize, Clone, Copy)]
pub enum ModLoaderType {
    Forge,
    NeoForge,
    Fabric,
    Quilt,
}

#[derive(Debug, Deserialize, Serialize, Clone)]
pub struct AdvancedOptions {}

impl AdvancedOptions {
    pub fn new() -> Self {
        todo!()
    }
}
