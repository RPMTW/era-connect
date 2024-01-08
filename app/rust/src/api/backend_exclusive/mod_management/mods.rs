use ferinth::structures::search::Facet;
use ferinth::structures::search::Sort;
use log::info;
use once_cell::sync::Lazy;
use serde::Deserialize;
use serde::Serialize;
use std::fs::create_dir_all;
use std::path::PathBuf;
use std::sync::atomic::AtomicUsize;
use std::sync::atomic::Ordering;
use std::sync::Arc;

use anyhow::Context;
use async_recursion::async_recursion;
use ferinth::structures::project::Project;
use log::error;
use tokio::fs;

use crate::api::backend_exclusive::vanilla::version::VersionMetadata;
use crate::api::shared_resources::collection::ModLoader;
use crate::api::{
    backend_exclusive::{
        download::{download_file, get_hash, validate_sha1, DownloadArgs, HandlesType},
        vanilla::version::{get_versions, VersionType},
    },
    shared_resources::collection::ModLoaderType,
};

pub type ModrinthSearchResponse = ferinth::structures::search::Response;

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
    cache: Option<Vec<VersionMetadata>>,
    #[serde(skip)]
    game_directory: PathBuf,
    mod_loader: Option<ModLoader>,
    target_game_version: VersionMetadata,
}

pub static FERINTH: Lazy<ferinth::Ferinth> = Lazy::new(|| ferinth::Ferinth::default());

impl PartialEq for ModManager {
    fn eq(&self, other: &Self) -> bool {
        self.mods == other.mods
    }
}
impl Eq for ModManager {}

impl ModManager {
    #[must_use]
    pub fn new(
        game_directory: PathBuf,
        mod_loader: Option<ModLoader>,
        target_game_version: VersionMetadata,
    ) -> Self {
        Self {
            mods: Vec::new(),
            cache: None,
            game_directory,
            mod_loader,
            target_game_version,
        }
    }
    pub async fn get_download(&mut self) -> anyhow::Result<DownloadArgs> {
        let current_size = Arc::new(AtomicUsize::new(0));
        let total_size = Arc::new(AtomicUsize::new(0));
        let base_path = self.game_directory.join("mods");
        if !base_path.exists() {
            create_dir_all(&base_path)?;
        }
        let mut handles = HandlesType::new();
        for minecraft_mod in &self.mods {
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
            current: Arc::clone(&current_size),
            total: Arc::clone(&total_size),
            handles,
            is_size: true,
        };

        Ok(download_args)
    }
    pub async fn scan(&mut self) -> anyhow::Result<()> {
        let modrinth = &FERINTH;
        let mod_path = self.game_directory.join("mods");
        if !mod_path.exists() {
            create_dir_all(&mod_path)?;
        }
        let dirs = mod_path.read_dir()?;
        for mod_entry in dirs {
            let mod_entry = mod_entry?;
            let path = mod_entry.path();
            let raw_hash = get_hash(&path).await?;
            let hash = hex::encode(raw_hash);
            let already_contained_in_collection = self
                .mods
                .iter()
                .any(|x| x.mod_data.0.files.iter().any(|x| x.hashes.sha1 == hash));
            if !already_contained_in_collection {
                let version = modrinth
                    .get_version_from_hash(&hash)
                    .await
                    .context("Can't find jar")?;
                self.add_mod(version.into(), vec![Tag::Explicit], &Vec::new())
                    .await?;
            }
        }

        Ok(())
    }

    #[async_recursion]
    async fn mod_dependencies_resolve(
        &mut self,
        minecraft_mod: &MinecraftModData,
        mod_override: &Vec<ModOverride>,
    ) -> anyhow::Result<()> {
        let modrinth = &FERINTH;
        for dept in &minecraft_mod.0.dependencies {
            if let Some(dependency) = &dept.version_id {
                let ver = modrinth.get_version(dependency).await?;
                self.add_mod(ver.into(), vec![Tag::Dependencies], mod_override)
                    .await?;
            } else if let Some(project) = &dept.project_id {
                let ver = modrinth.get_project(project).await?;
                self.add_project(ver, vec![Tag::Dependencies], mod_override)
                    .await?;
            }
        }
        Ok(())
    }

