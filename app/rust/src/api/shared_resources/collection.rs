pub use std::{borrow::Cow, fs::create_dir_all, path::PathBuf};

use anyhow::bail;
use chrono::{DateTime, Duration, Utc};
use flutter_rust_bridge::frb;
use log::info;
use regex::Regex;
use serde::{Deserialize, Serialize};
use serde_with::serde_as;

use crate::api::{
    backend_exclusive::{
        modding::{forge::full_forge_download, quilt::full_quilt_download},
        storage::storage_loader::StorageLoader,
        vanilla::{
            self,
            launcher::{full_vanilla_download, LaunchArgs},
            version::VersionMetadata,
        },
    },
    shared_resources::entry::DATA_DIR,
};

#[serde_with::serde_as]
#[derive(Debug, Deserialize, Serialize, Clone)]
pub struct Collection {
    pub display_name: String,
    pub minecraft_version: VersionMetadata,
    pub mod_loader: Option<ModLoader>,
    pub created_at: DateTime<Utc>,
    pub updated_at: DateTime<Utc>,
    #[serde_as(as = "serde_with::DurationSeconds<i64>")]
    pub played_time: Duration,
    pub advanced_options: Option<AdvancedOptions>,

    #[serde(skip)]
    pub entry_path: PathBuf,
    #[serde(skip)]
    launch_args: Option<LaunchArgs>,
}

#[derive(Debug, Deserialize, Serialize, Clone, Default, Eq, PartialEq, Hash)]
pub struct CollectionId(pub String);

const COLLECTION_FILE_NAME: &str = "collection.json";
const COLLECTION_BASE: &str = "collections";

impl Collection {
    pub async fn launch_game(&mut self) -> anyhow::Result<()> {
        if self.launch_args.is_none() {
            self.download_game().await?;
        }
        vanilla::launcher::launch_game(&self.launch_args.as_ref().unwrap()).await
    }

    /// SIDE-EFFECT: put launch_args into Struct; download game, but also verifies
    pub async fn download_game(&mut self) -> anyhow::Result<()> {
        let mod_loader_clone = self.mod_loader.clone();
        let p = if let Some(mod_loader) = mod_loader_clone {
            match mod_loader.mod_loader_type {
                ModLoaderType::Forge | ModLoaderType::NeoForge => {
                    full_forge_download(&self).await?
                }
                ModLoaderType::Quilt => full_quilt_download(&self).await?,
                _ => bail!("you useless!"),
            }
        } else {
            full_vanilla_download(&self).await?
        };
        self.launch_args = Some(p);
        Ok(())
    }

    pub fn game_directory(&self) -> PathBuf {
        self.entry_path.join("minecraft_root")
    }

    /// Creates a collection and return a collection
    pub async fn create(
        display_name: String,
        version_metadata: VersionMetadata,
        mod_loader: Option<ModLoader>,
        advanced_options: Option<AdvancedOptions>,
    ) -> anyhow::Result<Collection> {
        let now_time = Utc::now();
        let loader = Self::create_loader(&display_name)?;
        let entry_path = loader.base_path.clone();

        let collection = Collection {
            display_name,
            minecraft_version: version_metadata,
            mod_loader,
            created_at: now_time,
            updated_at: now_time,
            played_time: Duration::seconds(0),
            advanced_options,
            entry_path,
            launch_args: None,
        };

        loader.save(&collection)?;

        Ok(collection)
    }

    pub fn get_base_path() -> PathBuf {
        DATA_DIR.join(COLLECTION_BASE)
    }

    pub fn get_collection_id(&self) -> CollectionId {
        CollectionId(
            self.entry_path
                .file_name()
                .unwrap()
                .to_string_lossy()
                .to_string(),
        )
    }

    pub fn get_loader(&self) -> anyhow::Result<StorageLoader> {
        let p = Self::create_loader(&self.display_name)?;
        Ok(p)
    }

    fn create_loader(display_name: &str) -> std::io::Result<StorageLoader> {
        // Windows file and directory name restrictions.
        let invalid_chars_regex = Regex::new(r#"[\\/:*?\"<>|]"#).unwrap();
        let reserved_names = vec![
            "CON", "PRN", "AUX", "NUL", "COM1", "COM2", "COM3", "COM4", "COM5", "COM6", "COM7",
            "COM8", "COM9", "LPT1", "LPT2", "LPT3", "LPT4", "LPT5", "LPT6", "LPT7", "LPT8", "LPT9",
        ];

        let mut dir_name = invalid_chars_regex
            .replace_all(display_name, "")
            .to_string();
        if reserved_names.contains(&dir_name.to_uppercase().as_str()) {
            dir_name = format!("{}_", dir_name);
        }
        if dir_name.is_empty() {
            dir_name = Self::gen_random_string();
        }

        let entry_path = Self::handle_duplicate_dir(Collection::get_base_path(), &dir_name);
        create_dir_all(&entry_path)?;
        let loader =
            StorageLoader::new(COLLECTION_FILE_NAME.to_string(), Cow::Borrowed(&entry_path));

        Ok((loader, entry_path))
    }

    fn handle_duplicate_dir(base_dir: PathBuf, dir_name: &str) -> PathBuf {
        let path = base_dir.join(dir_name);
        if !path.exists() {
            return path;
        }

        let new_dir_name = format!("{dir_name}_{}", Self::gen_random_string());

        Self::handle_duplicate_dir(base_dir, &new_dir_name)
    }

    fn gen_random_string() -> String {
        use rand::{distributions::Alphanumeric, Rng};

        rand::thread_rng()
            .sample_iter(&Alphanumeric)
            .take(5)
            .map(char::from)
            .collect()
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

                if file_name == COLLECTION_FILE_NAME {
                    let path = collection_base_dir.join(&base_entry_path);
                    let loader = StorageLoader::new(file_name.clone(), Cow::Borrowed(&path));
                    let mut a = loader.load::<Collection>()?;
                    dbg!(&a);
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
    pub mod_loader_type: ModLoaderType,
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
pub struct AdvancedOptions {
    pub jvm_max_memory: Option<usize>,
}
