use anyhow::anyhow;
use anyhow::{Context, Result};
use async_semaphore::Semaphore;
use flutter_rust_bridge::StreamSink;
use futures::{stream::FuturesUnordered, StreamExt};
use serde::{Deserialize, Serialize};
use serde_json::Value;
use std::{
    path::PathBuf,
    sync::{
        atomic::Ordering,
        atomic::{AtomicBool, AtomicUsize},
        Arc,
    },
    time::Duration,
};
use tokio::time::{self, Instant};

use super::download::assets::{extract_assets, AssetIndex};
use super::download::library::{parallel_library, Library};
use super::download::rules::{get_rules, Rule};
use super::download::util::{download_file, extract_filename, validate_sha1};

pub struct Progress {
    pub speed: f64,
    pub percentages: f64,
    pub current_size: f64,
    pub total_size: f64,
}

#[derive(Debug, PartialEq, Serialize, Deserialize)]
struct GameFlags {
    rules: Vec<Rule>,
    arguments: Vec<String>,
    additional_arguments: Option<Vec<String>>,
}
#[derive(Debug, PartialEq, Serialize, Deserialize)]
struct JvmFlags {
    rules: Vec<Rule>,
    arguments: Vec<String>,
    additional_arguments: Option<Vec<String>>,
}
#[derive(Debug, PartialEq, Serialize, Deserialize, Default)]
struct DownloadMetadata {
    sha1: String,
    size: usize,
    url: String,
}

#[derive(Debug, PartialEq, Serialize, Deserialize, Default)]
struct Downloads {
    client: DownloadMetadata,
    client_mappings: DownloadMetadata,
    server: DownloadMetadata,
    server_mappings: DownloadMetadata,
}

#[derive(Debug, PartialEq, Serialize, Deserialize, Default)]
struct LoggingConfig {
    client: ClientConfig,
}

#[derive(Debug, PartialEq, Serialize, Deserialize, Default)]
struct ClientConfig {
    argument: String,
    file: LogFile,
    #[serde(rename = "type")]
    log_type: String,
}

#[derive(Debug, PartialEq, Serialize, Deserialize, Default)]
struct LogFile {
    id: String,
    sha1: String,
    size: usize,
    url: String,
}

struct JvmArgs {
    launcher_name: String,
    launcher_version: String,
    classpath: String,
    classpath_separator: String,
    primary_jar: String,
    library_directory: String,
    game_directory: String,
    native_directory: String,
}

pub async fn get_game_manifest(
    download_target: String,
    version: Option<String>,
) -> Result<(Value, String)> {
    let response = reqwest::get(download_target).await?;
    let version_manifest: Value = response.json().await?;
    let version = if version.is_some() {
        version
    } else {
        version_manifest["latest"]["release"]
            .as_str()
            .map(ToString::to_string)
    };
    let release_url = version_manifest["versions"]
        .as_array()
        .unwrap()
        .iter()
        .find(|x| x["id"].as_str().map(ToString::to_string) == version)
        .unwrap()["url"]
        .as_str()
        .unwrap();
    let target = release_url;
    let response = reqwest::get(target).await?;
    let contents: Value = response.json().await?;
    Ok((contents, version.unwrap()))
}