    #[async_recursion]
    async fn add_mod(
        &mut self,
        minecraft_mod_data: MinecraftModData,
        tag: Vec<Tag>,
        mod_override: &Vec<ModOverride>,
    ) -> anyhow::Result<()> {
        let modrinth = &FERINTH;
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
            overrides: mod_override.clone(),
            mod_data: minecraft_mod_data,
        };
        if !self.mods.contains(&mod_metadata) {
            self.mod_dependencies_resolve(&mod_metadata.mod_data, mod_override)
                .await?;
            self.mods.push(mod_metadata);
        }
        Ok(())
    }

    pub async fn search_project(&self, query: &str) -> anyhow::Result<ModrinthSearchResponse> {
        let mod_loader = self
            .mod_loader
            .as_ref()
            .with_context(|| "don't add mods in vanilla")?;
        let mod_loader_facet = Facet::Categories(mod_loader.to_string());
        let version_facet = Facet::Versions(self.target_game_version.id.to_string());
        let search_hits = (&FERINTH)
            .search(
                query,
                &Sort::Relevance,
                vec![vec![mod_loader_facet, version_facet]],
            )
            .await?;
        Ok(search_hits)
    }

    // NOTE: Hacky way of doing game version check
    #[async_recursion]
    pub async fn add_project(
        &mut self,
        project: Project,
        tag: Vec<Tag>,
        mod_override: &Vec<ModOverride>,
    ) -> anyhow::Result<()> {
        let all_game_version = if let Some(x) = self.cache.as_deref() {
            info!("use cached game version!");
            x
        } else {
            self.cache = Some(get_versions().await?);
            self.cache.as_deref().unwrap()
        };
        let modrinth = &FERINTH;

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

        let mod_loader = self
            .mod_loader
            .as_ref()
            .with_context(|| "don't add mod in vanilla")?;

        let version = versions
            .into_iter()
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
                            && mod_loader.mod_loader_type == ModLoaderType::Quilt
                            && loader == Some(ModLoaderType::Fabric);
                        loader.is_some_and(|x| x == mod_loader.mod_loader_type) || quilt_compatible
                    })
                }
            })
            .filter(|x| {
                let supported_game_versions = x
                    .game_versions
                    .iter()
                    .filter_map(|x| all_game_version.iter().find(|y| &y.id == x))
                    .collect::<Vec<_>>();
                let collection_game_version = all_game_version
                    .iter()
                    .find(|x| x.id == self.target_game_version.id)
                    .expect("somehow can't find game versions");
                if mod_override.contains(&ModOverride::IgnoreMinorGameVersion) {
                    if collection_game_version.version_type == VersionType::Release {
                        let target_semver =
                            semver::Version::parse(&collection_game_version.id).map(|x| x.minor);
                        supported_game_versions.iter().any(|x| {
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
                        supported_game_versions
                            .iter()
                            .any(|x| x.id == collection_game_version.id)
                    }
                } else if mod_override.contains(&ModOverride::IgnoreAllGameVersion) {
                    true
                } else {
                    supported_game_versions
                        .iter()
                        .any(|x| x.id == collection_game_version.id)
                }
            })
            .max_by_key(|x| x.date_published);

        self.add_mod(
            version.context("Can't find suitible mod.")?.into(),
            tag,
            mod_override,
        )
        .await?;

        Ok(())
    }
}

/// `IgnoreMinorGameVersion` will behave like `IgnoreAllGameVersion` if operated on snapshots.
#[derive(Clone, Debug, Eq, PartialEq, Deserialize, Serialize)]
pub enum ModOverride {
    IgnoreMinorGameVersion,
    IgnoreAllGameVersion,
    QuiltFabricCompatibility,
    IgnoreModLoader,
}

#[derive(Clone, Debug, Eq, PartialEq, Deserialize, Serialize)]
pub enum Tag {
    Dependencies,
    Explicit,
    Custom(String),
}
