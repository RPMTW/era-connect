use std::{borrow::Cow, fs::create_dir_all, path::PathBuf};

use chrono::{DateTime, Duration, Utc};
use serde::{Deserialize, Serialize};
use serde_with::serde_as;
use struct_key_value_pair::VariantStruct;

use super::{storage::storage_loader::StorageLoader, DATA_DIR};

#[serde_with::serde_as]
#[derive(Debug, Deserialize, Serialize, VariantStruct, Clone)]
pub struct Collection {
    pub display_name: String,
    pub minecraft_version: String,
    pub mod_loader: Option<ModLoader>,
    pub created_at: DateTime<Utc>,
    pub updated_at: DateTime<Utc>,
    #[serde_as(as = "serde_with::DurationSeconds<i64>")]
    pub played_time: Duration,
    pub advanced_options: AdvancedOptions,

    pub entry_path: PathBuf,
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
            entry_path: PathBuf::new(),
        }
    }
}

const COLLECTION_NAME: &str = "collections.json";
const COLLECTION_BASE: &str = "collections";

impl Collection {
    fn get_entry_name(&self) -> String {
        use rand::{distributions::Alphanumeric, Rng};

        let random_string: String = rand::thread_rng()
            .sample_iter(&Alphanumeric)
            .take(5)
            .map(char::from)
            .collect();
        format!("{}_{random_string}", self.display_name)
    }
    pub fn get_base_path() -> PathBuf {
        DATA_DIR.join(COLLECTION_BASE)
    }
    pub fn get_entry_path(&self) -> PathBuf {
        Self::get_base_path().join(self.get_entry_name())
    }
    pub fn add(display_name: String) -> anyhow::Result<StorageLoader> {
        let mut collection = Self {
            display_name,
            ..Self::default()
        };
        let entry_path = collection.get_entry_path();
        let loader = StorageLoader::new(COLLECTION_NAME.to_string(), Cow::Borrowed(&entry_path));
        create_dir_all(&entry_path)?;
        collection.entry_path = entry_path;
        loader.save(&collection)?;
        Ok(loader)
    }
    pub fn scan() -> anyhow::Result<Vec<StorageLoader>> {
        let mut loaders = Vec::new();
        let collection_base_dir = Self::get_base_path();
        create_dir_all(&collection_base_dir)?;
        let dirs = collection_base_dir.read_dir()?;

        for base_entry in dirs {
            let base_entry_path = base_entry?.path();
            for file in base_entry_path.read_dir()? {
                let file_name = file?.file_name().to_string_lossy().to_string();

                if file_name == COLLECTION_NAME {
                    let path = collection_base_dir.join(&base_entry_path);
                    let loader = StorageLoader::new(file_name.clone(), Cow::Borrowed(&path));
                    let mut a = loader.load::<Collection>()?;
                    a.entry_path = path;
                    loader.save(&a)?;
                    loaders.push(loader);
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
        Self {}
    }
}