pub async fn prepare_download() -> Result<(
    Arc<AtomicUsize>,
    Arc<AtomicUsize>,
    FuturesUnordered<tokio::task::JoinHandle<std::result::Result<(), anyhow::Error>>>,
)> {
    let (game_manifest, current_version) = get_game_manifest(
        "https://launchermeta.mojang.com/mc/game/version_manifest.json".to_string(),
        None,
    )
    .await?;

    let game_argument = game_manifest["arguments"]["game"]
        .as_array()
        .ok_or_else(|| anyhow!("Failure to parse contents[\"arguments\"][\"game\"]"))?;

    let game_flags = GameFlags {
        rules: get_rules(game_argument)?,
        arguments: game_argument
            .iter()
            .filter_map(Value::as_str)
            .map(std::string::ToString::to_string)
            .collect::<Vec<_>>(),
        additional_arguments: None,
    };

    let asset_index = AssetIndex::deserialize(&game_manifest["assetIndex"])
        .context("Failed to Serialize assetIndex")?;

    let downloads_list: Downloads = Downloads::deserialize(&game_manifest["downloads"])
        .context("Failed to Serialize Downloads")?;

    let library_list: Vec<Library> = Vec::<Library>::deserialize(&game_manifest["libraries"])
        .context("Failed to Serialize contents[\"libraries\"]")?;

    let logging: LoggingConfig = LoggingConfig::deserialize(&game_manifest["logging"])
        .context("Failed to Serialize logging")?;

    let main_class: String =
        String::deserialize(&game_manifest["mainClass"]).context("Failed to get MainClass")?;

    let client_jar = extract_filename(&downloads_list.client.url)?;

    let mut classpath_list = library_list
        .iter()
        .map(|x| format!("library/{}", x.downloads.artifact.path))
        .collect::<Vec<String>>();

    classpath_list.push(client_jar.clone());
    let classpath = classpath_list.join(":");

    let jvm_argument = game_manifest["arguments"]["jvm"]
        .as_array()
        .ok_or_else(|| anyhow!("Failure to parse contents[\"arguments\"][\"jvm\"]"))?;
    let jvm_flags = JvmFlags {
        rules: get_rules(jvm_argument)?,
        arguments: jvm_argument
            .iter()
            .filter_map(Value::as_str)
            .map(std::string::ToString::to_string)
            .collect::<Vec<_>>(),
        additional_arguments: None,
    };
    let jvm_options = JvmArgs {
        launcher_name: "era-connect".to_string(),
        launcher_version: "0.0.1".to_string(),
        classpath,
        classpath_separator: ":".to_string(),
        primary_jar: client_jar.to_string(),
        library_directory: "downloads/library".to_string(),
        game_directory: "downloads/.minecraft".to_string(),
        native_directory: format!("downloads/.minecraft/versions/{current_version}/natives"),
    };

    let max_concurrent_tasks = 256;
    let semaphore = Arc::new(Semaphore::new(max_concurrent_tasks));

    let current_size = Arc::new(AtomicUsize::new(0));
    let (library_path, native_path) = (
        PathBuf::from(jvm_options.library_directory),
        PathBuf::from(jvm_options.native_directory),
    );
    let library_path = Arc::new(library_path);
    let native_library_path = Arc::new(native_path);
    let mut handles = FuturesUnordered::new();
    let total_size = parallel_library(
        library_list,
        library_path,
        native_library_path,
        Arc::clone(&current_size),
        &semaphore,
        &mut handles,
    )
    .await?;

    let client_download = || {
        let client_jar_future = download_file(
            downloads_list.client.url.clone(),
            None,
            Arc::clone(&current_size),
        );
        total_size.fetch_add(downloads_list.client.size, Ordering::Relaxed);
        handles.push(tokio::spawn(async move { client_jar_future.await }));
    };

    if !PathBuf::from(extract_filename(&downloads_list.client.url)?).exists() {
        client_download();
    } else if let Err(x) = validate_sha1(
        &PathBuf::from(&extract_filename(&downloads_list.client.url)?),
        &downloads_list.client.sha1,
    )
    .await
    {
        eprintln!("{x}");
        client_download();
    }
    let asset_settings =
        extract_assets(asset_index, PathBuf::from(jvm_options.game_directory)).await?;

    super::download::assets::parallel_assets(
        asset_settings,
        &semaphore,
        &current_size,
        &total_size,
        &mut handles,
    )
    .await?;

    Ok((current_size.clone(), total_size.clone(), handles))
}

// get progress and and launch download
pub async fn get_download_progress(sink: StreamSink<Progress>) -> Result<()> {
    let (current_size, total_size, mut handles) = prepare_download().await?;
    let download_complete = Arc::new(AtomicBool::new(false));
    let download_complete_clone = Arc::clone(&download_complete);
    let current_size_clone = Arc::clone(&current_size);
    let total_size_clone = Arc::clone(&total_size);

    let task = tokio::spawn(async move {
        let mut instant = Instant::now();
        let mut prev_bytes = 0.0;
        while !download_complete_clone.load(Ordering::Acquire) {
            time::sleep(Duration::from_millis(500)).await;
            let progress = Progress {
                speed: (current_size_clone.load(Ordering::Relaxed) as f64 - prev_bytes)
                    / instant.elapsed().as_secs_f64()
                    / 1_000_000.0,
                percentages: current_size_clone.load(Ordering::Relaxed) as f64
                    / total_size_clone.load(Ordering::Relaxed) as f64
                    * 100.0,
                current_size: current_size_clone.load(Ordering::Relaxed) as f64,
                total_size: total_size_clone.load(Ordering::Relaxed) as f64,
            };
            prev_bytes = current_size_clone.load(Ordering::Relaxed) as f64;
            instant = Instant::now();
            sink.add(progress);
        }
    });

    while let Some(future) = handles.next().await {
        future??;
    }

    download_complete.store(true, Ordering::Release);
    task.await?;
    println!("Complete!");
    Ok(())
}
