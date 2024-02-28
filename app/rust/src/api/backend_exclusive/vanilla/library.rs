use std::{
    path::{Path, PathBuf},
    sync::{
        atomic::{AtomicUsize, Ordering},
        Arc,
    },
};

use anyhow::{bail, Context, Result};
use log::error;
use serde::{Deserialize, Serialize};
use tokio::fs;

use anyhow::anyhow;

use crate::api::backend_exclusive::download::{download_file, validate_sha1, HandlesType};

use super::rules::{ActionType, OsName, Rule};

#[derive(Debug, PartialEq, Eq, Serialize, Deserialize, Clone)]
pub struct Library {
    pub downloads: LibraryArtifact,
    pub name: String,
    pub rules: Option<Vec<Rule>>,
}

#[derive(Debug, PartialEq, Eq, Serialize, Deserialize, Clone)]
pub struct Metadata {
    pub path: Option<String>,
    pub sha1: String,
    pub size: usize,
    pub url: String,
}

#[derive(Debug, PartialEq, Eq, Serialize, Deserialize, Clone)]
pub struct LibraryArtifact {
    pub artifact: Metadata,
}

pub fn os_match<'a>(library: &Library, current_os_type: &'a OsName) -> (bool, bool, &'a str) {
    let mut process_native = false;
    let mut is_native_library = false;
    let mut library_extension_type = "";
    if let Some(rule) = &library.rules {
        for x in rule {
            if let Some(os) = &x.os {
                if let Some(name) = os.name {
                    if current_os_type == &name && x.action == ActionType::Allow {
                        process_native = true;
                    }
                    is_native_library = true;
                    library_extension_type = match current_os_type {
                        OsName::Osx | OsName::OsxArm64 => ".dylib",
                        OsName::Linux | OsName::LinuxArm64 | OsName::LinuxArm32 => ".so",
                        OsName::Windows => ".dll",
                    }
                }
            }
        }
    }
    (process_native, is_native_library, library_extension_type)
}
pub async fn parallel_library(
    library_list_arc: Arc<[Library]>,
    folder: Arc<Path>,
    native_folder: Arc<Path>,
    current: Arc<AtomicUsize>,
    total_size: Arc<AtomicUsize>,
    library_download_handles: &mut HandlesType<'_>,
) -> Result<()> {
    let index_counter = Arc::new(AtomicUsize::new(0));
    let current_size = current;
    let num_libraries = library_list_arc.len();

    let current_os = os_version::detect()?;
    let current_os_type = match current_os {
        os_version::OsVersion::Linux(_) => OsName::Linux,
        os_version::OsVersion::Windows(_) => OsName::Windows,
        os_version::OsVersion::MacOS(_) => OsName::Osx,
        _ => bail!("not supported"),
    };

    for _ in 0..num_libraries {
        let library_list_clone = Arc::clone(&library_list_arc);
        let counter_clone = Arc::clone(&index_counter);
        let current_size_clone = Arc::clone(&current_size);
        let total_size_clone = Arc::clone(&total_size);
        let folder_clone = Arc::clone(&folder);
        let native_folder_clone = Arc::clone(&native_folder);
        let handle = Box::pin(async move {
            let index = counter_clone.fetch_add(1, Ordering::SeqCst);
            if index < num_libraries {
                let library = &library_list_clone
                    .get(index)
                    .context("Fail to get library list at index")?;
                let path = library.downloads.artifact.path.clone();
                let (process_native, is_native_library, library_extension) =
                    os_match(library, &current_os_type);
                if let Some(ref path) = path {
                    let non_native_download_path = folder_clone.join(&path);
                    let non_native_redownload = if non_native_download_path.exists() {
                        if let Err(x) = if !process_native && !is_native_library {
                            validate_sha1(
                                &non_native_download_path,
                                &library.downloads.artifact.sha1,
                            )
                            .await
                        } else {
                            Ok(())
                        } {
                            error!("{x}, \nredownloading.");
                            true
                        } else {
                            false
                        }
                    } else {
                        true
                    };
                    if !process_native && non_native_redownload {
                        total_size_clone
                            .fetch_add(library.downloads.artifact.size, Ordering::Relaxed);
                        let parent_dir = non_native_download_path
                            .parent()
                            .context("Can't find parent of non_native_download_path")?;
                        fs::create_dir_all(parent_dir)
                            .await
                            .context("Fail to create parent dir(library)")?;
                        let url = &library.downloads.artifact.url;
                        let bytes = download_file(url, Arc::clone(&current_size_clone)).await?;
                        fs::write(&non_native_download_path, bytes)
                            .await
                            .map_err(|err| anyhow!(err))?;
                    }
                }

                // always download(kinda required for now.)
                if process_native {
                    let url = &library.downloads.artifact.url;
                    total_size_clone.fetch_add(library.downloads.artifact.size, Ordering::Relaxed);
                    native_download(
                        url,
                        current_size_clone,
                        native_folder_clone,
                        library_extension,
                    )
                    .await?;
                }
                Ok(())
            } else {
                Ok(())
            }
        });

        library_download_handles.push(handle);
    }

    Ok(())
}

async fn native_download(
    url: &String,
    current_size: Arc<AtomicUsize>,
    native_folder: Arc<Path>,
    library_extension: &str,
) -> Result<()> {
    let current_size_clone = Arc::clone(&current_size);
    let bytes = download_file(url, current_size_clone).await?;

    let reader = std::io::Cursor::new(bytes);
    if let Ok(mut archive) = zip::ZipArchive::new(reader) {
        let native_temp_dir = native_folder.join("temp");
        archive.extract(native_temp_dir.as_path())?;
        for x in archive.file_names() {
            if (x.contains(library_extension) || x.contains(".sha1")) && !x.contains(".git") {
                tokio::fs::rename(
                    native_temp_dir.join(x),
                    native_folder.join(
                        PathBuf::from(x)
                            .file_name()
                            .context("can't find file name of native archive")?,
                    ),
                )
                .await
                .context("Fail to move from native_temp_dir -> native_folder")?;
            }
        }
    }
    Ok(())
}
