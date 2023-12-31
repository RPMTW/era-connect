pub mod authentication;
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
use chrono::Local;
use log::{info, warn};

pub use flutter_rust_bridge::StreamSink;
pub use flutter_rust_bridge::{RustOpaque, SyncReturn};
pub use tokio::sync::{Mutex, RwLock};
use uuid::Uuid;

use crate::api::forge::{prepare_forge_download, process_forge};

pub use self::authentication::account::{
    AccountToken, MinecraftAccount, MinecraftCape, MinecraftSkin, MinecraftSkinVariant,
};
pub use self::authentication::msa_flow::{
    LoginFlowDeviceCode, LoginFlowErrors, LoginFlowEvent, LoginFlowStage, XstsTokenErrorType,
};
pub use self::download::Progress;
pub use self::quilt::prepare_quilt_download;
pub use self::storage::account_storage::{AccountStorageKey, AccountStorageValue};
pub use self::storage::ui_layout::{UILayout, UILayoutKey, UILayoutValue};
pub use self::vanilla::prepare_vanilla_download;

use self::download::{run_download, DownloadBias};
use self::storage::storage_loader::StorageInstance;
use self::storage::storage_state::StorageState;
use self::vanilla::launch_game;

lazy_static::lazy_static! {
    static ref DATA_DIR : PathBuf = dirs::data_dir().expect("Can't find data_dir").join("era-connect");
    static ref STATE: RwLock<DownloadState> = RwLock::new(DownloadState::default());
    static ref STORAGE: StorageState = StorageState::new();
}

pub fn setup_logger() -> anyhow::Result<()> {
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

#[tokio::main(flavor = "current_thread")]
pub async fn launch_vanilla(stream: StreamSink<Progress>) -> anyhow::Result<()> {
    let c = prepare_vanilla_download().await?;

    let vanilla_bias = DownloadBias {
        start: 0.0,
        end: 100.0,
    };
    run_download(stream, c.0, vanilla_bias).await?;
    launch_game(c.1.launch_args).await
}

#[tokio::main(flavor = "current_thread")]
pub async fn launch_forge(stream: StreamSink<Progress>) -> anyhow::Result<()> {
    let (vanilla_download_args, vanilla_arguments) = prepare_vanilla_download().await?;
    info!("Starts Vanilla Downloading");
    let vanilla_bias = DownloadBias {
        start: 0.0,
        end: 90.0,
    };
    let stream = run_download(stream, vanilla_download_args, vanilla_bias).await?;
    let (forge_download_args, forge_arguments, manifest) = prepare_forge_download(
        vanilla_arguments.launch_args,
        vanilla_arguments.jvm_args,
        vanilla_arguments.game_args,
    )
    .await?;

    let forge_bias = DownloadBias {
        start: 90.0,
        end: 100.0,
    };
    info!("Starts Forge Downloading");
    run_download(stream, forge_download_args, forge_bias).await?;
    info!("Starts Forge Processing");
    let processed_arguments = process_forge(
        forge_arguments.launch_args,
        forge_arguments.jvm_args,
        forge_arguments.game_args,
        manifest,
    )
    .await?;

    launch_game(processed_arguments).await
}

#[tokio::main(flavor = "current_thread")]
pub async fn launch_quilt(stream: StreamSink<Progress>) -> anyhow::Result<()> {
    let (download_args, vanilla_arguments) = prepare_vanilla_download().await?;
    let vanilla_bias = DownloadBias {
        start: 0.0,
        end: 90.0,
    };
    let stream = run_download(stream, download_args, vanilla_bias).await?;
    let (download_args, quilt_processed) = prepare_quilt_download(
        String::from("1.20.1"),
        vanilla_arguments.launch_args,
        vanilla_arguments.jvm_args,
        vanilla_arguments.game_args,
    )
    .await?;
    let quilt_bias = DownloadBias {
        start: 90.0,
        end: 100.0,
    };
    run_download(stream, download_args, quilt_bias).await?;
    launch_game(quilt_processed.launch_args).await
}

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
    storage.save()
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
    storage.save()
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
            storage.save()?;

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
