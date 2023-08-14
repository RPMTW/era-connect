pub mod assets;
pub mod library;
pub mod rules;
pub mod util;

use anyhow::bail;
use anyhow::{Context, Result};
use flutter_rust_bridge::RustOpaque;
use futures::Future;
use log::error;
use serde::{Deserialize, Serialize};
use serde_json::Value;
pub use std::path::PathBuf;
use std::pin::Pin;
use std::sync::{atomic::AtomicUsize, atomic::Ordering, Arc};
use tokio::fs::{self, create_dir_all, File};
use tokio::io::AsyncWriteExt;

use crate::api::vanilla::library::os_match;
use crate::api::vanilla::rules::OsName;

use self::assets::{extract_assets, parallel_assets, AssetIndex};
use self::library::{parallel_library, Library};
use self::rules::{get_rules, ActionType, Rule};

use super::download::{download_file, extract_filename, validate_sha1, DownloadArgs};

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

pub async fn launch_game(launch_args: LaunchArgs) -> Result<()> {
    let mut launch_vec = Vec::new();
    launch_vec.extend(launch_args.jvm_args);
    launch_vec.push(launch_args.main_class);
    launch_vec.extend(launch_args.game_args);
    let b = tokio::process::Command::new("java")
        .args(launch_vec)
        .spawn();
    b?.wait().await?;
    Ok(())
}

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct QuiltLibrary {
    name: String,
    url: String,
}

pub struct ProcessedArguments {
    pub launch_args: LaunchArgs,
    pub jvm_args: JvmOptions,
    pub game_args: GameOptions,
}

pub type HandlesType = Vec<Pin<Box<dyn Future<Output = Result<()>> + Send>>>;

pub async fn get_game_manifest(
    download_target: String,
    version: Option<String>,
) -> Result<(Value, String)> {
    let bytes = download_file(download_target, None).await?;
    let version_manifest: Value = serde_json::from_slice(&bytes)?;
    let version = version.map_or_else(
        || {
            version_manifest["latest"]["release"]
                .as_str()
                .expect("latest release doesn't exist")
                .to_owned()
        },
        |x| x,
    );
    let release_url = version_manifest["versions"]
        .as_array()
        .context("minecraft version is not array")?
        .iter()
        .find(|x| x["id"].as_str().expect("failed to parse game id to str") == version)
        .and_then(|x| x["url"].as_str())
        .context("version url doesn't exist")?;
    let bytes = download_file(release_url.to_owned(), None).await?;
    let contents: Value = serde_json::from_slice(&bytes)?;
    Ok((contents, version))
}

pub async fn prepare_vanilla_download() -> Result<(DownloadArgs, ProcessedArguments)> {
    let (game_manifest, current_version) = get_game_manifest(
        String::from("https://launchermeta.mojang.com/mc/game/version_manifest.json"),
        None,
    )
    .await?;

    let game_argument = game_manifest["arguments"]["game"]
        .as_array()
        .context("Failure to parse contents[\"arguments\"][\"game\"]")?;

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
        auth_player_name: String::from("Kyle"),
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
            .context("assetindex id doesn't exist")?
            .to_owned(),
        auth_uuid: String::new(),
        user_type: String::from("mojang"),
        version_type: String::from("release"),
    };

    game_flags.arguments = game_args_parse(&game_flags, &game_options);

    if let Some(x) = game_flags.additional_arguments {
        game_flags.arguments.extend(x);
    }

    let asset_index = AssetIndex::deserialize(&game_manifest["assetIndex"])
        .context("Failed to Serialize assetIndex")?;

    let downloads_list: Downloads = Downloads::deserialize(&game_manifest["downloads"])
        .context("Failed to Serialize Downloads")?;

    let library_list: Arc<[Library]> = Vec::<Library>::deserialize(&game_manifest["libraries"])
        .context("Failed to Serialize contents[\"libraries\"]")?
        .into();

    let _logging: LoggingConfig = LoggingConfig::deserialize(&game_manifest["logging"])
        .context("Failed to Serialize logging")?;

    let main_class: String =
        String::deserialize(&game_manifest["mainClass"]).context("Failed to get MainClass")?;

    let client_jar = std::env::current_dir()?.join(extract_filename(&downloads_list.client.url)?);

    let jvm_argument = game_manifest["arguments"]["jvm"]
        .as_array()
        .context("Failure to parse contents[\"arguments\"][\"jvm\"]")?;
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
        launcher_name: String::from("era-connect"),
        launcher_version: String::from("0.0.1"),
        classpath: String::new(),
        classpath_separator: String::from(":"),
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

    let total_size = parallel_library(
        Arc::clone(&library_list),
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
    for library in library_list.iter() {
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
            jvm_flags
                .arguments
                .extend(x.value.context("rules value doesn't exist")?);
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
        fs::write(client_jar_filename, &bytes).await?;
        total_size.fetch_add(downloads_list.client.size, Ordering::Relaxed);
    } else if let Err(x) = validate_sha1(
        &PathBuf::from(&extract_filename(&downloads_list.client.url)?),
        &downloads_list.client.sha1,
    )
    .await
    {
        error!("{x}\n redownloading.");
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

    Ok((
        DownloadArgs {
            current_size: Arc::clone(&current_size),
            total_size: Arc::clone(&total_size),
            handles,
        },
        ProcessedArguments {
            launch_args,
            jvm_args: jvm_options,
            game_args: game_options,
        },
    ))
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
