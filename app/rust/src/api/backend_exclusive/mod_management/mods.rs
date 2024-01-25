use anyhow::bail;
use ferinth::structures::search::Facet;
use ferinth::structures::search::Sort;
use flutter_rust_bridge::frb;
use furse::structures::file_structs::HashAlgo;
use log::debug;
use once_cell::sync::Lazy;
use serde::Deserialize;
use serde::Serialize;
use std::fs::create_dir_all;
use std::path::Path;
use std::path::PathBuf;
use std::sync::atomic::AtomicUsize;
use std::sync::atomic::Ordering;
use std::sync::Arc;

use anyhow::Context;
use async_recursion::async_recursion;
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
    pub mod_version: Option<String>,
    pub tag: Vec<Tag>,
    pub overrides: Vec<ModOverride>,
    pub incompatiable_mods: Option<Vec<ModMetadata>>,
    pub mod_data: MinecraftModData,
}

#[derive(Clone, Debug, Deserialize, Serialize)]
pub enum MinecraftModData {
    Modrinth(ferinth::structures::version::Version),
    Curseforge {
        data: furse::structures::file_structs::File,
        metadata: furse::structures::file_structs::FileIndex,
    },
}

#[derive(Clone, Debug, Deserialize, Serialize)]
pub enum Project {
    Modrinth(ferinth::structures::project::Project),
    Curseforge(furse::structures::mod_structs::Mod),
}

impl From<ferinth::structures::project::Project> for Project {
    fn from(value: ferinth::structures::project::Project) -> Self {
        Self::Modrinth(value)
    }
}
impl From<furse::structures::mod_structs::Mod> for Project {
    fn from(value: furse::structures::mod_structs::Mod) -> Self {
        Self::Curseforge(value)
    }
}

impl PartialEq for MinecraftModData {
    fn eq(&self, other: &Self) -> bool {
        match (self, other) {
            (MinecraftModData::Modrinth(my), MinecraftModData::Modrinth(other)) => {
                my.files
                    .iter()
                    .zip(other.files.iter())
                    .all(|(x, y)| x.hashes.sha1 == y.hashes.sha1)
                    && my.version_number == other.version_number
            }
            (
                MinecraftModData::Curseforge {
                    data: my_data,
                    metadata: my_metadata,
                },
                MinecraftModData::Curseforge {
                    data: other_data,
                    metadata: other_metadata,
                },
            ) => {
                my_data
                    .hashes
                    .iter()
                    .zip(other_data.hashes.iter())
                    .all(|(x, y)| x.value == y.value)
                    && my_metadata.file_id == other_metadata.file_id
            }
            (
                MinecraftModData::Curseforge { data: my_data, .. },
                MinecraftModData::Modrinth(val),
            ) => my_data
                .hashes
                .iter()
                .zip(val.files.iter())
                .all(|(x, y)| x.value == y.hashes.sha1),
            (
                MinecraftModData::Modrinth(val),
                MinecraftModData::Curseforge { data: my_data, .. },
            ) => my_data
                .hashes
                .iter()
                .zip(val.files.iter())
                .all(|(x, y)| x.value == y.hashes.sha1),
        }
    }
}

impl From<ferinth::structures::version::Version> for MinecraftModData {
    fn from(value: ferinth::structures::version::Version) -> Self {
        Self::Modrinth(value)
    }
}

impl
    From<(
        furse::structures::file_structs::File,
        furse::structures::file_structs::FileIndex,
    )> for MinecraftModData
{
    fn from(
        value: (
            furse::structures::file_structs::File,
            furse::structures::file_structs::FileIndex,
        ),
    ) -> Self {
        Self::Curseforge {
            data: value.0,
            metadata: value.1,
        }
    }
}

impl Eq for MinecraftModData {}

#[derive(Clone, Debug, Deserialize, Serialize)]
#[frb(opaque)]
pub struct ModManager {
    pub mods: Vec<ModMetadata>,
    #[serde(skip)]
    cache: Option<Vec<VersionMetadata>>,

    game_directory: PathBuf,
    mod_loader: Option<ModLoader>,
    target_game_version: VersionMetadata,
}

