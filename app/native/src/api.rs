pub mod config;
mod download;
pub mod forge;
pub mod quilt;
pub mod vanilla;

use std::fs::create_dir_all;
pub use std::sync::mpsc;
pub use std::sync::mpsc::{Receiver, Sender};

use anyhow::{Context, Ok};
use chrono::Local;
pub use flutter_rust_bridge::StreamSink;
pub use flutter_rust_bridge::{RustOpaque, SyncReturn};
use log::info;
pub use tokio::sync::{Mutex, RwLock};

use crate::api::forge::{prepare_forge_download, process_forge};

use self::config::config_state::ConfigState;
pub use self::config::ui_layout::{Key, UILayout, Value};
pub use self::quilt::prepare_quilt_download;
use self::vanilla::launch_game;
pub use self::vanilla::prepare_vanilla_download;
pub use self::vanilla::PathBuf;
pub use self::vanilla::{run_download, Progress};

pub use self::vanilla::{DownloadArgs, GameOptions, JvmOptions, LaunchArgs};

lazy_static::lazy_static! {
    static ref DATA_DIR : PathBuf = dirs::data_dir().unwrap().join("era-connect");
    static ref STATE: RwLock<DownloadState> = RwLock::new(DownloadState::default());
    static ref CONFIG: ConfigState = ConfigState::new();
}

#[derive(Debug, Clone)]
pub struct PrepareGameArgs {
    pub launch_args: LaunchArgs,
    pub jvm_args: JvmOptions,
    pub game_args: GameOptions,
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
        .apply()?;

    info!("Successfully setup logger");
    Ok(())
}

#[tokio::main(flavor = "current_thread")]
pub async fn download_vanilla(stream: StreamSink<Progress>) -> anyhow::Result<()> {
    let c = prepare_vanilla_download().await?;
    run_download(stream, c.0).await.map(|_| {})
}

#[tokio::main(flavor = "current_thread")]
pub async fn launch_vanilla(stream: StreamSink<Progress>) -> anyhow::Result<()> {
    let c = prepare_vanilla_download().await?;
    run_download(stream, c.0).await?;
    launch_game(c.1.launch_args).await
}

#[tokio::main(flavor = "current_thread")]
pub async fn launch_forge(stream: StreamSink<Progress>) -> anyhow::Result<()> {
    let (vanilla_download_args, vanilla_arguments) = prepare_vanilla_download().await?;
    info!("Starts Vanilla Downloading");
    let stream = run_download(stream, vanilla_download_args).await?;
    let (forge_download_args, forge_arguments, manifest) = prepare_forge_download(
        vanilla_arguments.launch_args,
        vanilla_arguments.jvm_args,
        vanilla_arguments.game_args,
    )
    .await?;
    info!("Starts Forge Downloading");
    run_download(stream, forge_download_args).await?;
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
    let quilt_download_args = prepare_quilt_download(
        "1.20.1".to_string(),
        vanilla_arguments.launch_args,
        vanilla_arguments.jvm_args,
        vanilla_arguments.game_args,
    )
    .await?;
    run_download(stream, download_args).await?;
    launch_game(quilt_download_args.1.launch_args).await
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

#[tokio::main(flavor = "current_thread")]
pub async fn fetch_state() -> DownloadState {
    *STATE.read().await
}

#[tokio::main(flavor = "current_thread")]
pub async fn write_state(s: DownloadState) {
    *STATE.write().await = s;
}

pub fn get_ui_layout_config(key: Key) -> SyncReturn<Value> {
    let value = CONFIG.ui_layout.blocking_read().get_value(key);
    SyncReturn(value)
}

pub fn set_ui_layout_config(value: Value) -> anyhow::Result<()> {
    let mut config = CONFIG.ui_layout.blocking_write();
    config.set_value(value);
    config.save()
}
