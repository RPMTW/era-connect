use anyhow::{anyhow, bail};
use anyhow::{Context, Result};
use flutter_rust_bridge::{RustOpaque, StreamSink};
use futures::{Future, StreamExt};
use serde::{Deserialize, Serialize};
use serde_json::Value;
pub use std::path::PathBuf;
use std::pin::Pin;
use std::process::Command;
use std::{
    sync::{
        atomic::Ordering,
        atomic::{AtomicBool, AtomicUsize},
        Arc,
    },
    time::Duration,
};
use tokio::fs::{create_dir_all, File};
use tokio::io::AsyncWriteExt;
use tokio::time::{self, Instant};

use crate::api::download::library::os_match;
use crate::api::download::rules::OsName;

use super::download::assets::{extract_assets, parallel_assets, AssetIndex};
use super::download::library::{parallel_library, Library};
use super::download::rules::{get_rules, ActionType, Rule};
use super::download::util::{download_file, extract_filename, validate_sha1};
use super::{DownloadState, ReturnType, STATE};

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
#[derive(Debug, PartialEq, Serialize, Deserialize)]
struct DownloadMetadata {
    sha1: String,
    size: usize,
    url: String,
}

#[derive(Debug, PartialEq, Serialize, Deserialize)]
struct Downloads {
    client: DownloadMetadata,
    client_mappings: DownloadMetadata,
    server: DownloadMetadata,
    server_mappings: DownloadMetadata,
}

#[derive(Debug, PartialEq, Serialize, Deserialize)]
struct LoggingConfig {
    client: ClientConfig,
}

#[derive(Debug, PartialEq, Serialize, Deserialize)]
struct ClientConfig {
    argument: String,
    file: LogFile,
    #[serde(rename = "type")]
    log_type: String,
}

#[derive(Debug, PartialEq, Serialize, Deserialize)]
struct LogFile {
    id: String,
    sha1: String,
    size: usize,
    url: String,
}

