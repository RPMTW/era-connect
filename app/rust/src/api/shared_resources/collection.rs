pub use std::{borrow::Cow, fs::create_dir_all, path::PathBuf};
use std::{
    io::Read,
    sync::{atomic::AtomicUsize, Arc},
};

use anyhow::bail;
use chrono::{DateTime, Duration, Utc};
use flate2::bufread::GzDecoder;
use flutter_rust_bridge::frb;
use log::info;
use os_version::OsVersion;
use regex::Regex;
use serde::{Deserialize, Serialize};
use serde_with::serde_as;
use tar::Archive;
use tokio::sync::mpsc::unbounded_channel;

use crate::api::{
    backend_exclusive::{
        download::{download_file, execute_and_progress, DownloadArgs, DownloadBias},
        modding::forge::mod_loader_download,
        storage::storage_loader::StorageLoader,
        vanilla::{
            self,
            launcher::{full_vanilla_download, LaunchArgs},
            version::VersionMetadata,
        },
    },
    shared_resources::entry::DATA_DIR,
};

use super::entry::STORAGE;

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
    // this shall be in `bin`
    pub java_path: PathBuf,

    pub entry_path: PathBuf,
    launch_args: Option<LaunchArgs>,
}

#[derive(Debug, Deserialize, Serialize, Clone, Default, Eq, PartialEq, Hash)]
pub struct CollectionId(pub String);

const COLLECTION_FILE_NAME: &str = "collection.json";
const COLLECTION_BASE: &str = "collections";
const JAVA_INSTALL_BASE: &str = "java";

impl Collection {
    pub async fn launch_game(&mut self) -> anyhow::Result<()> {
        if self.launch_args.is_none() {
            self.launch_args = Some(self.download_game().await?);
            self.save()?;
        }
        vanilla::launcher::launch_game(&self.launch_args.as_ref().unwrap()).await
    }

    /// Downloads game(also verifies)
    pub async fn download_game(&self) -> anyhow::Result<LaunchArgs> {
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
        let auto_java = STORAGE.global_settings.read().await.auto_java;
        let java_path = PathBuf::new();
        let mut collection = Collection {
            display_name,
            minecraft_version: version_metadata,
            mod_loader,
            created_at: now_time,
            updated_at: now_time,
            played_time: Duration::seconds(0),
            advanced_options,
            java_path,
            entry_path,
            launch_args: None,
        };

        if auto_java {
            collection.auto_java_install().await?;
        }

        collection.save()?;

        Ok(collection)
    }

    // Side-Effect: modfies entry_path
    async fn auto_java_install(&mut self) -> anyhow::Result<()> {
        if let Some(java_path) = self.locate_auto_java_installation()? {
            self.java_path = java_path;
            return Ok(());
        }
        self.auto_java_download().await?;
        info!("Java download complete!");
        if let Some(java_path) = self.locate_auto_java_installation()? {
            self.java_path = java_path;
            return Ok(());
        }
        Ok(())
    }

    async fn auto_java_download(&mut self) -> anyhow::Result<()> {
        let version = &self.minecraft_version;
        let recommended_java_version = version.get_recommended_java_version().to_string();
        let java_install_base = Self::get_java_install_base();
        let os = os_version::detect()?;
        let os = match os {
            OsVersion::Linux(x) if x.distro == "Alpine" => "alpine-linux",
            OsVersion::Linux(x) if x.distro == "solaris" => "solaris",
            OsVersion::Linux(_) => "linux",
            OsVersion::MacOS(_) => "mac",
            OsVersion::Windows(_) => "windows",
            _ => bail!("Unsupported platform"),
        };
        let arch = std::env::consts::ARCH.to_string();
        let reqwest_string = format!("https://api.adoptium.net/v3/binary/latest/{feature_version}/{release_type}/{os}/{arch}/{image_type}/{jvm_impl}/{heap_size}/{vendor}", 
            feature_version = recommended_java_version,
            release_type = "ga",
            image_type="jre",
            jvm_impl = "hotspot",
            heap_size = "normal", 
            vendor = "eclipse");
        let max = reqwest::get(&reqwest_string).await?.content_length();
        let current_size = Arc::new(AtomicUsize::new(0));
        let current_size_clone = Arc::clone(&current_size);
        let handle = Box::pin(async move {
            let bytes = download_file(reqwest_string, current_size_clone).await?;
            let cursor = std::io::Cursor::new(bytes);
            let tar = GzDecoder::new(cursor);
            let mut archive = Archive::new(tar);
            archive.unpack(java_install_base)?;
            Ok(())
        });
        let download_args = if let Some(max) = max {
            DownloadArgs {
                current: current_size,
                total: Arc::new(AtomicUsize::new(max as usize)),
                handles: vec![handle],
                is_size: true,
            }
        } else {
            DownloadArgs {
                current: Arc::new(AtomicUsize::new(100)),
                total: Arc::new(AtomicUsize::new(100)),
                handles: vec![handle],
                is_size: false,
            }
        };
        let download_bias = DownloadBias {
            start: 0.,
            end: 100.,
        };
        let collection_id = self.get_collection_id();
        execute_and_progress(
            collection_id,
            download_args,
            download_bias,
            String::from("Auto Java Download/Installation"),
        )
        .await?;
        Ok(())
    }

    fn locate_auto_java_installation(&self) -> anyhow::Result<Option<PathBuf>> {
        let auto_java_path_base = Self::get_java_install_base();
        if !auto_java_path_base.exists() {
            create_dir_all(&auto_java_path_base)?;
        }
        for path in std::fs::read_dir(auto_java_path_base)? {
            let path = path?;
            let path_str = path.file_name().to_string_lossy().to_string();
            let regex = Regex::new(r"^jdk-(\d+\.\d+\.\d+)\+\d+-jre$")?;
            let Some(c) = regex.captures(&*path_str).and_then(|x| x.get(1)) else {
                continue;
            };
            let Some((readed_java_version, _)) = c.as_str().split_once('.') else {
                continue;
            };
            let current_java_version = self
                .minecraft_version
                .get_recommended_java_version()
                .to_string();
            if readed_java_version == current_java_version {
                info!("Successfully find java");
                return Ok(Some(path.path().join("bin")));
            }
        }
        Ok(None)
    }

    pub fn get_base_path() -> PathBuf {
        DATA_DIR.join(COLLECTION_BASE)
    }

    pub fn get_java_install_base() -> PathBuf {
        DATA_DIR.join(JAVA_INSTALL_BASE)
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
    pub version: String,
}

#[derive(Debug, Deserialize, Serialize, Clone, PartialEq, Eq)]
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
