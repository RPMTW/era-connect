use anyhow::bail;
use ferinth::structures::search::Facet;
use ferinth::structures::search::Sort;
use ferinth::structures::version::DependencyType;
use flutter_rust_bridge::frb;
use furse::structures::file_structs::FileRelationType;
use furse::structures::file_structs::HashAlgo;
use futures::StreamExt;
use log::debug;
use once_cell::sync::Lazy;
use serde::Deserialize;
use serde::Serialize;
use std::cmp::Reverse;
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

#[derive(Clone, Debug, Eq, Deserialize, Serialize)]
pub struct ModMetadata {
    pub name: String,
    pub project_id: ProjectId,
    pub long_description: String,
    pub short_description: String,
    pub mod_version: Option<String>,
    pub tag: Vec<Tag>,
    pub overrides: Vec<ModOverride>,
    pub incompatiable_mods: Option<Vec<ModMetadata>>,
    pub mod_data: RawModData,
}

impl PartialEq for ModMetadata {
    fn eq(&self, other: &Self) -> bool {
        self.project_id == other.project_id
    }
}

#[derive(Clone, Debug, Eq, PartialEq, Deserialize, Serialize)]
pub enum ProjectId {
    Modrinth(String),
    Curseforge(i32),
}

#[derive(Clone, Debug, Deserialize, Serialize)]
pub enum RawModData {
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

impl PartialEq for RawModData {
    fn eq(&self, other: &Self) -> bool {
        match (self, other) {
            (RawModData::Modrinth(my), RawModData::Modrinth(other)) => {
                my.files
                    .iter()
                    .zip(other.files.iter())
                    .all(|(x, y)| x.hashes.sha1 == y.hashes.sha1)
                    && my.version_number == other.version_number
            }
            (
                RawModData::Curseforge {
                    data: my_data,
                    metadata: my_metadata,
                },
                RawModData::Curseforge {
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
            (RawModData::Curseforge { data: my_data, .. }, RawModData::Modrinth(val)) => my_data
                .hashes
                .iter()
                .zip(val.files.iter())
                .all(|(x, y)| x.value == y.hashes.sha1),
            (RawModData::Modrinth(val), RawModData::Curseforge { data: my_data, .. }) => my_data
                .hashes
                .iter()
                .zip(val.files.iter())
                .all(|(x, y)| x.value == y.hashes.sha1),
        }
    }
}

impl From<ferinth::structures::version::Version> for RawModData {
    fn from(value: ferinth::structures::version::Version) -> Self {
        Self::Modrinth(value)
    }
}

impl
    From<(
        furse::structures::file_structs::File,
        furse::structures::file_structs::FileIndex,
    )> for RawModData
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

impl Eq for RawModData {}

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
                RawModData::Modrinth(minecraft_mod) => {
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
                RawModData::Curseforge { data: file, .. } => {
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
                RawModData::Modrinth(x) => x.files.iter().any(|x| x.hashes.sha1 == hash),
                RawModData::Curseforge { data, .. } => data
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
                self.add_mod(version.into(), vec![Tag::Explicit], Vec::new())
                    .await?;
            }
        }

        Ok(())
    }