#[derive(Clone, Debug)]
pub struct JvmOptions {
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
pub struct GameOptions {
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

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct QuiltLibrary {
    name: String,
    url: String,
}

pub type HandlesType = Vec<Pin<Box<dyn Future<Output = Result<()>> + Send>>>;

pub async fn get_game_manifest(
    download_target: String,
    version: Option<String>,
) -> Result<(Value, String)> {
    let bytes = download_file(download_target, None).await?;
    let version_manifest: Value = serde_json::from_slice(&bytes)?;
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
    let bytes = download_file(release_url.to_string(), None).await?;
    let contents: Value = serde_json::from_slice(&bytes)?;
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

    create_dir_all(&library_directory)
        .await
        .context("fail to create library_directory(vanilla)")?;
    create_dir_all(&asset_directory)
        .await
        .context("fail to create asset_directory(vanilla)")?;
    create_dir_all(&game_directory)
        .await
        .context("fail to create game_directory(vanilla)")?;
    create_dir_all(&native_directory)
        .await
        .context("fail to create native_directory(vanilla)")?;

    let game_options = GameOptions {
        auth_player_name: "Kyle".to_string(),
        game_version_name: current_version,
        game_directory: RustOpaque::new(
            game_directory
                .canonicalize()
                .context("Fail to canonicalize game_directory(game_options)")?,
        ),
        assets_root: RustOpaque::new(
            asset_directory
                .canonicalize()
                .context("Fail to canonicalize asset_directory(game_options)")?,
        ),
        assets_index_name: game_manifest["assetIndex"]["id"]
            .as_str()
            .unwrap()
            .to_string(),
        auth_uuid: String::new(),
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

    let _logging: LoggingConfig = LoggingConfig::deserialize(&game_manifest["logging"])
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

    let mut jvm_options = JvmOptions {
        launcher_name: "era-connect".to_string(),
        launcher_version: "0.0.1".to_string(),
        classpath: String::new(),
        classpath_separator: ":".to_string(),
        primary_jar: client_jar.to_string_lossy().to_string(),
        library_directory: RustOpaque::new(
            library_directory
                .canonicalize()
                .context("Fail to canonicalize library_directory(jvm_options)")?,
        ),
        game_directory: RustOpaque::new(
            game_directory
                .canonicalize()
                .context("Fail to canonicalize game_directory(jvm_options)")?,
        ),
        native_directory: RustOpaque::new(
            native_directory
                .canonicalize()
                .context("Fail to canonicalize native_directory(jvm_options)")?,
        ),
    };

    let mut handles = Vec::new();

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
        let (process_native, is_native_library, _) = os_match(library, &current_os_type);
        if !process_native && !is_native_library {
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

    let client_jar_filename = PathBuf::from(extract_filename(&downloads_list.client.url)?);

    if !client_jar_filename.exists() {
        let bytes = download_file(
            downloads_list.client.url.clone(),
            Some(Arc::clone(&current_size)),
        )
        .await?;
        let mut f = File::create(client_jar_filename).await?;
        f.write_all(&bytes).await?;
        total_size.fetch_add(downloads_list.client.size, Ordering::Relaxed);
    } else if let Err(x) = validate_sha1(
        &PathBuf::from(&extract_filename(&downloads_list.client.url)?),
        &downloads_list.client.sha1,
    )
    .await
    {
        eprintln!("{x}");
        let bytes = download_file(
            downloads_list.client.url.clone(),
            Some(Arc::clone(&current_size)),
        )
        .await?;
        let mut f = File::create(client_jar_filename).await?;
        f.write_all(&bytes).await?;
        total_size.fetch_add(downloads_list.client.size, Ordering::Relaxed);
    }
    let asset_settings = extract_assets(asset_index, asset_directory).await?;

    parallel_assets(asset_settings, &current_size, &total_size, &mut handles).await?;

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

fn jvm_args_parse(jvm_flags: &[String], jvm_options: &JvmOptions) -> Vec<String> {
    let mut parsed_argument = Vec::new();

    for argument in jvm_flags.iter() {
        let mut s = argument.as_str();
        let mut buf = String::with_capacity(s.len());

        while let Some(pos) = s.find("${") {
            buf.push_str(&s[..pos]);
            let start = &s[pos + 2..];

            let Some(closing) = start.find('}') else { panic!("missing closing brace"); };
            let var = &start[..closing];
            // make processing string to next part
            s = &start[closing + 1..];

            let natives_directory = jvm_options.native_directory.to_string_lossy().to_string();
            buf.push_str(match var {
                "natives_directory" => &natives_directory,
                "launcher_name" => &jvm_options.launcher_name,
                "launcher_version" => &jvm_options.launcher_version,
                "classpath" => &jvm_options.classpath,
                _ => "",
            });
        }
        buf.push_str(s);
        parsed_argument.push(buf);
    }
    parsed_argument
}

fn game_args_parse(game_flags: &GameFlags, game_arguments: &GameOptions) -> Vec<String> {
    let mut modified_arguments = Vec::new();

    for argument in &game_flags.arguments {
        let mut s = argument.as_str();
        let mut buf = String::with_capacity(s.len());

        while let Some(pos) = s.find("${") {
            buf.push_str(&s[..pos]);
            let start = &s[pos + 2..];

            let Some(closing) = start.find('}') else { panic!("missing closing brace"); };
            let var = &start[..closing];
            // make processing string to next part
            s = &start[closing + 1..];

            let game_directory = game_arguments.game_directory.to_string_lossy().to_string();
            let assets_root = game_arguments.assets_root.to_string_lossy().to_string();

            buf.push_str(match var {
                "auth_player_name" => &game_arguments.auth_player_name,
                "version_name" => &game_arguments.game_version_name,
                "game_directory" => &game_directory,
                "assets_root" => &assets_root,
                "assets_index_name" => &game_arguments.assets_index_name,
                "auth_uuid" => &game_arguments.auth_uuid,
                "version_type" => &game_arguments.version_type,
                _ => "",
            });
        }
        buf.push_str(s);
        modified_arguments.push(buf);
    }
    modified_arguments
}

pub struct DownloadArgs {
    pub current_size: Arc<AtomicUsize>,
    pub total_size: Arc<AtomicUsize>,
    pub handles: HandlesType,
    pub launch_args: LaunchArgs,
    pub jvm_args: JvmOptions,
    pub game_args: GameOptions,
}

// get progress and and launch download
pub async fn run_download(sink: StreamSink<ReturnType>, download_args: DownloadArgs) -> Result<()> {
    let handles = download_args.handles;
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
            let state = *STATE.read().await;
            match state {
                DownloadState::Downloading => {}
                DownloadState::Paused => {
                    while *STATE.read().await != DownloadState::Downloading {
                        time::sleep(Duration::from_millis(100)).await;
                    }
                }
                DownloadState::Stopped => break,
            }
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
    // Create a semaphore with a limit on the number of concurrent downloads
    join_futures(handles, 128).await?;
    download_complete.store(true, Ordering::Release);
    task.await?;
    println!("Complete!");
    Ok(())
}

pub async fn join_futures(
    handles: HandlesType,
    concurrency_limit: usize,
) -> Result<(), anyhow::Error> {
    let mut download_stream = tokio_stream::iter(handles).buffer_unordered(concurrency_limit);
    while let Some(x) = download_stream.next().await {
        let state = *STATE.read().await;
        match state {
            DownloadState::Downloading => x?,
            DownloadState::Paused => {
                dbg!("pausing!");
            }
            DownloadState::Stopped => break,
        }
        time::sleep(Duration::from_millis(100)).await;
    }
    Ok(())
}
