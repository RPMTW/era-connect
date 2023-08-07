use std::{
    path::PathBuf,
    sync::{
        atomic::{AtomicUsize, Ordering},
        Arc,
    },
};

use anyhow::{bail, Context, Result};
use flutter_rust_bridge::RustOpaque;
use log::error;
use serde::{Deserialize, Serialize};
use tokio::fs;

use crate::api::vanilla::HandlesType;
use anyhow::anyhow;

use super::{
    rules::{ActionType, OsName, Rule},
    util::{download_file, validate_sha1},
};

#[derive(Debug, PartialEq, Eq, Serialize, Deserialize)]
pub struct Library {
    pub downloads: LibraryArtifact,
    pub name: String,
    pub rules: Option<Vec<Rule>>,
}

#[derive(Debug, PartialEq, Eq, Serialize, Deserialize)]
pub struct Metadata {
    pub path: String,
    pub sha1: String,
    pub size: usize,
    pub url: String,
}

#[derive(Debug, PartialEq, Eq, Serialize, Deserialize)]
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
                        OsName::Osx => ".dylib",
                        OsName::Linux => ".so",
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
    folder: Arc<RustOpaque<PathBuf>>,
    native_folder: Arc<RustOpaque<PathBuf>>,
    current: Arc<AtomicUsize>,
    library_download_handles: &mut HandlesType,
) -> Result<Arc<AtomicUsize>> {
    let index_counter = Arc::new(AtomicUsize::new(0));
    let current_size = current;
    let download_total_size = Arc::new(AtomicUsize::new(0));
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
        let folder_clone = Arc::clone(&folder);
        let download_total_size_clone = Arc::clone(&download_total_size);
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
                let non_native_download_path = folder_clone.join(&path);
                let non_native_redownload = if non_native_download_path.exists() {
                    if let Err(x) = if !process_native && !is_native_library {
                        validate_sha1(&non_native_download_path, &library.downloads.artifact.sha1)
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

                // always download(kinda required for now.)
                if process_native {
                    let url = &library.downloads.artifact.url;
                    native_download(
                        url,
                        &current_size_clone,
                        native_folder_clone,
                        library_extension,
                    )
                    .await?;
                    Ok(())
                } else if !non_native_redownload {
                    Ok(())
                } else {
                    download_total_size_clone
                        .fetch_add(library.downloads.artifact.size, Ordering::Relaxed);
                    let parent_dir = non_native_download_path
                        .parent()
                        .context("Can't find parent of non_native_download_path")?;
                    fs::create_dir_all(parent_dir)
                        .await
                        .context("Fail to create parent dir(library)")?;
                    let url = &library.downloads.artifact.url;
                    let bytes = download_file(url.clone(), Some(current_size_clone)).await?;
                    fs::write(&non_native_download_path, bytes)
                        .await
                        .map_err(|err| anyhow!(err))
                }
            } else {
                Ok(())
            }
        });

        library_download_handles.push(handle);
    }

    Ok(download_total_size)
}

async fn native_download(
    url: &String,
    current_size_clone: &Arc<AtomicUsize>,
    native_folder_clone: Arc<RustOpaque<PathBuf>>,
    library_extension: &str,
) -> Result<()> {
    let bytes = download_file(url.to_string(), Some(Arc::clone(current_size_clone))).await?;
    let reader = std::io::Cursor::new(bytes);
    if let Ok(mut archive) = zip::ZipArchive::new(reader) {
        let native_temp_dir = native_folder_clone.join("temp");
        archive.extract(native_temp_dir.as_path())?;
        for x in archive.file_names() {
            if (x.contains(library_extension) || x.contains(".sha1")) && !x.contains(".git") {
                tokio::fs::rename(
                    native_temp_dir.join(x),
                    native_folder_clone.join(
                        PathBuf::from(x)
                            .file_name()
                            .context("can't find file name of native archive")?,
                    ),
                )
                .await
                .context("Fail to move from native_temp_dir -> native_folder_clone")?;
            }
        }
    }
    Ok(())
}
