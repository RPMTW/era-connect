use std::panic::{RefUnwindSafe, UnwindSafe};
pub use std::path::PathBuf;
use std::{borrow::Cow, fs::create_dir_all};

use chrono::{DateTime, Duration, Utc};
use flutter_rust_bridge::frb;
use regex::Regex;
use serde::{Deserialize, Serialize};
use serde_with::serde_as;

pub use crate::api::backend_exclusive::storage::storage_loader::StorageLoader;

use crate::api::{
    backend_exclusive::{
        download::{execute_and_progress, DownloadBias},
        mod_management::mods::{ModManager, ModOverride, Tag},
        vanilla::version::VersionMetadata,
    },
    shared_resources::entry::DATA_DIR,
};

#[serde_with::serde_as]
#[derive(Debug, Deserialize, Serialize, Clone, PartialEq, Eq)]
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
    pub mod_manager: ModManager,
}

impl UnwindSafe for ModManager {}
impl RefUnwindSafe for ModManager {}

#[derive(Debug, Deserialize, Serialize, Clone, Default, Eq, PartialEq, Hash)]
pub struct CollectionId(pub String);

pub struct TemporaryTuple(pub Collection, pub StorageLoader);

const COLLECTION_FILE_NAME: &str = "collection.json";
const COLLECTION_BASE: &str = "collections";

impl Collection {
    pub fn game_directory(&self) -> PathBuf {
        self.entry_path.join("minecraft_root")
    }

    /// Creates a collection and return a collection with its loader attached
    pub fn create(
        display_name: String,
        version_metadata: VersionMetadata,
        mod_loader: Option<ModLoader>,
        advanced_options: Option<AdvancedOptions>,
    ) -> anyhow::Result<TemporaryTuple> {
        let now_time = Utc::now();
        let loader = Collection::create_loader(display_name.clone())?;
        let entry_path = loader.base_path.clone();
        let mod_manager = ModManager::new(
            entry_path.join("minecraft_root"),
            mod_loader.clone(),
            version_metadata.clone(),
        );

        let collection = Collection {
            display_name,
            minecraft_version: version_metadata,
            mod_loader,
            created_at: now_time,
            updated_at: now_time,
            played_time: Duration::seconds(0),
            advanced_options,
            entry_path,
            mod_manager,
        };

        loader.save(&collection)?;

        Ok(TemporaryTuple(collection, loader))
    }
    /// use project id(slug also works) to add mod, will deal with dependencies insertion
    #[frb(ignore)]
    pub async fn add_mod(
        &mut self,
        project_id: impl AsRef<str> + Send + Sync,
        tag: Vec<Tag>,
        mod_override: Option<&Vec<ModOverride>>,
    ) -> anyhow::Result<()> {
        let project_id = project_id.as_ref();
        let project = self.mod_manager.ferinth.get_project(project_id).await?;
        self.mod_manager
            .add_project(project, tag, mod_override.unwrap_or(&Vec::new()))
            .await?;
        Ok(())
    }

    #[frb(ignore)]
    pub async fn download_mods(&mut self) -> anyhow::Result<()> {
        let id = self.get_collection_id();
        let download_args = self.mod_manager.get_download().await?;
        execute_and_progress(id, download_args, DownloadBias::default()).await?;
        Ok(())
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

    // HACK: temporary solution to
    fn create_loader(display_name: String) -> std::io::Result<StorageLoader> {
        // Windows file and directory name restrictions.
        let invalid_chars_regex = Regex::new(r#"[\\/:*?\"<>|]"#).unwrap();
        let reserved_names = vec![
            "CON", "PRN", "AUX", "NUL", "COM1", "COM2", "COM3", "COM4", "COM5", "COM6", "COM7",
            "COM8", "COM9", "LPT1", "LPT2", "LPT3", "LPT4", "LPT5", "LPT6", "LPT7", "LPT8", "LPT9",
        ];

        let mut dir_name = invalid_chars_regex
            .replace_all(&display_name, "")
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

        Ok(loader)
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

#[derive(Debug, Deserialize, Serialize, Clone, PartialEq, Eq)]
pub struct ModLoader {
    #[serde(rename = "type")]
    pub mod_loader_type: ModLoaderType,
    pub version: Option<String>,
}

#[derive(Debug, Deserialize, Serialize, Clone, Copy, PartialEq, Eq)]
pub enum ModLoaderType {
    Forge,
    NeoForge,
    Fabric,
    Quilt,
}

#[derive(Debug, Deserialize, Serialize, Clone, PartialEq, Eq)]
pub struct AdvancedOptions {
    pub jvm_max_memory: Option<usize>,
}