    #[async_recursion]
    async fn mod_dependencies_resolve(
        &mut self,
        minecraft_mod: &RawModData,
        mod_override: Vec<ModOverride>,
    ) -> anyhow::Result<()> {
        match minecraft_mod {
            RawModData::Modrinth(minecraft_mod) => {
                for dept in &minecraft_mod.dependencies {
                    let mod_override = mod_override.clone();
                    if dept.dependency_type == DependencyType::Required {
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
            }
            RawModData::Curseforge {
                data: minecraft_mod,
                ..
            } => {
                for dept in &minecraft_mod.dependencies {
                    let mod_override = mod_override.clone();
                    if dept.relation_type == FileRelationType::RequiredDependency {
                        let project = FURSE.get_mod(dept.mod_id).await?;
                        self.add_project(project.into(), vec![Tag::Dependencies], mod_override)
                            .await?;
                    }
                }
            }
        }
        Ok(())
    }

    #[async_recursion]
    async fn add_mod(
        &mut self,
        minecraft_mod_data: RawModData,
        tag: Vec<Tag>,
        mod_override: Vec<ModOverride>,
    ) -> anyhow::Result<()> {
        let (mod_metadata, is_fabric_api) =
            Self::raw_mod_transformation(minecraft_mod_data, mod_override.clone(), tag).await?;
        if !self.mods.contains(&mod_metadata) {
            self.mod_dependencies_resolve(&mod_metadata.mod_data, mod_override)
                .await?;
            if self.mod_loader.as_ref().map(|x| x.mod_loader_type) == Some(ModLoaderType::Quilt)
                && is_fabric_api
            {
                let project = (&FERINTH).get_project("qsl").await?;
                self.add_project(project.into(), vec![Tag::Dependencies], vec![])
                    .await?;
            } else {
                self.mods.push(mod_metadata);
            }
        }
        Ok(())
    }

    async fn add_multiple_mods(
        &mut self,
        minecraft_mod_data: Vec<RawModData>,
        tag: Vec<Tag>,
        mod_override: Vec<ModOverride>,
    ) -> anyhow::Result<()> {
        let buffered = tokio_stream::iter(minecraft_mod_data.into_iter())
            .map(|mod_metadata| {
                let mod_override_cloned = mod_override.clone();
                let tag_cloned = tag.clone();
                tokio::spawn(async move {
                    let (mod_metadata, is_fabric_api) =
                        Self::raw_mod_transformation(mod_metadata, mod_override_cloned, tag_cloned)
                            .await?;
                    Ok((mod_metadata, is_fabric_api))
                })
            })
            .buffered(10)
            .collect::<Vec<_>>();
        let minecraft_mod_data = buffered
            .await
            .into_iter()
            .flatten()
            .collect::<anyhow::Result<Vec<_>>>()?;
        for (mod_metadata, is_fabric_api) in minecraft_mod_data {
            if !self.mods.contains(&mod_metadata) {
                self.mod_dependencies_resolve(&mod_metadata.mod_data, mod_override.clone())
                    .await?;
                if self.mod_loader.as_ref().map(|x| x.mod_loader_type) == Some(ModLoaderType::Quilt)
                    && is_fabric_api
                {
                    let project = (&FERINTH).get_project("qsl").await?;
                    self.add_project(project.into(), vec![Tag::Dependencies], vec![])
                        .await?;
                } else {
                    self.mods.push(mod_metadata);
                }
            }
        }
        Ok(())
    }

    async fn raw_mod_transformation(
        minecraft_mod_data: RawModData,
        mod_override: Vec<ModOverride>,
        tag: Vec<Tag>,
    ) -> anyhow::Result<(ModMetadata, bool)> {
        let mut is_fabric_api = false;
        let mod_metadata = match &minecraft_mod_data {
            RawModData::Modrinth(minecraft_mod) => {
                if minecraft_mod.project_id == "P7dR8mSH" {
                    is_fabric_api = true;
                }
                let project = FERINTH.get_project(&minecraft_mod.project_id).await?;
                ModMetadata {
                    name: project.title,
                    project_id: ProjectId::Modrinth(minecraft_mod.project_id.clone()),
                    long_description: project.body,
                    short_description: project.description,
                    mod_version: Some(minecraft_mod.version_number.clone()),
                    tag,
                    incompatiable_mods: None,
                    overrides: mod_override,
                    mod_data: minecraft_mod_data,
                }
            }
            RawModData::Curseforge {
                data: minecraft_mod,
                ..
            } => {
                let project = FURSE.get_mod(minecraft_mod.mod_id).await?;
                ModMetadata {
                    name: project.name,
                    project_id: ProjectId::Curseforge(minecraft_mod.mod_id),
                    long_description: FURSE.get_mod_description(project.id).await?,
                    short_description: project.summary,
                    mod_version: None,
                    tag,
                    incompatiable_mods: None,
                    overrides: mod_override,
                    mod_data: minecraft_mod_data,
                }
            }
        };
        Ok((mod_metadata, is_fabric_api))
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
        mod_override: Vec<ModOverride>,
    ) -> anyhow::Result<()> {
        let all_game_version = if let Some(x) = self.cache.as_deref() {
            debug!("using cached game version");
            x
        } else {
            self.cache = Some(get_versions().await?);
            self.cache.as_deref().unwrap()
        };

        let name = match &project {
            Project::Modrinth(x) => x.title.clone(),
            Project::Curseforge(x) => x.name.clone(),
        };

        let versions = get_mod_version(project).await?;

        let collection_mod_loader = self
            .mod_loader
            .as_ref()
            .with_context(|| "don't add mod in vanilla")?
            .mod_loader_type;

        let collection_game_version = all_game_version
            .iter()
            .find(|x| x.id == self.target_game_version.id)
            .context("somehow can't find game versions")?;

        let version = fetch_version_modloader_constraints(
            &name,
            all_game_version,
            collection_game_version,
            collection_mod_loader,
            versions,
            &mod_override,
        )?;

        self.add_mod(
            version
                .context(format!("Can't find suitible mod with mod loader and version constraints, project is {name}"))?
                .into(),
            tag,
            mod_override,
        )
        .await?;

        Ok(())
    }

    pub async fn add_multiple_project(
        &mut self,
        projects: Vec<Project>,
        tag: Vec<Tag>,
        mod_override: Vec<ModOverride>,
    ) -> anyhow::Result<()> {
        let all_game_version = get_versions().await?;

        let buffered_iterator = tokio_stream::iter(projects.into_iter().map(|project| {
            tokio::spawn(async {
                let name = match &project {
                    Project::Modrinth(x) => x.title.clone(),
                    Project::Curseforge(x) => x.name.clone(),
                };
                let version = get_mod_version(project).await;
                match version {
                    Ok(v) => Ok((name, v)),
                    Err(err) => Err(err),
                }
            })
        }))
        .buffered(10)
        .collect::<Vec<_>>();

        let multiple_projects = buffered_iterator
            .await
            .into_iter()
            .flatten()
            .collect::<anyhow::Result<Vec<_>>>()?;

        let multiple_mods = multiple_projects
            .into_iter()
            .map(|(name, versions)| {
                let collection_mod_loader = self
                    .mod_loader
                    .clone()
                    .with_context(|| "don't add mod in vanilla")?
                    .mod_loader_type;

                let collection_game_version = all_game_version
                    .iter()
                    .find(|x| x.id == self.target_game_version.id)
                    .context("somehow can't find game versions")?;

                let version = fetch_version_modloader_constraints(
                    &name,
                    all_game_version.as_slice(),
                    collection_game_version,
                    collection_mod_loader,
                    versions,
                    &mod_override,
                )?;
                Ok::<_, anyhow::Error>((name, version))
            })
            .collect::<anyhow::Result<Vec<_>>>()?;

        let mulitlple_mods = multiple_mods.into_iter().map(|(name, x)| {
            x
                .context(format!("Can't find suitible mod with mod loader and version constraints, project is {name}"))
        }).collect::<anyhow::Result<Vec<_>>>()?;

        self.add_multiple_mods(mulitlple_mods, tag, mod_override)
            .await?;

        Ok(())
    }
}

fn fetch_version_modloader_constraints(
    name: &str,
    all_game_versions: &[VersionMetadata],
    collection_game_version: &VersionMetadata,
    collection_mod_loader: ModLoaderType,
    versions: Vec<RawModData>,
    mod_override: &Vec<ModOverride>,
) -> anyhow::Result<Option<RawModData>> {
    let mut mod_loader_filter = versions
        .into_iter()
        .map(|x| match x {
            RawModData::Modrinth(mut ver) => {
                ver.files = ver
                    .files
                    .into_iter()
                    .filter(|x| x.primary)
                    .collect::<Vec<_>>();
                ver.into()
            }
            RawModData::Curseforge { .. } => x,
        })
        .filter(|x| {
            if mod_override.contains(&ModOverride::IgnoreModLoader) {
                true
            } else {
                match &x {
                    RawModData::Modrinth(x) => x.loaders.iter().any(|loader| {
                        let loader = match loader.as_str() {
                            "forge" => Some(ModLoaderType::Forge),
                            "quilt" => Some(ModLoaderType::Quilt),
                            "fabric" => Some(ModLoaderType::Fabric),
                            "neoforge" => Some(ModLoaderType::NeoForge),
                            _ => None,
                        };

                        let target_quilt_compatibility =
                            mod_override.contains(&ModOverride::QuiltFabricCompatibility);

                        let neo_forge_compatibility = collection_mod_loader
                            == ModLoaderType::NeoForge
                            && loader == Some(ModLoaderType::Forge);

                        let quilt_compatible = target_quilt_compatibility
                            && collection_mod_loader == ModLoaderType::Quilt
                            && loader == Some(ModLoaderType::Fabric);
                        loader.is_some_and(|x| x == collection_mod_loader)
                            || quilt_compatible
                            || neo_forge_compatibility
                    }),
                    RawModData::Curseforge { metadata, .. } => {
                        if let Some(loader) = &metadata.mod_loader {
                            let mut any = false;
                            let loader = match loader {
                                furse::structures::common_structs::ModLoaderType::Any => {
                                    any = true;
                                    None
                                }
                                furse::structures::common_structs::ModLoaderType::Forge => {
                                    Some(ModLoaderType::Forge)
                                }
                                furse::structures::common_structs::ModLoaderType::Cauldron => None,
                                furse::structures::common_structs::ModLoaderType::LiteLoader => {
                                    None
                                }
                                furse::structures::common_structs::ModLoaderType::Fabric => {
                                    Some(ModLoaderType::Fabric)
                                }
                                furse::structures::common_structs::ModLoaderType::Quilt => {
                                    Some(ModLoaderType::Quilt)
                                }
                                furse::structures::common_structs::ModLoaderType::NeoForge => {
                                    Some(ModLoaderType::NeoForge)
                                }
                            };

                            let neo_forge_compatibility = collection_mod_loader
                                == ModLoaderType::NeoForge
                                && loader == Some(ModLoaderType::Forge);

                            let quilt_compatible = mod_override
                                .contains(&ModOverride::QuiltFabricCompatibility)
                                && collection_mod_loader == ModLoaderType::Quilt
                                && loader == Some(ModLoaderType::Fabric);
                            loader.is_some_and(|x| x == collection_mod_loader)
                                || quilt_compatible
                                || any
                                || neo_forge_compatibility
                        } else {
                            false
                        }
                    }
                }
            }
        })
        .peekable();
    if mod_loader_filter.peek().is_none() {
        bail!(
            "Can't find suitable Mod Loader, mod loader is {:?}, project is {}",
            collection_mod_loader,
            name,
        );
    }
    let mut possible_versions = mod_loader_filter
        .filter(|x| {
            let supported_game_versions = match x {
                RawModData::Modrinth(x) => x
                    .game_versions
                    .iter()
                    .filter_map(|x| all_game_versions.iter().find(|y| &y.id == x))
                    .collect::<Vec<_>>(),
                RawModData::Curseforge { data, .. } => data
                    .game_versions
                    .iter()
                    .filter_map(|x| all_game_versions.iter().find(|y| &y.id == x))
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
        RawModData::Modrinth(x) => Reverse(x.date_published),
        RawModData::Curseforge { data, .. } => Reverse(data.file_date),
    });
    let version = if mod_override.contains(&ModOverride::IgnoreMinorGameVersion) {
        // strict game check
        let strict_check_version = possible_versions.iter().find(|x| {
            let supported_game_versions = match x {
                RawModData::Modrinth(x) => x
                    .game_versions
                    .iter()
                    .filter_map(|x| all_game_versions.iter().find(|y| &y.id == x))
                    .collect::<Vec<_>>(),
                RawModData::Curseforge { data, .. } => data
                    .game_versions
                    .iter()
                    .filter_map(|x| all_game_versions.iter().find(|y| &y.id == x))
                    .collect::<Vec<_>>(),
            };
            supported_game_versions
                .iter()
                .any(|x| x.id == collection_game_version.id)
        });
        if let Some(x) = strict_check_version {
            Some(x.clone())
        } else {
            possible_versions.into_iter().next()
        }
    } else {
        possible_versions.into_iter().next()
    };
    Ok(version)
}

async fn get_mod_version(project: Project) -> anyhow::Result<Vec<RawModData>> {
    let projects = match project {
        Project::Modrinth(project) => FERINTH
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
    Ok(projects)
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
