use log::info;
use rayon::prelude::*;
use serde::Deserialize;
use serde::Serialize;
use std::fs::create_dir_all;
use std::sync::atomic::AtomicUsize;
use std::sync::atomic::Ordering;
use std::sync::Arc;

use anyhow::Context;
use async_recursion::async_recursion;
use ferinth::structures::project::Project;
use log::error;
use tokio::fs;

use crate::api::backend_exclusive::vanilla::version::VersionMetadata;
use crate::api::{
    backend_exclusive::{
        download::{download_file, get_hash, validate_sha1, DownloadArgs, HandlesType},
        vanilla::version::{get_versions, VersionType},
    },
    shared_resources::collection::{Collection, ModLoaderType},
};
#[derive(Clone, Debug, Eq, PartialEq, Deserialize, Serialize)]
pub struct ModMetadata {
    pub name: String,
    pub long_description: String,
    pub short_description: String,
    pub mod_version: String,
    pub tag: Vec<Tag>,
    pub overrides: Vec<ModOverride>,
    pub incompatiable_mods: Option<Vec<ModMetadata>>,
    pub mod_data: MinecraftModData,
}

#[derive(Clone, Debug, Deserialize, Serialize)]
pub struct MinecraftModData(ferinth::structures::version::Version);

impl PartialEq for MinecraftModData {
    fn eq(&self, other: &Self) -> bool {
        self.0
            .files
            .iter()
            .zip(other.0.files.iter())
            .all(|(x, y)| x.hashes.sha1 == y.hashes.sha1)
            && self.0.version_number == other.0.version_number
    }
}

impl From<ferinth::structures::version::Version> for MinecraftModData {
    fn from(value: ferinth::structures::version::Version) -> Self {
        Self(value)
    }
}

impl Eq for MinecraftModData {}

#[derive(Clone, Debug, Deserialize, Serialize)]
pub struct ModManager {
    pub mods: Vec<ModMetadata>,
    #[serde(skip)]
    pub ferinth: ferinth::Ferinth,
    #[serde(skip)]
    cache: Option<Vec<VersionMetadata>>,
}

impl PartialEq for ModManager {
    fn eq(&self, other: &Self) -> bool {
        self.mods == other.mods
    }
}
impl Eq for ModManager {}

impl ModManager {
    pub fn new() -> Self {
        Self {
            ferinth: ferinth::Ferinth::default(),
            mods: Vec::new(),
            cache: None,
        }
    }
    pub async fn get_download(collection: &mut Collection) -> anyhow::Result<DownloadArgs> {
        let current_size = Arc::new(AtomicUsize::new(0));
        let total_size = Arc::new(AtomicUsize::new(0));
        let base_path = collection.game_directory().join("mods");
        if !base_path.exists() {
            create_dir_all(&base_path)?;
        }
        let mut handles = HandlesType::new();
        for minecraft_mod in &collection.mod_manager.mods {
            for file in &minecraft_mod.mod_data.0.files {
                let hash = &file.hashes.sha1;
                let url = &file.url;
                let filename = &file.filename;
                let path = base_path.join(filename);
                let current_size_clone = Arc::clone(&current_size);
                let total_size_clone = Arc::clone(&total_size);
                handles.push(Box::pin(async move {
                    if !path.exists() {
                        total_size_clone.fetch_add(file.size, Ordering::Relaxed);
                        let bytes = download_file(url, Some(current_size_clone)).await?;
                        fs::write(path, bytes).await?;
                    } else if let Err(x) = validate_sha1(&path, hash).await {
                        total_size_clone.fetch_add(file.size, Ordering::Relaxed);
                        error!("{x}");
                        let bytes = download_file(url, Some(current_size_clone)).await?;
                        fs::write(path, bytes).await?;
                    }
                    Ok(())
                }));
            }
        }

        let download_args = DownloadArgs {
            current_size: Arc::clone(&current_size),
            total_size: Arc::clone(&total_size),
            handles,
        };

        Ok(download_args)
    }
    pub async fn scan(collection: &mut Collection) -> anyhow::Result<()> {
        let modrinth = collection.mod_manager.ferinth.clone();
        let mod_path = collection.entry_path.join(".minecraft/mods");
        if !mod_path.exists() {
            create_dir_all(&mod_path)?;
        }
        let dirs = mod_path.read_dir()?;
        for mod_entry in dirs {
            let mod_entry = mod_entry?;
            let path = mod_entry.path();
            let raw_hash = get_hash(&path).await?;
            let hash = hex::encode(raw_hash);
            let already_contained_in_collection = collection.mod_manager.mods.iter().any(|x| {
                x.mod_data
                    .0
                    .files
                    .iter()
                    .map(|x| &x.hashes.sha1)
                    .any(|x| x == &hash)
            });
            if !already_contained_in_collection {
                let version = modrinth
                    .get_version_from_hash(&hash)
                    .await
                    .context("Can't find jar")?;
                Self::add_mod(version.into(), vec![Tag::Explicit], &Vec::new(), collection).await?;
            }
        }

        Ok(())
    }

