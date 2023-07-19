use std::{
    path::{Path, PathBuf},
    sync::{
        atomic::{AtomicUsize, Ordering},
        Arc,
    },
};

use anyhow::{bail, Result};
use async_semaphore::Semaphore;
use flutter_rust_bridge::RustOpaque;
use futures::stream::FuturesUnordered;
use serde::{Deserialize, Serialize};
use tokio::fs;

use super::{
    rules::{ActionType, OsName, Rule},
    util::{download_file, validate_sha1},
};

#[derive(Debug, PartialEq, Eq, Serialize, Deserialize)]
pub struct LibraryMetadata {
    pub path: String,
    pub sha1: String,
    pub size: usize,
    pub url: String,
}
#[derive(Debug, PartialEq, Eq, Serialize, Deserialize)]
pub struct LibraryArtifact {
    pub artifact: LibraryMetadata,
}

#[derive(Debug, PartialEq, Serialize, Deserialize)]
pub struct Library {
    pub downloads: LibraryArtifact,
    pub name: String,
    pub rules: Option<Vec<Rule>>,
}

pub fn os_match<'a>(library: &Library, current_os_type: &'a OsName) -> (bool, bool, &'a str) {
    let mut process_native = false;
    let mut os_okto_download = false;
    let mut library_extension_type = "";
    match &library.rules {
        Some(rule) => {
            for x in rule {
                if let Some(os) = &x.os {
                    if let Some(name) = os.name {
                        if current_os_type == &name {
                            match x.action {
                                ActionType::Allow => {
                                    process_native = true;
                                    os_okto_download = true;
                                }
                                ActionType::Disallow => os_okto_download = false,
                            }
                        }
                        library_extension_type = match current_os_type {
                            OsName::Osx => ".dylib",
                            OsName::Linux => ".so",
                            OsName::Windows => ".dll",
                        }
                    }
                }
            }
        }
        None => {
            os_okto_download = true;
        }
    }
    (process_native, os_okto_download, library_extension_type)
}
pub async fn parallel_library(
    library_list_arc: Arc<Vec<Library>>,
    folder: Arc<RustOpaque<PathBuf>>,
    native_folder: Arc<RustOpaque<PathBuf>>,
    current: Arc<AtomicUsize>,
    semaphore: &Arc<Semaphore>,
    library_download_handles: &mut FuturesUnordered<
        tokio::task::JoinHandle<std::result::Result<(), anyhow::Error>>,
    >,
) -> Result<Arc<AtomicUsize>> {
    let index_counter = Arc::new(AtomicUsize::new(0));
    let size_counter = current;
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
        let size_clone = Arc::clone(&size_counter);
        let folder_clone = folder.clone();
        let semaphore_clone = Arc::clone(semaphore);
        let download_total_size_clone = Arc::clone(&download_total_size);
        let native_folder_clone = Arc::clone(&native_folder);
        let handle = tokio::spawn(async move {
            let _permit = semaphore_clone.acquire_arc().await;
            let index = counter_clone.fetch_add(1, Ordering::SeqCst);
            if index < num_libraries {
                let library = &library_list_clone[index];
                let path = library.downloads.artifact.path.clone();
                let (process_native, os_okto_download, library_extension) =
                    os_match(library, &current_os_type);
                let download_path = folder_clone.join(&path);
                let okto_download = if download_path.exists() {
                    if let Err(x) = if process_native {
                        Ok(())
                    } else {
                        validate_sha1(&download_path, &library.downloads.artifact.sha1).await
                    } {
                        eprintln!("{x}, \nredownloading.");
                        true
                    } else {
                        false
                    }
                } else {
                    true
                };
                if !os_okto_download || !okto_download {
                    Ok(())
                } else if process_native {
                    async {
                        let url = library.downloads.artifact.url.to_string();
                        let mut response = reqwest::get(&url).await?;
                        let mut data = Vec::new();

                        while let Some(chunk) = response.chunk().await? {
                            size_clone.fetch_add(chunk.len(), Ordering::Relaxed);
                            data.extend_from_slice(&chunk);
                        }
                        let reader = std::io::Cursor::new(&data);
                        if let Ok(mut archive) = zip::ZipArchive::new(reader) {
                            archive.extract(native_folder_clone.join("temp").as_path())?;
                            for x in archive.file_names() {
                                if (x.contains(library_extension) || x.contains(".sha1"))
                                    && !x.contains(".git")
                                {
                                    std::fs::rename(
                                        native_folder_clone.join("temp").join(x),
                                        native_folder_clone
                                            .join(PathBuf::from(x).file_name().unwrap()),
                                    )?;
                                }
                            }
                        }
                        Ok(())
                    }
                    .await
                } else {
                    download_total_size_clone
                        .fetch_add(library.downloads.artifact.size, Ordering::Relaxed);
                    let parent_dir = download_path.parent().unwrap();
                    fs::create_dir_all(parent_dir).await?;
                    let url = &library.downloads.artifact.url;
                    download_file(url.clone(), Some(&download_path), size_clone).await
                }
            } else {
                Ok(())
            }
        });

        library_download_handles.push(handle);
    }

    Ok(download_total_size)
}
