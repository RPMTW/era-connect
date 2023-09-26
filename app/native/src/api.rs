pub mod authentication;
pub mod collection;
mod download;
pub mod forge;
pub mod quilt;
pub mod storage;
pub mod vanilla;

use std::fs::create_dir_all;
use std::path::PathBuf;
pub use std::sync::mpsc;
pub use std::sync::mpsc::{Receiver, Sender};

use anyhow::Context;
use color_eyre::eyre::eyre;
use log::{info, warn};

pub use flutter_rust_bridge::StreamSink;
pub use flutter_rust_bridge::SyncReturn;
pub use tokio::sync::{Mutex, RwLock};
use uuid::Uuid;

use crate::api::vanilla::launch_game;

pub use self::authentication::account::{
    AccountToken, MinecraftAccount, MinecraftCape, MinecraftSkin, MinecraftSkinVariant,
};
pub use self::authentication::msa_flow::{
    LoginFlowDeviceCode, LoginFlowErrors, LoginFlowEvent, LoginFlowStage, XstsTokenErrorType,
};
pub use self::collection::{
    AdvancedOptions, Collection, CollectionKey, CollectionValue, ModLoader, ModLoaderType,
};
pub use self::download::Progress;
pub use self::quilt::prepare_quilt_download;
pub use self::storage::account_storage::{AccountStorageKey, AccountStorageValue};
use self::storage::storage_loader::StorageInstance;
pub use self::storage::ui_layout::{UILayout, UILayoutKey, UILayoutValue};
pub use self::vanilla::prepare_vanilla_download;
use self::vanilla::version::GetVersionError;
pub use self::vanilla::version::{VersionMetadata, VersionType};
use self::vanilla::VanillaLaunchError;

use self::download::{run_download, DownloadBias};
// use self::forge::{prepare_forge_download, process_forge};
use self::storage::storage_state::StorageState;
// use self::vanilla::launch_game;

lazy_static::lazy_static! {
    static ref DATA_DIR : PathBuf = dirs::data_dir().expect("Can't find data_dir").join("era-connect");
    static ref STATE: RwLock<DownloadState> = RwLock::new(DownloadState::default());
    static ref STORAGE: StorageState = StorageState::new();
}

pub fn setup_logger() -> anyhow::Result<()> {
    color_eyre::install().map_err(|x| anyhow::anyhow!("{x:?}"))?;
    use chrono::Local;

    let file_name = format!("{}.log", Local::now().format("%Y-%m-%d-%H-%M-%S"));
    let file_path = DATA_DIR.join("logs").join(file_name);
    let parent = file_path
        .parent()
        .context("Failed to get the parent directory of logs directory")?;
    create_dir_all(parent)?;

    fern::Dispatch::new()
        .format(|out, message, record| {
            out.finish(format_args!(
                "[{}] {} | {}:{} | {}",
                Local::now().format("%Y-%m-%d %H:%M:%S"),
                record.level(),
                record.file().unwrap_or_else(|| record.target()),
                record.line().unwrap_or(0),
                message
            ));
        })
        .chain(std::io::stdout())
        .chain(fern::log_file(file_path)?)
        .filter(|metadata| {
            if cfg!(debug_assertions) {
                metadata.level() <= log::LevelFilter::Debug
            } else {
                metadata.level() <= log::LevelFilter::Info
            }
        })
        .apply()?;

    info!("Successfully setup logger");
    Ok(())
}

// #[tokio::main(flavor = "current_thread")]
// pub async fn launch_vanilla(stream: StreamSink<Progress>) -> anyhow::Result<()> {
//     // HACK: This is a temporary solution to get the collection
//     let collection = STORAGE.collections.read().await.get(0).unwrap().clone();
//     let (vanilla_download_args, vanilla_arguments, game_manifest) =
//         prepare_vanilla_download(&collection).await?;

//     let vanilla_bias = DownloadBias {
//         start: 0.0,
//         end: 100.0,
//     };
//     run_download(stream, vanilla_download_args, vanilla_bias).await?;
//     launch_game(vanilla_arguments.launch_args).await
// }

// #[tokio::main(flavor = "current_thread")]
// pub async fn launch_forge(stream: StreamSink<Progress>) -> anyhow::Result<()> {
//     // HACK: This is a temporary solution to get the collection
//     let collection = STORAGE.collections.read().await.get(0).unwrap().clone();

//     let (vanilla_download_args, vanilla_arguments, game_manifest) =
//         prepare_vanilla_download(&collection).await?;
//     info!("Starts Vanilla Downloading");
//     let vanilla_bias = DownloadBias {
//         start: 0.0,
//         end: 90.0,
//     };
//     let stream = run_download(stream, vanilla_download_args, vanilla_bias).await?;
//     let (forge_download_args, forge_arguments, manifest) = prepare_forge_download(
//         vanilla_arguments.launch_args,
//         vanilla_arguments.jvm_args,
//         vanilla_arguments.game_args,
//     )
//     .await?;

//     let forge_bias = DownloadBias {
//         start: 90.0,
//         end: 100.0,
//     };
//     info!("Starts Forge Downloading");
//     run_download(stream, forge_download_args, forge_bias).await?;
//     info!("Starts Forge Processing");
//     let processed_arguments = process_forge(
//         forge_arguments.launch_args,
//         forge_arguments.jvm_args,
//         forge_arguments.game_args,
//         game_manifest,
//         manifest,
//     )
//     .await?;

//     launch_game(processed_arguments).await
// }

// #[tokio::main(flavor = "current_thread")]
// pub async fn launch_quilt(stream: StreamSink<Progress>) -> anyhow::Result<()> {
//     // HACK: This is a temporary solution to get the collection
//     let collection = STORAGE.collections.read().await.get(0).unwrap().clone();