    #[async_recursion]
    async fn mod_dependencies_resolve(
        minecraft_mod: &MinecraftModData,
        mod_override: &Vec<ModOverride>,
        collection: &mut Collection,
    ) -> anyhow::Result<()> {
        let modrinth = collection.mod_manager.ferinth.clone();
        for dept in &minecraft_mod.0.dependencies {
            if let Some(dependency) = &dept.version_id {
                let ver = modrinth.get_version(dependency).await?;
                Self::add_mod(
                    ver.into(),
                    vec![Tag::Dependencies],
                    &mod_override,
                    collection,
                )
                .await?;
            } else if let Some(project) = &dept.project_id {
                let ver = modrinth.get_project(project).await?;
                Self::add_project(ver, vec![Tag::Dependencies], &mod_override, collection).await?;
            }
        }
        Ok(())
    }

    #[async_recursion]
    pub async fn add_mod(
        minecraft_mod_data: MinecraftModData,
        tag: Vec<Tag>,
        mod_override: &Vec<ModOverride>,
        collection: &mut Collection,
    ) -> anyhow::Result<()> {
        let modrinth = collection.mod_manager.ferinth.clone();
        let project = modrinth
            .get_project(&minecraft_mod_data.0.project_id)
            .await?;
        let mod_metadata = ModMetadata {
            name: project.title,
            long_description: project.body,
            short_description: project.description,
            mod_version: minecraft_mod_data.0.version_number.clone(),
            tag,
            incompatiable_mods: None,
            overrides: mod_override.to_vec(),
            mod_data: minecraft_mod_data,
        };
        if !collection
            .mod_manager
            .mods
            .iter()
            .any(|x| x.mod_data == mod_metadata.mod_data)
        {
            Self::mod_dependencies_resolve(&mod_metadata.mod_data, mod_override, collection)
                .await?;
            collection.mod_manager.mods.push(mod_metadata);
        }
        Ok(())
    }

    // NOTE: Hacky way of doing game version check
    #[async_recursion]
    pub async fn add_project(
        project: Project,
        tag: Vec<Tag>,
        mod_override: &Vec<ModOverride>,
        collection: &mut Collection,
    ) -> anyhow::Result<()> {
        let all_game_version = if let Some(x) = collection.mod_manager.cache.as_deref() {
            info!("use cached game version!");
            x
        } else {
            collection.mod_manager.cache = Some(get_versions().await?);
            collection.mod_manager.cache.as_deref().unwrap()
        };
        let modrinth = collection.mod_manager.ferinth.clone();

        let mod_loader = collection
            .mod_loader
            .as_ref()
            .context("wtf don't add mods in vanilla")?
            .mod_loader_type;
        let versions = modrinth
            .get_multiple_versions(
                project
                    .versions
                    .iter()
                    .map(String::as_str)
                    .collect::<Vec<_>>()
                    .as_slice(),
            )
            .await?;

        let version = versions
            .into_par_iter()
            .filter(|x| {
                if mod_override.contains(&ModOverride::IgnoreModLoader) {
                    true
                } else {
                    x.loaders.iter().any(|loader| {
                        let loader = match loader.as_str() {
                            "forge" => Some(ModLoaderType::Forge),
                            "quilt" => Some(ModLoaderType::Quilt),
                            "fabric" => Some(ModLoaderType::Fabric),
                            "neoforge" => Some(ModLoaderType::NeoForge),
                            _ => None,
                        };

                        let quilt_compatible = mod_override
                            .contains(&ModOverride::QuiltFabricCompatibility)
                            && mod_loader == ModLoaderType::Quilt
                            && loader == Some(ModLoaderType::Fabric);
                        loader.is_some_and(|x| x == mod_loader) || quilt_compatible
                    })
                }
            })
            .filter(|x| {
                let versions = x
                    .game_versions
                    .iter()
                    .filter_map(|x| all_game_version.iter().find(|y| &y.id == x))
                    .collect::<Vec<_>>();
                if mod_override.contains(&ModOverride::IgnoreAllGameVersion) {
                    true
                } else if mod_override.contains(&ModOverride::IgnoreMinorGameVersion) {
                    let collection_minecraft_version = &collection.minecraft_version;
                    let collection_game_version = all_game_version
                        .iter()
                        .find(|x| x.id == collection_minecraft_version.id)
                        .expect("somehow can't find game versions");

                    if collection_game_version.version_type == VersionType::Release {
                        let target_semver =
                            semver::Version::parse(&collection_game_version.id).map(|x| x.minor);
                        versions.iter().any(|x| {
                            if let (Ok(supported_version), Ok(target)) = (
                                semver::Version::parse(&x.id).map(|x| x.minor),
                                target_semver.as_ref(),
                            ) {
                                &supported_version == target
                            } else {
                                x.id == collection_game_version.id
                            }
                        })
                    } else {
                        versions.iter().any(|x| x.id == collection_game_version.id)
                    }
                } else {
                    true
                }
            })
            .max_by(|x, y| x.date_published.cmp(&y.date_published));

        Self::add_mod(
            version.context("Can't find suitible mod")?.into(),
            tag,
            mod_override,
            collection,
        )
        .await?;

        Ok(())
    }
}

/// `IgnoreMinorGameVersion` will behave like `IgnoreAllGameVersion` if operated on snapshots.
#[derive(Clone, Debug, Eq, PartialEq, Deserialize, Serialize)]
pub enum ModOverride {
    IgnoreMinorGameVersion,
    QuiltFabricCompatibility,
    IgnoreAllGameVersion,
    IgnoreModLoader,
}

#[derive(Clone, Debug, Eq, PartialEq, Deserialize, Serialize)]
pub enum Tag {
    Dependencies,
    Explicit,
    Custom(String),
}
