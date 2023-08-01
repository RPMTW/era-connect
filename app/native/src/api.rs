pub mod config;
mod download;
pub mod logger;
pub mod quilt;
pub mod vanilla;

pub use std::sync::mpsc;
pub use std::sync::mpsc::{Receiver, Sender};

pub use flutter_rust_bridge::StreamSink;
pub use flutter_rust_bridge::{RustOpaque, SyncReturn};
pub use tokio::sync::{Mutex, RwLock};

use self::config::config_state::ConfigState;
pub use self::config::ui_layout::{Key, UILayout, Value};
use self::logger::EraConnectLogger;
pub use self::logger::{LogEntry, LogLevel};
pub use self::quilt::prepare_quilt_download;
pub use self::vanilla::prepare_vanilla_download;
pub use self::vanilla::PathBuf;
pub use self::vanilla::{run_download, Progress};

pub use self::vanilla::{DownloadArgs, GameOptions, JvmOptions, LaunchArgs};

lazy_static::lazy_static! {
    static ref DATA_DIR : PathBuf = dirs::data_dir().unwrap().join("era-connect");
    static ref STATE: RwLock<DownloadState> = RwLock::new(DownloadState::default());
    static ref CONFIG: ConfigState = ConfigState::new();
}

pub struct ReturnType {
    pub progress: Option<Progress>,
    pub prepare_name_args: Option<PrepareGameArgs>,
}

#[derive(Debug)]
pub struct PrepareGameArgs {
    pub launch_args: LaunchArgs,
    pub jvm_args: JvmOptions,
    pub game_args: GameOptions,
}

pub fn setup_logger(stream: StreamSink<LogEntry>) -> anyhow::Result<()> {
    let logger: &'static mut EraConnectLogger = Box::leak(Box::new(EraConnectLogger { stream }));
    let result = log::set_logger(logger).map_err(|e| anyhow::anyhow!(e));
    match result {
        Ok(_) => {
            info!("Successfully set up rust side logger");
            Ok(())
        }
        Err(e) => Err(e),
    }
}

#[tokio::main(flavor = "current_thread")]
pub async fn download_vanilla(stream: StreamSink<ReturnType>) -> anyhow::Result<()> {
    let c = prepare_vanilla_download().await?;
    run_download(stream, c).await
}

pub fn launch_game(pre_launch_arguments: PrepareGameArgs) -> anyhow::Result<()> {
    vanilla::launch_game(pre_launch_arguments.launch_args)?;
    Ok(())
}

#[tokio::main(flavor = "current_thread")]
pub async fn download_quilt(
    stream: StreamSink<ReturnType>,
    quilt_prepare: PrepareGameArgs,
) -> anyhow::Result<()> {
    let quilt_download_args = prepare_quilt_download(
        "1.20.1".to_string(),
        quilt_prepare.launch_args,
        quilt_prepare.jvm_args,
        quilt_prepare.game_args,
    )
    .await?;
    run_download(stream, quilt_download_args).await?;
    Ok(())
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

pub fn get_ui_layout_config(key: Key) -> Value {
    CONFIG.ui_layout.blocking_read().get_value(key)
}

pub fn set_ui_layout_config(config: UILayout) -> anyhow::Result<()> {
    *CONFIG.ui_layout.blocking_write() = config.clone();
    config.save()
}