//     let (download_args, vanilla_arguments, game_manifest) =
//         prepare_vanilla_download(&collection).await?;
//     let vanilla_bias = DownloadBias {
//         start: 0.0,
//         end: 90.0,
//     };
//     let stream = run_download(stream, download_args, vanilla_bias).await?;
//     let (download_args, quilt_processed) = prepare_quilt_download(
//         String::from("1.20.1"),
//         vanilla_arguments.launch_args,
//         vanilla_arguments.jvm_args,
//         vanilla_arguments.game_args,
//     )
//     .await?;
//     let quilt_bias = DownloadBias {
//         start: 90.0,
//         end: 100.0,
//     };
//     run_download(stream, download_args, quilt_bias).await?;
//     launch_game(quilt_processed.launch_args).await
// }

#[derive(Debug, Copy, Clone, PartialEq, Eq)]
pub enum DownloadState {
    Downloading,
    Paused,
    Stopped,
}

impl Default for DownloadState {
    fn default() -> Self {
        Self::Stopped
    }
}

pub fn fetch_state() -> DownloadState {
    *STATE.blocking_read()
}

pub fn write_state(s: DownloadState) {
    *STATE.blocking_write() = s;
}

pub fn get_ui_layout_storage(key: UILayoutKey) -> SyncReturn<UILayoutValue> {
    let value = STORAGE.ui_layout.blocking_read().get_value(key);
    SyncReturn(value)
}

pub fn set_ui_layout_storage(value: UILayoutValue) -> anyhow::Result<()> {
    let mut storage = STORAGE.ui_layout.blocking_write();
    storage.set_value(value);
    storage.save().map_err(|x| anyhow::anyhow!("{x:?}"))?;
    Ok(())
}

pub fn get_account_storage(key: AccountStorageKey) -> SyncReturn<AccountStorageValue> {
    let value = STORAGE.account_storage.blocking_read().get_value(key);
    SyncReturn(value)
}

pub fn get_skin_file_path(skin: MinecraftSkin) -> SyncReturn<String> {
    SyncReturn(skin.get_head_file_path().to_string_lossy().to_string())
}

pub fn remove_minecraft_account(uuid: Uuid) -> anyhow::Result<()> {
    let mut storage = STORAGE.account_storage.blocking_write();
    storage.remove_account(uuid);
    storage.save().map_err(|x| anyhow::anyhow!("{x:?}"))?;
    Ok(())
}

#[tokio::main(flavor = "current_thread")]
pub async fn minecraft_login_flow(skin: StreamSink<LoginFlowEvent>) -> anyhow::Result<()> {
    let result = authentication::msa_flow::login_flow(&skin).await;
    match result {
        Ok(account) => {
            if let Some(skin) = account.skins.first() {
                skin.download_skin().await?;
            }

            let mut storage = STORAGE.account_storage.write().await;
            storage.add_account(account.clone(), true);
            storage.save().map_err(|x| anyhow::anyhow!("{x:?}"))?;

            skin.add(LoginFlowEvent::Success(account));
            info!("Successfully login minecraft account");
        }
        Err(e) => {
            skin.add(LoginFlowEvent::Error(LoginFlowErrors::UnknownError(
                format!("{e:#}"),
            )));
            warn!("Failed to login minecraft account: {:#}", e);
        }
    }

    skin.close();
    Ok(())
}

use thiserror::Error;
#[derive(Error, Debug)]
pub enum MyError {
    #[error(transparent)]
    LaunchError(#[from] VanillaLaunchError),
    #[error(transparent)]
    VersionGetError(#[from] GetVersionError),
    #[error("Anyhow error")]
    Other(String),
}

impl From<color_eyre::Report> for MyError {
    fn from(value: color_eyre::Report) -> Self {
        Self::Other(format!("{value:?}"))
    }
}

#[tokio::main(flavor = "current_thread")]
pub async fn get_vanilla_versions() -> Result<Vec<VersionMetadata>, MyError> {
    vanilla::version::get_versions()
        .await
        .map_err(|err| err.into())
}

#[tokio::main(flavor = "multi_thread", worker_threads = 2)]
pub async fn create_collection(
    display_name: String,
    version_metadata: VersionMetadata,
    mod_loader: Option<ModLoader>,
    advanced_options: Option<AdvancedOptions>,
) -> Result<(), MyError> {
    use chrono::{Duration, Utc};

    let (loader, entry_path) = Collection::create(&display_name).map_err(|x| eyre!(x))?;
    let now_time = Utc::now();

    let collection = Collection {
        display_name,
        minecraft_version: version_metadata,
        mod_loader,
        created_at: now_time,
        updated_at: now_time,
        played_time: Duration::seconds(0),
        advanced_options,
        entry_path,
    };
    loader.save(&collection)?;
    info!(
        "Successfully created collection basic file at {}",
        collection.entry_path.display()
    );

    let (sender, receiver) = mpsc::channel();
    let handle = tokio::spawn(async move {
        info!("Starts preparing vanilla download");
        let game_manifest =
            vanilla::manifest::fetch_game_manifest(&collection.minecraft_version.url).await?;
        let (vanilla_download_args, vanilla_arguments) =
            prepare_vanilla_download(collection, game_manifest).await?;

        info!("Starts downloading vanilla files");
        let full_bias = DownloadBias {
            start: 0.0,
            end: 100.0,
        };
        run_download(sender, vanilla_download_args, full_bias).await?;
        launch_game(vanilla_arguments.launch_args).await
    });

    for progress in receiver {
        info!("Progress: {:#?}", progress);
    }

    handle.await.map_err(|x| eyre!(x))??;
    Ok(())
}
