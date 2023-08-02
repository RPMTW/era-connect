use std::{
    path::PathBuf,
    sync::{
        atomic::{AtomicBool, AtomicUsize, Ordering},
        Arc,
    },
    time::{Duration, Instant},
};

use anyhow::{anyhow, Context, Result};
use serde::{Deserialize, Serialize};
use serde_json::Value;
use tokio::{fs, time};

use super::{
    download::util::{download_file, validate_sha1},
    vanilla::{join_futures, HandlesType},
    DownloadArgs, GameOptions, JvmOptions, LaunchArgs, Progress, State, STATE,
};
#[derive(Debug, Serialize, Deserialize, Clone)]
struct Processors {
    jar: String,
    classpath: Vec<String>,
    args: Vec<String>,
    sides: Option<Vec<String>>,
}
#[derive(Debug, Serialize, Deserialize, Clone)]
#[serde(rename_all = "SCREAMING_SNAKE_CASE")]
struct ProcessorData {
    merged_mappings: ProcessorsDataType,
    mappings: ProcessorsDataType,
    mc_extra: ProcessorsDataType,
    mc_extra_sha: ProcessorsDataType,
    mc_slim: ProcessorsDataType,
    mc_slim_sha: ProcessorsDataType,
    mc_unpacked: ProcessorsDataType,
    mc_srg: ProcessorsDataType,
    mcp_version: ProcessorsDataType,
    mojamps: ProcessorsDataType,
    patched: ProcessorsDataType,
    patched_sha: ProcessorsDataType,
    binpatch: ProcessorsDataType,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
struct ProcessorsDataType {
    client: String,
    server: String,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
struct ForgeLibrary {
    downloads: Option<ForgeLibraryDownloadMetadata>,
    name: String,
    url: Option<String>,
    include_in_classpath: bool,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
struct ForgeLibraryDownloadMetadata {
    artifact: ForgeLibraryArtifact,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
struct ForgeLibraryArtifact {
    path: String,
    sha1: String,
    size: usize,
    url: String,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
struct ForgeLaunchArguments {
    jvm: Vec<String>,
    game: Vec<String>,
}

pub async fn prepare_forge_download(
    launch_args: LaunchArgs,
    jvm_options: JvmOptions,
    game_options: GameOptions,
) -> Result<(DownloadArgs, Value)> {
    // refactor
    let bytes = download_file(
        "https://meta.modrinth.com/forge/v0/versions/1.20.1-forge-47.1.43.json".to_string(),
        None,
    )
    .await?;
    let current_size = Arc::new(AtomicUsize::new(0));
    let total_size = Arc::new(AtomicUsize::new(0));
    let forge_manifest: Value = serde_json::from_slice(&bytes)?;
    let libraries: Vec<ForgeLibrary> =
        Vec::<ForgeLibrary>::deserialize(&forge_manifest["libraries"])?;
    // NOTE: rust can't dedcue the type here(cause dyn trait)
    let mut handles: HandlesType = Vec::new();
    let mut classpath = Vec::new();
    let library_directory = jvm_options.library_directory.clone();

    for library in libraries {
        if let Some(download) = library.downloads {
            let current_size_clone = Arc::clone(&current_size);
            let total_size_clone = Arc::clone(&total_size);
            let artifact = download.artifact;
            let path = library_directory.join(artifact.path);
            let url = artifact.url;

            if library.include_in_classpath {
                classpath.push(path.to_string_lossy().to_string());
            }

            handles.push(Box::pin(async move {
                if !path.exists() {
                    fs::create_dir_all(path.parent().unwrap()).await?;
                    total_size_clone.fetch_add(artifact.size, Ordering::Relaxed);
                    let bytes = download_file(url, Some(current_size_clone)).await?;
                    fs::write(path, bytes).await.map_err(|err| anyhow!(err))
                } else if let Err(err) = validate_sha1(&path, &url).await {
                    total_size_clone.fetch_add(artifact.size, Ordering::Relaxed);
                    eprintln!("{err}");
                    let bytes = download_file(url, Some(current_size_clone)).await?;
                    fs::write(path, bytes).await.map_err(|err| anyhow!(err))
                } else {
                    Ok(())
                }
            }));
        }
    }

    *STATE.write().await = State::Downloading;

    Ok((
        DownloadArgs {
            current_size: Arc::clone(&current_size),
            total_size: Arc::clone(&total_size),
            handles,
            launch_args,
            jvm_args: jvm_options,
            game_args: game_options,
        },
        forge_manifest,
    ))
}

pub async fn process_forge(
    launch_args: LaunchArgs,
    jvm_options: JvmOptions,
    game_options: GameOptions,
    manifest: Value,
) -> Result<()> {
    let mut data = ProcessorData::deserialize(&manifest["data"])?;
    let folder = jvm_options.library_directory.to_string_lossy().to_string();
    data.merged_mappings.client = convert_maven_to_path(&data.merged_mappings.client, &folder);
    data.mappings.client = convert_maven_to_path(&data.mappings.client, &folder);
    Ok(())
}

fn convert_maven_to_path(str: &str, folder: &str) -> String {
    let mut a = super::quilt::convert_maven_to_path(str).replace("@", ".");
    a.insert_str(1, format!("{}/", folder).as_str());
    a
}