pub static FERINTH: Lazy<ferinth::Ferinth> = Lazy::new(ferinth::Ferinth::default);
pub static FURSE: Lazy<furse::Furse> =
    Lazy::new(|| furse::Furse::new("$2a$10$bL4bIL5pUWqfcO7KQtnMReakwtfHbNKh6v1uTpKlzhwoueEJQnPnm"));

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
    pub fn get_download(&self) -> anyhow::Result<DownloadArgs> {
        let current_size = Arc::new(AtomicUsize::new(0));
        let total_size = Arc::new(AtomicUsize::new(0));
        let base_path = self.game_directory.join("mods");
        if !base_path.exists() {
            create_dir_all(&base_path)?;
        }
        let mut handles = HandlesType::new();
        for minecraft_mod in &self.mods {
            match &minecraft_mod.mod_data {
                MinecraftModData::Modrinth(minecraft_mod) => {
                    for file in &minecraft_mod.files {
                        let hash = &file.hashes.sha1;
                        let url = &file.url;
                        let filename = &file.filename;
                        let path = base_path.join(filename);
                        let size = file.size;
                        let current_size_clone = Arc::clone(&current_size);
                        let total_size_clone = Arc::clone(&total_size);
                        handles.push(Box::pin(async move {
                            if !path.exists() {
                                total_size_clone.fetch_add(size, Ordering::Relaxed);
                                let bytes = download_file(url, Some(current_size_clone)).await?;
                                fs::write(path, bytes).await?;
                            } else if let Err(x) = validate_sha1(&path, hash).await {
                                total_size_clone.fetch_add(size, Ordering::Relaxed);
                                error!("{x}");
                                let bytes = download_file(url, Some(current_size_clone)).await?;
                                fs::write(path, bytes).await?;
                            }
                            Ok(())
                        }));
                    }
                }
                MinecraftModData::Curseforge { data: file, .. } => {
                    let hashes = file
                        .hashes
                        .iter()
                        .filter(|x| x.algo == HashAlgo::Sha1)
                        .map(|x| x.value.as_ref())
                        .collect::<Vec<_>>();
                    let url = file
                        .download_url
                        .as_ref()
                        .context("Project disabled mod sharing")?;
                    let filename = &file.file_name;
                    let path = base_path.join(filename);
                    let size = file.file_length;
                    let current_size_clone = Arc::clone(&current_size);
                    let total_size_clone = Arc::clone(&total_size);
                    handles.push(Box::pin(async move {
                        if !path.exists() {
                            total_size_clone.fetch_add(size, Ordering::Relaxed);
                            let bytes = download_file(url, Some(current_size_clone)).await?;
                            fs::write(path, bytes).await?;
                        } else if !hashes_validate(&path, &hashes).await {
                            total_size_clone.fetch_add(size, Ordering::Relaxed);
                            let bytes = download_file(url, Some(current_size_clone)).await?;
                            fs::write(path, bytes).await?;
                        }
                        Ok(())
                    }));
                }
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

    // TODO: furse mode not implemetned yet
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
            let already_contained_in_collection = self.mods.iter().any(|x| match &x.mod_data {
                MinecraftModData::Modrinth(x) => x.files.iter().any(|x| x.hashes.sha1 == hash),
                MinecraftModData::Curseforge { data, .. } => data
                    .hashes
                    .iter()
                    .filter(|x| x.algo == HashAlgo::Sha1)
                    .any(|x| x.value == hash),
            });
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
        match minecraft_mod {
            MinecraftModData::Modrinth(minecraft_mod) => {
                for dept in &minecraft_mod.dependencies {
                    if let Some(dependency) = &dept.version_id {
                        let ver = FERINTH.get_version(dependency).await?;
                        self.add_mod(ver.into(), vec![Tag::Dependencies], mod_override)
                            .await?;
                    } else if let Some(project) = &dept.project_id {
                        let ver = FERINTH.get_project(project).await?;
                        self.add_project(ver.into(), vec![Tag::Dependencies], mod_override)
                            .await?;
                    }
                }
            }
            MinecraftModData::Curseforge {
                data: minecraft_mod,
                ..
            } => {
                for dept in &minecraft_mod.dependencies {
                    let project = FURSE.get_mod(dept.mod_id).await?;
                    self.add_project(project.into(), vec![Tag::Dependencies], mod_override)
                        .await?;
                }
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
        let mut is_fabric_api = false;
        let mod_metadata = match &minecraft_mod_data {
            MinecraftModData::Modrinth(minecraft_mod) => {
                if minecraft_mod.project_id == "P7dR8mSH" {
                    is_fabric_api = true;
                }
                let project = FERINTH.get_project(&minecraft_mod.project_id).await?;
                ModMetadata {
                    name: project.title,
                    long_description: project.body,
                    short_description: project.description,
                    mod_version: Some(minecraft_mod.version_number.clone()),
                    tag,
                    incompatiable_mods: None,
                    overrides: mod_override.clone(),
                    mod_data: minecraft_mod_data,
                }
            }
            MinecraftModData::Curseforge {
                data: minecraft_mod,
                ..
            } => {
                let project = FURSE.get_mod(minecraft_mod.mod_id).await?;
                ModMetadata {
                    name: project.name,
                    long_description: FURSE.get_mod_description(project.id).await?,
                    short_description: project.summary,
                    mod_version: None,
                    tag,
                    incompatiable_mods: None,
                    overrides: mod_override.clone(),
                    mod_data: minecraft_mod_data,
                }
            }
        };
        if !self.mods.contains(&mod_metadata) {
            self.mod_dependencies_resolve(&mod_metadata.mod_data, mod_override)
                .await?;
            if !is_fabric_api {
                self.mods.push(mod_metadata);
            }
        }
        Ok(())
    }

    pub async fn search_modrinth_project(
        &self,
        query: &str,
    ) -> anyhow::Result<ModrinthSearchResponse> {
        let mod_loader = self
            .mod_loader
            .as_ref()
            .with_context(|| "don't add mods in vanilla")?;
        let mod_loader_facet = Facet::Categories(mod_loader.to_string());
        let version_facet = Facet::Versions(self.target_game_version.id.to_string());
        let search_hits = FERINTH
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
            debug!("using cached game version");
            x
        } else {
            self.cache = Some(get_versions().await?);
            self.cache.as_deref().unwrap()
        };

        let modrinth = &FERINTH;

        let versions: Vec<MinecraftModData> = match project {
            Project::Modrinth(project) => modrinth
                .get_multiple_versions(
                    project
                        .versions
                        .iter()
                        .map(String::as_str)
                        .collect::<Vec<_>>()
                        .as_slice(),
                )
                .await?
                .into_iter()
                .map(|x| x.into())
                .collect::<Vec<_>>(),
            Project::Curseforge(x) => x
                .latest_files
                .into_iter()
                .zip(x.latest_files_indexes.into_iter())
                .map(|x| x.into())
                .collect::<Vec<_>>(),
        };

        let collection_mod_loader = self
            .mod_loader
            .clone()
            .with_context(|| "don't add mod in vanilla")?;

        let mut mod_loader_filter = versions
            .into_iter()
            .map(|x| {
                match x {
                    MinecraftModData::Modrinth(mut ver) => {
                        ver.files = ver.files.into_iter().filter(|x| x.primary).collect::<Vec<_>>();
                        ver.into()
                    },
                    MinecraftModData::Curseforge {..} => x,
               }
            })
            .filter(|x| {
                if mod_override.contains(&ModOverride::IgnoreModLoader) {
                    true
                } else {
                    match &x {
                        MinecraftModData::Modrinth(x) => x.loaders.iter().any(|loader| {
                            let loader = match loader.as_str() {
                                "forge" => Some(ModLoaderType::Forge),
                                "quilt" => Some(ModLoaderType::Quilt),
                                "fabric" => Some(ModLoaderType::Fabric),
                                "neoforge" => Some(ModLoaderType::NeoForge),
                                _ => None,
                            };

                            let target_quilt_compatibility = mod_override.contains(&ModOverride::QuiltFabricCompatibility);

                            let neo_forge_compatibility = collection_mod_loader.mod_loader_type == ModLoaderType::NeoForge && loader == Some(ModLoaderType::Forge);

                            let quilt_compatible = target_quilt_compatibility
                                && collection_mod_loader.mod_loader_type == ModLoaderType::Quilt
                                && loader == Some(ModLoaderType::Fabric);
                            loader.is_some_and(|x| x == collection_mod_loader.mod_loader_type)
                                || quilt_compatible || neo_forge_compatibility
                        }),
                        MinecraftModData::Curseforge{metadata, ..} => {
                            if let Some(loader) = &metadata.mod_loader {
                                let mut any = false;
                                let loader = match loader {
                                    furse::structures::common_structs::ModLoaderType::Any => { any = true; None },
                                    furse::structures::common_structs::ModLoaderType::Forge => Some(ModLoaderType::Forge),
                                    furse::structures::common_structs::ModLoaderType::Cauldron => None,
                                    furse::structures::common_structs::ModLoaderType::LiteLoader => None,
                                    furse::structures::common_structs::ModLoaderType::Fabric => Some(ModLoaderType::Fabric),
                                    furse::structures::common_structs::ModLoaderType::Quilt => Some(ModLoaderType::Quilt),
                                    furse::structures::common_structs::ModLoaderType::NeoForge => Some(ModLoaderType::NeoForge)
                                 };

                            let neo_forge_compatibility = collection_mod_loader.mod_loader_type == ModLoaderType::NeoForge && loader == Some(ModLoaderType::Forge);

                            let quilt_compatible = mod_override
                                .contains(&ModOverride::QuiltFabricCompatibility)
                                && collection_mod_loader.mod_loader_type == ModLoaderType::Quilt
                                && loader == Some(ModLoaderType::Fabric);
                            loader.is_some_and(|x| x == collection_mod_loader.mod_loader_type)
                                || quilt_compatible || any || neo_forge_compatibility

                            } else {
                                false
                            }
                        },
                    }
                }
            }).peekable();
        if mod_loader_filter.peek().is_none() {
            bail!(
                "Can't find suitable Mod Loader, mod loader is {:?}",
                collection_mod_loader
            );
        }
        let collection_game_version = all_game_version
            .iter()
            .find(|x| x.id == self.target_game_version.id)
            .expect("somehow can't find game versions");
        let mut possible_versions = mod_loader_filter
            .filter(|x| {
                let supported_game_versions = match x {
                    MinecraftModData::Modrinth(x) => x
                        .game_versions
                        .iter()
                        .filter_map(|x| all_game_version.iter().find(|y| &y.id == x))
                        .collect::<Vec<_>>(),
                    MinecraftModData::Curseforge { data, .. } => data
                        .game_versions
                        .iter()
                        .filter_map(|x| all_game_version.iter().find(|y| &y.id == x))
                        .collect::<Vec<_>>(),
                };

                match &**mod_override {
                    x if x.contains(&ModOverride::IgnoreAllGameVersion) => true,
                    x if x.contains(&ModOverride::IgnoreMinorGameVersion)
                        && collection_game_version.version_type == VersionType::Release =>
                    {
                        supported_game_versions
                            .iter()
                            .any(|x| minor_game_check(x, &collection_game_version.id))
                    }
                    _ => supported_game_versions
                        .iter()
                        .any(|x| x.id == collection_game_version.id),
                }
            })
            .collect::<Vec<_>>();
        possible_versions.sort_by_key(|x| match x {
            MinecraftModData::Modrinth(x) => x.date_published,
            MinecraftModData::Curseforge { data, .. } => data.file_date,
        });
        let version = if mod_override.contains(&ModOverride::IgnoreMinorGameVersion) {
            // strict game check
            if let Some(x) = possible_versions.iter().find(|x| {
                let supported_game_versions = match x {
                    MinecraftModData::Modrinth(x) => x
                        .game_versions
                        .iter()
                        .filter_map(|x| all_game_version.iter().find(|y| &y.id == x))
                        .collect::<Vec<_>>(),
                    MinecraftModData::Curseforge { data, .. } => data
                        .game_versions
                        .iter()
                        .filter_map(|x| all_game_version.iter().find(|y| &y.id == x))
                        .collect::<Vec<_>>(),
                };
                supported_game_versions
                    .iter()
                    .any(|x| x.id == collection_game_version.id)
            }) {
                Some(x.clone())
            }
            // loosen it a bit
            else {
                possible_versions.into_iter().next()
            }
        } else {
            possible_versions.into_iter().next()
        };
        self.add_mod(
            version
                .context("Can't find suitible mod with mod loader and version constraints")?
                .into(),
            tag,
            mod_override,
        )
        .await?;

        Ok(())
    }
}

fn minor_game_check(version: &&VersionMetadata, game_id: &str) -> bool {
    let target_semver = semver::Version::parse(game_id).map(|x| x.minor);
    if let (Ok(supported_version), Ok(target)) = (
        semver::Version::parse(&version.id).map(|x| x.minor),
        target_semver.as_ref(),
    ) {
        &supported_version == target
    } else {
        version.id == game_id
    }
}
async fn hashes_validate(path: impl AsRef<Path>, vec: &[&str]) -> bool {
    for p in vec {
        let is_ok = validate_sha1(path.as_ref(), p).await.is_ok();
        if is_ok {
            return true;
        }
    }
    false
}

/// `IgnoreMinorGameVersion` will behave like `IgnoreAllGameVersion` if operated on snapshots.
#[derive(Clone, Debug, Eq, PartialEq, Deserialize, Serialize)]
pub enum ModOverride {
    // ignore minor game version, using a latest-fully-compatiable mod available
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
