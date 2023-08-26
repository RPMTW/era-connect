use std::path::PathBuf;

use chrono::{DateTime, Duration, Utc};
use serde::{Deserialize, Serialize};
use serde_with::serde_as;
use struct_key_value_pair::VariantStruct;

use super::{
    storage::storage_loader::{StorageInstanceMultiple, StorageLoader},
    STORAGE,
};

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

impl StorageInstanceMultiple<Self> for Collection {
    fn file_names() -> Vec<&'static str> {
        let collection = STORAGE.collection.blocking_read();
        collection
            .iter()
            .map(|x| {
                let b: &'static str = Box::leak(x.display_name.clone().into_boxed_str());
                b
            })
            .collect()
    }

    fn base_path() -> PathBuf {
        PathBuf::from("collections")
    }

    fn save(&self) -> anyhow::Result<()> {
        for file_name in Self::file_names() {
            let storage = StorageLoader::new(file_name.to_owned(), Self::base_path());
            storage.save(self)?;
        }
        Ok(())
    }
}

#[derive(Debug, Deserialize, Serialize, Clone)]
pub struct ModLoader {
    pub r#type: ModLoaderType,
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