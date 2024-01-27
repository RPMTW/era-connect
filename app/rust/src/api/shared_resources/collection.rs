pub use std::path::PathBuf;
use std::{borrow::Cow, fs::create_dir_all};

use chrono::{DateTime, Duration, Utc};
use flutter_rust_bridge::frb;
use log::info;
use regex::Regex;
use serde::{Deserialize, Serialize};
use serde_with::serde_as;

pub use crate::api::backend_exclusive::storage::storage_loader::StorageLoader;

use crate::api::{
    backend_exclusive::{
        download::{execute_and_progress, DownloadBias},
        mod_management::mods::{ModManager, ModOverride, Tag, FERINTH, FURSE},
        modding::forge::mod_loader_download,
        vanilla::{
            self,
            launcher::{full_vanilla_download, LaunchArgs},
            version::VersionMetadata,
        },
    },
    shared_resources::entry::DATA_DIR,
};

#[serde_with::serde_as]
#[derive(Debug, Deserialize, Serialize, Clone, PartialEq, Eq)]
#[frb(opaque)]
pub struct Collection {
    pub display_name: String,
    pub minecraft_version: VersionMetadata,
    pub mod_loader: Option<ModLoader>,
    pub created_at: DateTime<Utc>,
    pub updated_at: DateTime<Utc>,
    #[serde_as(as = "serde_with::DurationSeconds<i64>")]
    pub played_time: Duration,
    pub advanced_options: Option<AdvancedOptions>,

    pub entry_path: PathBuf,
    pub mod_manager: ModManager,
    launch_args: Option<LaunchArgs>,
}

#[derive(Debug, Deserialize, Serialize, Clone, Default, Eq, PartialEq, Hash)]
pub struct CollectionId(pub String);

const COLLECTION_FILE_NAME: &str = "collection.json";
const COLLECTION_BASE: &str = "collections";

/// if a method has `&mut self`, remember to call `self.save()` to actually save it!
impl Collection {
    /// Creates a collection and return a collection with its loader attached
    pub fn create(
        display_name: String,
        version_metadata: VersionMetadata,
        mod_loader: Option<ModLoader>,
        advanced_options: Option<AdvancedOptions>,
    ) -> anyhow::Result<Collection> {
        let now_time = Utc::now();
        let loader = Self::create_loader(&display_name)?;
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
            launch_args: None,
        };

        collection.save()?;

        Ok(collection)
    }

    /// use project id(slug also works) to add mod, will deal with dependencies insertion
    #[frb(ignore)]
    pub async fn add_modrinth_mod(
        &mut self,
        project_id: impl AsRef<str> + Send + Sync,
        tag: Vec<Tag>,
        mod_override: Option<Vec<ModOverride>>,
    ) -> anyhow::Result<()> {
        let project_id = project_id.as_ref();
        let project = (&FERINTH).get_project(project_id).await?;
        self.mod_manager
            .add_project(project.into(), tag, mod_override.unwrap_or(Vec::new()))
            .await?;
        self.save()?;
        Ok(())
    }

    // #[frb(ignore)]
    pub async fn add_multiple_modrinth_mod(
        &mut self,
        project_ids: Vec<&str>,
        tag: Vec<Tag>,
        mod_override: Option<Vec<ModOverride>>,
    ) -> anyhow::Result<()> {
        let project = (&FERINTH).get_multiple_projects(&project_ids).await?;
        self.mod_manager
            .add_multiple_project(
                project.into_iter().map(|x| x.into()).collect::<Vec<_>>(),
                tag.clone(),
                mod_override.unwrap_or(Vec::new()),
            )
            .await?;
        self.save()?;
        Ok(())
    }
    #[frb(ignore)]
    pub async fn add_curseforge_mod(
        &mut self,
        project_id: i32,
        tag: Vec<Tag>,
        mod_override: Option<Vec<ModOverride>>,
    ) -> anyhow::Result<()> {
        let project = (&FURSE).get_mod(project_id).await?;
        self.mod_manager
            .add_project(project.into(), tag, mod_override.unwrap_or(Vec::new()))
            .await?;
        self.save()?;
        Ok(())
    }

    #[frb(ignore)]
    pub async fn download_mods(&self) -> anyhow::Result<()> {
        let id = self.get_collection_id();
        let download_args = self.mod_manager.get_download()?;
        execute_and_progress(id, download_args, DownloadBias::default()).await?;
        Ok(())
    }

    /// SIDE-EFFECT: put `launch_args` into Struct
    pub async fn launch_game(&mut self) -> anyhow::Result<()> {
        if self.launch_args.is_none() {
            self.launch_args = Some(self.verify_and_download_game().await?);
            self.save()?;
        }
        vanilla::launcher::launch_game(&self.launch_args.as_ref().unwrap()).await
    }

    #[frb(ignore)]
    pub async unsafe fn launch_game_unchecked(&self) -> anyhow::Result<()> {
        vanilla::launcher::launch_game(&self.launch_args.as_ref().unwrap_unchecked()).await
    }

    /// Downloads game(also verifies)
    pub async fn verify_and_download_game(&self) -> anyhow::Result<LaunchArgs> {
        let mod_loader_clone = self.mod_loader.clone();
        let p = if let Some(mod_loader) = mod_loader_clone {
            match mod_loader.mod_loader_type {
                ModLoaderType::Forge
                | ModLoaderType::NeoForge
                | ModLoaderType::Quilt
                | ModLoaderType::Fabric => mod_loader_download(self).await?,
                // _ => bail!("Modloader not yet implemented"),
            }
        } else {
            full_vanilla_download(self).await?
        };
        Ok(p)
    }

    pub fn game_directory(&self) -> PathBuf {
        self.entry_path.join("minecraft_root")
    }

    pub fn get_base_path() -> PathBuf {
        DATA_DIR.join(COLLECTION_BASE)
    }

    pub fn get_collection_id(&self) -> CollectionId {
        dbg!(&self.entry_path);
        CollectionId(
            self.entry_path
                .file_name()
                .unwrap()
                .to_string_lossy()
                .to_string(),
        )
    }

    pub fn save(&self) -> anyhow::Result<()> {
        StorageLoader::new(
            COLLECTION_FILE_NAME.to_string(),
            Cow::Borrowed(&self.entry_path),
        )
        .save(&self)
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

    pub fn scan() -> anyhow::Result<Vec<Collection>> {
        let mut collections = Vec::new();
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
                    let mut collection = loader.load::<Collection>()?;

                    // block_on(collection.mod_manager.scan())?;
                    info!("Succesfully scanned the mods");
                    if collection.entry_path != path {
                        collection.entry_path = path;
                        loader.save(&collection)?;
                    }
                    collections.push(collection);
                }
            }
        }
        Ok(collections)
    }
}

#[derive(Debug, Deserialize, Serialize, Clone, PartialEq, Eq)]
pub struct ModLoader {
    #[serde(rename = "type")]
    pub mod_loader_type: ModLoaderType,
    pub version: Option<String>,
}

impl ToString for ModLoader {
    fn to_string(&self) -> String {
        match self.mod_loader_type {
            ModLoaderType::Forge => String::from("forge"),
            ModLoaderType::NeoForge => String::from("neoforge"),
            ModLoaderType::Fabric => String::from("fabric"),
            ModLoaderType::Quilt => String::from("quilt"),
        }
    }
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
