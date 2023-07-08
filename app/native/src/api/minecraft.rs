use anyhow::{Context, Result};
use async_semaphore::Semaphore;
use core::fmt;
use futures::{stream::FuturesUnordered, StreamExt};
use reqwest::Url;
use serde::{Deserialize, Serialize};
use serde_json::Value;
use std::{
    collections::HashMap,
    path::PathBuf,
    sync::{
        atomic::Ordering,
        atomic::{AtomicBool, AtomicUsize},
        Arc,
    },
    time::Duration,
};
use tokio::{
    fs::{self, File},
    io::{AsyncReadExt, AsyncWriteExt, BufReader},
    time::{self, Instant},
};

#[derive(Debug, PartialEq, Serialize, Deserialize)]
enum ActionType {
    #[serde(rename = "allow")]
    Allow,
    #[serde(rename = "disallow")]
    Disallow,
}

#[derive(Debug, PartialEq, Serialize, Deserialize, Clone, Copy)]
enum OsName {
    #[serde(rename = "osx")]
    Osx,
    #[serde(rename = "windows")]
    Windows,
    #[serde(rename = "linux")]
    Linux,
}
impl fmt::Display for OsName {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Osx => write!(f, "Osx"),
            Self::Windows => write!(f, "Windows"),
            Self::Linux => write!(f, "Linux"),
        }
    }
}
#[derive(Debug, PartialEq, Serialize, Deserialize)]
struct Os {
    name: Option<OsName>,
    version: Option<String>,
    arch: Option<String>,
}
#[derive(Debug, PartialEq, Serialize, Deserialize)]
struct Rule {
    action: ActionType,
    features: Option<HashMap<String, bool>>,
    os: Option<Os>,
    value: Option<Vec<String>>,
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
struct AssetIndex {
    id: String,
    sha1: String,
    size: usize,
    #[serde(rename = "totalSize")]
    total_size: usize,
    url: String,
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
#[derive(Debug, PartialEq, Serialize, Deserialize)]
struct LibraryMetadata {
    path: String,
    sha1: String,
    size: usize,
    url: String,
}
#[derive(Debug, PartialEq, Serialize, Deserialize)]
struct LibraryArtifact {
    artifact: LibraryMetadata,
}

#[derive(Debug, PartialEq, Serialize, Deserialize)]
pub struct Library {
    downloads: LibraryArtifact,
    name: String,
    rules: Option<Vec<Rule>>,
}
fn get_rules(argument: RustOpaque<&[Value]>) -> Result<Vec<Rule>> {
    let rules: Result<Vec<Rule>, _> = argument
        .iter()
        .filter(|x| x["rules"][0].is_object())
        .map(|x| Rule::deserialize(&x["rules"][0]))
        .collect();

    rules.context("Failed to collect/serialize rules")
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

use anyhow::anyhow;

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
            .map(|x| x.to_string())
    };
    let release_url = version_manifest["versions"]
        .as_array()
        .unwrap()
        .iter()
        .find(|x| x["id"].as_str().map(|x| x.to_string()) == version)
        .unwrap()["url"]
        .as_str()
        .unwrap();
    let target = release_url;
    let response = reqwest::get(target).await?;
    let contents: Value = response.json().await?;
    Ok((contents, version.unwrap().to_string()))
}

pub async fn process_download() -> Result<(
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
        rules: get_rules(RustOpaque::new(&game_argument))?,
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

    classpath_list.push(client_jar.to_string());
    let classpath = classpath_list.join(":");

    let jvm_argument = game_manifest["arguments"]["jvm"]
        .as_array()
        .ok_or_else(|| anyhow!("Failure to parse contents[\"arguments\"][\"jvm\"]"))?;
    let jvm_flags = JvmFlags {
        rules: get_rules(RustOpaque::new(jvm_argument))?,
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
        library_directory: "library".to_string(),
        game_directory: ".minecraft".to_string(),
        native_directory: format!(".minecraft/versions/{}/natives", current_version),
    };

    let max_concurrent_tasks = 64;
    let semaphore = Arc::new(Semaphore::new(max_concurrent_tasks));

    let current_size = Arc::new(AtomicUsize::new(0));
    let library_path = Arc::new(PathBuf::from(jvm_options.library_directory));
    let native_library_path = Arc::new(PathBuf::from(jvm_options.native_directory));
    let (mut handles, total_size) = parallel_library(
        library_list,
        library_path,
        native_library_path,
        Arc::clone(&current_size),
        &semaphore,
    )
    .await?;

    let client_download = || {
        let client_jar_future = download_file(
            downloads_list.client.url.to_string(),
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
    let (asset_download_list, asset_download_hash, asset_download_path, asset_download_size) =
        extract_assets(asset_index).await?;

    parallel_assets(
        asset_download_list,
        asset_download_hash,
        asset_download_path,
        asset_download_size,
        &semaphore,
        &current_size,
        &total_size,
        &mut handles,
    )
    .await?;
    // progress(&current_size, &total_size, &mut handles).await?;
    Ok((current_size.clone(), total_size.clone(), handles))
}

use flutter_rust_bridge::{rust2dart::Rust2Dart, RustOpaque, StreamSink};
pub async fn progress(
    current_size: &Arc<AtomicUsize>,
    total_size: &Arc<AtomicUsize>,
    handles: &mut FuturesUnordered<tokio::task::JoinHandle<std::result::Result<(), anyhow::Error>>>,
    sink: StreamSink<usize>,
) -> Result<()> {
    let a = StreamSink::new(Rust2Dart::new(0));
    let download_complete = Arc::new(AtomicBool::new(false));
    let download_complete_clone = Arc::clone(&download_complete);
    let current_size_clone = Arc::clone(&current_size);
    let total_size_clone = Arc::clone(&total_size);
    let instant = Instant::now();
    let task = tokio::spawn(async move {
        while !download_complete_clone.load(Ordering::Acquire) {
            time::sleep(Duration::from_millis(10)).await;
            sink.add(current_size_clone.load(Ordering::Relaxed));
            // if total_size_clone.load(Ordering::Relaxed) == 0 {
            //     println!("everything has been downloaded!");
            // } else {
            //     println!(
            //         "{:.2}%, {:.2} MiBs, {}/{}",
            //         current_size_clone.load(Ordering::Relaxed) as f64
            //             / total_size_clone.load(Ordering::Relaxed) as f64
            //             * 100.0,
            //         current_size_clone.load(Ordering::Relaxed) as f64
            //             / instant.elapsed().as_secs_f64()
            //             / 1_000_000.0,
            //         current_size_clone.load(Ordering::Relaxed),
            //         total_size_clone.load(Ordering::Relaxed)
            //     );
            // }
        }
    });

    while let Some(handle) = handles.next().await {
        handle??;
    }

    download_complete.store(true, Ordering::Release);
    task.await?;
    Ok(())
}

async fn parallel_assets(
    asset_download_list: Vec<String>,
    asset_download_hash: Vec<String>,
    asset_download_path: Vec<PathBuf>,
    asset_download_size: Vec<usize>,
    semaphore: &Arc<Semaphore>,
    current_size: &Arc<AtomicUsize>,
    total_size: &Arc<AtomicUsize>,
    handles: &mut FuturesUnordered<tokio::task::JoinHandle<std::result::Result<(), anyhow::Error>>>,
) -> Result<()> {
    let asset_download_list_arc = Arc::new(asset_download_list);
    let asset_download_hash_arc = Arc::new(asset_download_hash);
    let asset_download_path_arc = Arc::new(asset_download_path);
    let asset_download_size_arc = Arc::new(asset_download_size);
    for index in 0..asset_download_list_arc.len() {
        let asset_download_list_clone = Arc::clone(&asset_download_list_arc);
        let asset_download_path_clone = Arc::clone(&asset_download_path_arc);
        let semaphore_clone = Arc::clone(semaphore);
        let current_size_clone = Arc::clone(current_size);
        fs::create_dir_all(
            asset_download_path_clone[index]
                .parent()
                .ok_or_else(|| anyhow!("can't find asset_download's parent dir"))?,
        )
        .await?;
        let okto_download = if asset_download_path_clone[index].exists() {
            if let Err(x) = validate_sha1(
                &asset_download_path_clone[index],
                &asset_download_hash_arc[index],
            )
            .await
            {
                eprintln!("{x}, \nredownloading.");
                true
            } else {
                false
            }
        } else {
            true
        };
        if okto_download {
            total_size.fetch_add(asset_download_size_arc[index], Ordering::Relaxed);
            handles.push(tokio::spawn(async move {
                let _permit = semaphore_clone.acquire().await;
                download_file(
                    asset_download_list_clone[index].to_string(),
                    Some(&asset_download_path_clone[index]),
                    current_size_clone,
                )
                .await
            }));
        }
    }
    Ok(())
}
async fn validate_sha1(file_path: &PathBuf, sha1: &str) -> Result<()> {
    use sha1::{Digest, Sha1};
    let file = File::open(file_path).await?;
    let mut buffer = Vec::new();
    let mut reader = BufReader::new(file);
    reader.read_to_end(&mut buffer).await?;

    let mut hasher = Sha1::new();
    hasher.update(&buffer);
    let result = &hasher.finalize()[..];

    if result != hex::decode(sha1)? {
        return Err(anyhow!(
            r#"
{} hash don't fit!
get: {}
expected: {}
"#,
            file_path.to_string_lossy(),
            hex::encode(result),
            sha1
        ));
    }

    Ok(())
}

async fn extract_assets(
    asset_index: AssetIndex,
) -> Result<(Vec<String>, Vec<String>, Vec<PathBuf>, Vec<usize>)> {
    let asset_response = reqwest::get(asset_index.url).await?;
    let asset_index_content: Value = asset_response.json().await?;
    let asset_objects = asset_index_content["objects"]
        .as_object()
        .ok_or_else(|| anyhow!("Failure to parse asset_index_content[\"objects\"]"))?;
    let mut asset_download_list = Vec::new();
    let mut asset_download_hash = Vec::new();
    let mut asset_download_path = Vec::new();
    let mut asset_download_size: Vec<usize> = Vec::new();
    for (_, val) in asset_objects {
        asset_download_list.push(format!(
            "https://resources.download.minecraft.net/{:.2}/{}",
            val["hash"]
                .as_str()
                .ok_or_else(|| anyhow!("asset hash is not a string"))?,
            val["hash"]
                .as_str()
                .ok_or_else(|| anyhow!("asset hash is not a string"))?,
        ));
        asset_download_hash.push(
            val["hash"]
                .as_str()
                .ok_or_else(|| anyhow!("asset hash is not a string"))?
                .to_string(),
        );
        asset_download_path.push(PathBuf::from(format!(
            ".minecraft/assets/objects/{:.2}/{}",
            val["hash"]
                .as_str()
                .ok_or_else(|| anyhow!("asset hash is not a string"))?,
            val["hash"]
                .as_str()
                .ok_or_else(|| anyhow!("asset hash is not a string"))?,
        )));
        asset_download_size.push(
            val["size"]
                .as_u64()
                .ok_or_else(|| anyhow!("asset size is not u64"))?
                .try_into()?,
        );
    }
    Ok((
        asset_download_list,
        asset_download_hash,
        asset_download_path,
        asset_download_size,
    ))
}

pub async fn parallel_library(
    library_list: Vec<Library>,
    folder: Arc<PathBuf>,
    native_folder: Arc<PathBuf>,
    current: Arc<AtomicUsize>,
    semaphore: &Arc<Semaphore>,
) -> Result<(
    FuturesUnordered<tokio::task::JoinHandle<std::result::Result<(), anyhow::Error>>>,
    Arc<AtomicUsize>,
)> {
    let library_list_arc: Arc<Vec<Library>> = Arc::new(library_list);
    let index_counter = Arc::new(AtomicUsize::new(0));
    let size_counter = current;
    let download_total_size = Arc::new(AtomicUsize::new(0));
    let num_libraries = library_list_arc.len();

    let library_download_handles = FuturesUnordered::new();
    let current_os = os_version::detect()?;
    let current_os_type = match current_os {
        os_version::OsVersion::Linux(_) => OsName::Linux,
        os_version::OsVersion::Windows(_) => OsName::Windows,
        os_version::OsVersion::MacOS(_) => OsName::Osx,
        _ => panic!("not supported"),
    };

    for _ in 0..num_libraries {
        let library_list_clone = Arc::clone(&library_list_arc);
        let counter_clone = Arc::clone(&index_counter);
        let size_clone = Arc::clone(&size_counter);
        let folder = Arc::clone(&folder);
        let semaphore_clone = Arc::clone(semaphore);
        let download_total_size_clone = Arc::clone(&download_total_size);
        let native_folder_clone = Arc::clone(&native_folder);
        let handle = tokio::spawn(async move {
            let _permit = semaphore_clone.acquire().await;
            let index = counter_clone.fetch_add(1, Ordering::SeqCst);
            if index < num_libraries {
                let library = &library_list_clone[index];
                let mut os_okto_download = false;
                let path = library.downloads.artifact.path.to_string();
                let mut download_path = PathBuf::new();
                match &library.rules {
                    Some(rule) => {
                        for x in rule {
                            if let Some(os) = &x.os {
                                if let Some(name) = &os.name {
                                    if &current_os_type == name {
                                        match x.action {
                                            ActionType::Allow => {
                                                download_path = native_folder_clone.join(&path);
                                                os_okto_download = true;
                                            }
                                            ActionType::Disallow => os_okto_download = false,
                                        }
                                    }
                                }
                            } else {
                                download_path = folder.join(&path);
                            }
                        }
                    }
                    None => {
                        download_path = folder.join(&path);
                        os_okto_download = true;
                    }
                }
                let okto_download = if download_path.exists() {
                    if let Err(x) =
                        validate_sha1(&download_path, &library.downloads.artifact.sha1).await
                    {
                        eprintln!("{x}, \nredownloading.");
                        true
                    } else {
                        false
                    }
                } else {
                    true
                };
                if !os_okto_download {
                    println!("{} is not required on {}", library.name, current_os_type);
                    Ok(())
                } else if !okto_download {
                    Ok(())
                } else {
                    download_total_size_clone
                        .fetch_add(library.downloads.artifact.size, Ordering::Relaxed);
                    let parent_dir = download_path.parent().unwrap();
                    fs::create_dir_all(parent_dir).await?;
                    let url = library.downloads.artifact.url.to_string();
                    download_file(url, Some(&download_path), size_clone).await
                }
            } else {
                Ok(())
            }
        });
        library_download_handles.push(handle);
    }

    Ok((library_download_handles, download_total_size))
}
async fn download_file(
    url: String,
    name: Option<&PathBuf>,
    current_bytes: Arc<AtomicUsize>,
) -> Result<()> {
    let filename = name.map_or_else(
        || extract_filename(&url).unwrap(),
        |x| x.to_str().unwrap().to_string(),
    );
    let mut response = reqwest::get(&url).await?;
    let mut file = File::create(&filename).await?;
    while let Some(chunk) = response.chunk().await? {
        file.write_all(&chunk).await?;
        current_bytes.fetch_add(chunk.len(), Ordering::Relaxed);
    }
    Ok(())
}

fn extract_filename(url: &str) -> Result<String> {
    let parsed_url = Url::parse(url)?;
    let path_segments = parsed_url
        .path_segments()
        .ok_or_else(|| anyhow!("Invalid URL"))?;
    let filename = path_segments
        .last()
        .ok_or_else(|| anyhow!("No filename found in URL"))?;
    Ok(filename.to_string())
}
