use anyhow::{anyhow, bail};
use anyhow::{Context, Result};
use async_semaphore::Semaphore;
use flutter_rust_bridge::{RustOpaque, StreamSink};
use futures::stream;
use futures::{stream::FuturesUnordered, StreamExt};
use glob::Pattern;
use reqwest::Response;
use serde::{Deserialize, Serialize};
use serde_json::Value;
use std::fs::{self, create_dir_all, File};
pub use std::path::PathBuf;
use std::process::Command;
use std::rc::Rc;
use std::{
    sync::{
        atomic::Ordering,
        atomic::{AtomicBool, AtomicUsize},
        Arc,
    },
    time::Duration,
};
use tokio::time::{self, Instant};

use crate::api::download::library::os_match;
use crate::api::download::rules::OsName;

use super::download::assets::{extract_assets, parallel_assets, AssetIndex};
use super::download::library::{parallel_library, Library};
use super::download::rules::{get_rules, ActionType, Rule};
use super::download::util::{download_file, extract_filename, validate_sha1};
use super::ReturnType;

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

#[derive(Clone, Debug)]
pub struct JvmArgs {
    pub launcher_name: String,
    pub launcher_version: String,
    pub classpath: String,
    pub classpath_separator: String,
    pub primary_jar: String,
    pub library_directory: RustOpaque<PathBuf>,
    pub game_directory: RustOpaque<PathBuf>,
    pub native_directory: RustOpaque<PathBuf>,
}

#[derive(Clone, Debug)]
pub struct GameArgs {
    pub auth_player_name: String,
    pub game_version_name: String,
    pub game_directory: RustOpaque<PathBuf>,
    pub assets_root: RustOpaque<PathBuf>,
    pub assets_index_name: String,
    pub auth_uuid: String,
    pub user_type: String,
    pub version_type: String,
}

#[derive(Clone, Debug)]
pub struct LaunchArgs {
    pub jvm_args: Vec<String>,
    pub main_class: String,
    pub game_args: Vec<String>,
}

pub fn launch_game(launch_args: LaunchArgs) -> Result<()> {
    let mut launch_vec = Vec::new();
    launch_vec.extend(launch_args.jvm_args);
    launch_vec.push(launch_args.main_class);
    launch_vec.extend(launch_args.game_args);
    let b = Command::new("java").args(launch_vec).spawn();
    b?.wait()?;
    Ok(())
}

#[derive(Debug, PartialEq, Serialize, Deserialize, Default, Clone)]
pub struct FabricLibrary {
    name: String,
    url: String,
}

pub async fn prepare_quilt_download(
    game_version: String,
    launch_args: LaunchArgs,
    jvm_options: JvmArgs,
    game_options: GameArgs,
) -> Result<DownloadArgs> {
    let meta_url = format!(
        "https://meta.quiltmc.org/v3/versions/loader/{}",
        game_version
    );
    let response = reqwest::get(meta_url).await?;
    let version_manifest: Value = response.json().await?;
    let current_size = Arc::new(AtomicUsize::new(0));
    let total_size = Arc::new(AtomicUsize::new(0));
    let mut download_list = Vec::<FabricLibrary>::deserialize(
        &version_manifest[0]["launcherMeta"]["libraries"]["common"],
    )?;
    let special_library_list = version_manifest[0].as_object().unwrap();
    let special = vec!["loader", "hashed", "intermediary"];
    for x in special {
        let b = special_library_list.get(x).unwrap();
        let maven = b["maven"].as_str().unwrap();
        download_list.push(FabricLibrary {
            name: maven.to_string(),
            url: if maven.contains("quiltmc") {
                "https://maven.quiltmc.org/repository/release/".to_string()
            } else {
                "https://maven.fabricmc.net/".to_string()
            },
        });
    }
    let handles = FuturesUnordered::new();
    let index_counter = Arc::new(AtomicUsize::new(0));
    let library_directory = jvm_options.library_directory.clone();
    let num_libraries = download_list.len();
    let download_list_arc = Arc::new(download_list);
    let path_vec = download_list_arc
        .iter()
        .map(|x| library_directory.join(convert_maven_to_path(&x.name)))
        .collect::<Vec<_>>();
    let url_vec = download_list_arc
        .iter()
        .map(|x| convert_maven_to_path(&x.name))
        .collect::<Vec<_>>();
    for x in path_vec.iter() {
        fs::create_dir_all(x.parent().unwrap())?;
    }
    let mut jvm_options = jvm_options;
    let mut launch_args = launch_args;
    // HACK
    jvm_options.classpath.push(':');
    jvm_options.classpath.push_str(
        &path_vec
            .iter()
            .map(|x| x.to_string_lossy().to_string())
            .collect::<Vec<_>>()
            .join(":"),
    );
    for x in 0..launch_args.jvm_args.len() {
        if launch_args.jvm_args[x] == "-cp".to_string() {
            launch_args.jvm_args[x + 1] = jvm_options.classpath.clone();
            break;
        }
    }
    dbg!(&launch_args.jvm_args);
    launch_args.main_class = version_manifest[0]["launcherMeta"]["mainClass"]["client"]
        .as_str()
        .unwrap()
        .to_string();
    let path_vec_arc = Arc::new(path_vec);
    let url_vec_arc = Arc::new(url_vec);
    for _ in 0..num_libraries {
        let index_counter_clone = Arc::clone(&index_counter);
        let current_size_clone = Arc::clone(&current_size);
        let path_vec_clone = Arc::clone(&path_vec_arc);
        let url_vec_clone = Arc::clone(&url_vec_arc);
        let download_list_clone = Arc::clone(&download_list_arc);
        handles.push(tokio::spawn(async move {
            let index = index_counter_clone.fetch_add(1, Ordering::SeqCst);
            if index < num_libraries {
                let library = &download_list_clone[index];
                let url = format!("{}{}", library.url, url_vec_clone[index]);
                let path = &path_vec_clone[index];
                download_file(url, Some(&path), current_size_clone).await
            } else {
                Ok(())
            }
        }));
    }
    Ok(DownloadArgs {
        current_size: Arc::clone(&current_size),
        total_size: Arc::clone(&total_size),
        handles,
        launch_args,
        jvm_args: jvm_options,
        game_args: game_options,
    })
}
fn convert_maven_to_path(input: &str) -> String {
    let parts: Vec<&str> = input.split(':').collect();
    let org = parts[0].replace(".", "/");
    let package = parts[1];
    let version = parts[2];
    let file_name = format!("{}-{}.jar", package, version);
    let path = format!("{}/{}/{}", org, package, version);

    format!("{}/{}", path, file_name)
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

pub async fn prepare_vanilla_download() -> Result<DownloadArgs> {
    let (game_manifest, current_version) = get_game_manifest(
        "https://launchermeta.mojang.com/mc/game/version_manifest.json".to_string(),
        None,
    )
    .await?;

    let game_argument = game_manifest["arguments"]["game"]
        .as_array()
        .ok_or_else(|| anyhow!("Failure to parse contents[\"arguments\"][\"game\"]"))?;

    let mut game_flags = GameFlags {
        rules: get_rules(game_argument)?,
        arguments: game_argument
            .iter()
            .filter_map(Value::as_str)
            .map(std::string::ToString::to_string)
            .collect::<Vec<_>>(),
        additional_arguments: None,
    };

    let game_directory = PathBuf::from("downloads/.minecraft");
    let asset_directory = PathBuf::from("downloads/.minecraft/assets");
    let library_directory = PathBuf::from("downloads/library");
    let native_directory = PathBuf::from(format!(
        "downloads/.minecraft/versions/{current_version}/natives"
    ));

    create_dir_all(&library_directory)?;
    create_dir_all(&asset_directory)?;
    create_dir_all(&game_directory)?;
    create_dir_all(&native_directory)?;

    let game_options = GameArgs {
        auth_player_name: "Kyle".to_string(),
        game_version_name: current_version,
        game_directory: RustOpaque::new(game_directory.canonicalize()?),
        assets_root: RustOpaque::new(asset_directory.canonicalize()?),
        assets_index_name: game_manifest["assetIndex"]["id"]
            .as_str()
            .unwrap()
            .to_string(),
        auth_uuid: "".to_string(),
        user_type: "mojang".to_string(),
        version_type: "release".to_string(),
    };

    game_flags.arguments = game_args_parse(&game_flags, &game_options);

    if game_flags.additional_arguments.is_some() {
        game_flags
            .arguments
            .extend(game_flags.additional_arguments.unwrap());
    }

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

    let client_jar = std::env::current_dir()?.join(extract_filename(&downloads_list.client.url)?);

    let jvm_argument = game_manifest["arguments"]["jvm"]
        .as_array()
        .ok_or_else(|| anyhow!("Failure to parse contents[\"arguments\"][\"jvm\"]"))?;
    let mut jvm_flags = JvmFlags {
        rules: get_rules(jvm_argument)?,
        arguments: jvm_argument
            .iter()
            .filter_map(Value::as_str)
            .map(std::string::ToString::to_string)
            .collect::<Vec<_>>(),
        additional_arguments: None,
    };

    let mut jvm_options = JvmArgs {
        launcher_name: "era-connect".to_string(),
        launcher_version: "0.0.1".to_string(),
        classpath: "".to_string(),
        classpath_separator: ":".to_string(),
        primary_jar: client_jar.to_string_lossy().to_string(),
        library_directory: RustOpaque::new(library_directory.canonicalize()?),
        game_directory: RustOpaque::new(game_directory.canonicalize()?),
        native_directory: RustOpaque::new(native_directory.canonicalize()?),
    };

    let max_concurrent_tasks = 256;
    let semaphore = Arc::new(Semaphore::new(max_concurrent_tasks));
    let mut handles = FuturesUnordered::new();

    let current_size = Arc::new(AtomicUsize::new(0));
    let (library_path, native_library_path) = (
        Arc::new(jvm_options.library_directory.clone()),
        Arc::new(jvm_options.native_directory.clone()),
    );

    let library_list_arc = Arc::new(library_list);
    let total_size = parallel_library(
        Arc::clone(&library_list_arc),
        Arc::clone(&library_path),
        Arc::clone(&native_library_path),
        Arc::clone(&current_size),
        &semaphore,
        &mut handles,
    )
    .await?;

    let current_os = os_version::detect()?;
    let current_os_type = match current_os {
        os_version::OsVersion::Linux(_) => OsName::Linux,
        os_version::OsVersion::Windows(_) => OsName::Windows,
        os_version::OsVersion::MacOS(_) => OsName::Osx,
        _ => bail!("not supported"),
    };

    let mut parsed_library_list = Vec::new();
    for library in library_list_arc.iter() {
        let (process_native, os_okto_download, _) = os_match(&library, &current_os_type).await;
        if os_okto_download && !process_native {
            parsed_library_list.push(library);
        }
    }

    let mut classpath_list = parsed_library_list
        .iter()
        .map(|x| {
            Arc::clone(&library_path)
                .join(&x.downloads.artifact.path)
                .to_string_lossy()
                .to_string()
        })
        .collect::<Vec<String>>();

    classpath_list.push(client_jar.to_string_lossy().to_string());
    jvm_options.classpath = classpath_list.join(":");

    for x in jvm_flags.rules {
        if x.action == ActionType::Allow
            && x.os.map_or(false, |os| os.name == Some(current_os_type))
        {
            jvm_flags.arguments.extend(
                x.value
                    .ok_or_else(|| anyhow!("rules value doesn't exist"))?,
            );
        }
    }

    jvm_flags.arguments = jvm_args_parse(&jvm_flags.arguments, &jvm_options);

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
    let asset_settings = extract_assets(asset_index, asset_directory).await?;

    parallel_assets(
        asset_settings,
        &semaphore,
        &current_size,
        &total_size,
        &mut handles,
    )
    .await?;

    let launch_args = LaunchArgs {
        jvm_args: jvm_flags.arguments,
        main_class,
        game_args: game_flags.arguments,
    };

    Ok(DownloadArgs {
        current_size: Arc::clone(&current_size),
        total_size: Arc::clone(&total_size),
        handles,
        launch_args,
        jvm_args: jvm_options,
        game_args: game_options,
    })
}

fn jvm_args_parse(jvm_flags: &Vec<String>, jvm_options: &JvmArgs) -> Vec<String> {
    let mut parsed_argument = Vec::new();

    for argument in jvm_flags.iter() {
        parsed_argument.push(
            argument
                .replace("${", "")
                .replace("}", "")
                .replace(
                    "natives_directory",
                    &jvm_options.native_directory.to_string_lossy(),
                )
                .replace("launcher_name", &jvm_options.launcher_name)
                .replace("launcher_version", &jvm_options.launcher_version)
                .replace("classpath", &jvm_options.classpath),
        );
    }
    parsed_argument
}

fn game_args_parse(game_flags: &GameFlags, game_arguments: &GameArgs) -> Vec<String> {
    let mut modified_arguments = Vec::new();

    for argument in &game_flags.arguments {
        modified_arguments.push(
            argument
                .replace("${", "")
                .replace("}", "")
                .replace("auth_player_name", &game_arguments.auth_player_name)
                .replace("version_name", &game_arguments.game_version_name)
                .replace(
                    "game_directory",
                    game_arguments
                        .game_directory
                        .to_string_lossy()
                        .to_string()
                        .as_str(),
                )
                .replace(
                    "assets_root",
                    game_arguments
                        .assets_root
                        .to_string_lossy()
                        .to_string()
                        .as_str(),
                )
                .replace("assets_index_name", &game_arguments.assets_index_name)
                .replace("auth_uuid", &game_arguments.auth_uuid)
                .replace("version_type", &game_arguments.version_type),
        );
    }
    modified_arguments
}

pub struct DownloadArgs {
    current_size: Arc<AtomicUsize>,
    total_size: Arc<AtomicUsize>,
    handles: FuturesUnordered<tokio::task::JoinHandle<std::result::Result<(), anyhow::Error>>>,
    pub launch_args: LaunchArgs,
    pub jvm_args: JvmArgs,
    pub game_args: GameArgs,
}

// get progress and and launch download
pub async fn run_download(sink: StreamSink<ReturnType>, download_args: DownloadArgs) -> Result<()> {
    let mut handles = download_args.handles;
    let download_complete = Arc::new(AtomicBool::new(false));
    let download_complete_clone = Arc::clone(&download_complete);
    let current_size_clone = Arc::clone(&download_args.current_size);
    let total_size_clone = Arc::clone(&download_args.total_size);

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
            sink.add(ReturnType {
                progress: Some(progress),
                prepare_name_args: None,
            });
        }
        sink.add(ReturnType {
            progress: None,
            prepare_name_args: Some(crate::api::PrepareGameArgs {
                launch_args: download_args.launch_args,
                jvm_args: download_args.jvm_args,
                game_args: download_args.game_args,
            }),
        });
        sink.close();
    });

    while let Some(future) = handles.next().await {
        future??;
    }

    download_complete.store(true, Ordering::Release);
    task.await?;
    println!("Complete!");
    Ok(())
}
