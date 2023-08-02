mod config;
mod download;
pub mod forge;
pub mod quilt;
pub mod vanilla;

pub use std::sync::mpsc;
pub use std::sync::mpsc::{Receiver, Sender};

use flutter_rust_bridge::StreamSink;
pub use tokio::sync::{Mutex, RwLock};

pub use self::config::ui_layout::UILayout;

pub use self::forge::{prepare_forge_download, process_forge};
pub use self::quilt::prepare_quilt_download;
pub use self::vanilla::prepare_vanilla_download;
pub use self::vanilla::PathBuf;
pub use self::vanilla::{run_download, Progress};

pub use self::vanilla::DownloadArgs;
pub use self::vanilla::GameOptions;
pub use self::vanilla::JvmOptions;
pub use self::vanilla::LaunchArgs;

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

#[tokio::main(flavor = "current_thread")]
pub async fn download_vanilla(stream: StreamSink<ReturnType>) -> anyhow::Result<()> {
    let c = prepare_vanilla_download().await?;
    run_download(stream, c).await
}

#[tokio::main(flavor = "current_thread")]
pub async fn launch_game(pre_launch_arguments: PrepareGameArgs) -> anyhow::Result<()> {
    vanilla::launch_game(pre_launch_arguments.launch_args)
}

#[tokio::main(flavor = "current_thread")]
pub async fn download_forge(
    stream: StreamSink<ReturnType>,
    forge_prepare: PrepareGameArgs,
) -> anyhow::Result<()> {
    let (quilt_download_args, manifest) = prepare_forge_download(
        forge_prepare.launch_args,
        forge_prepare.jvm_args,
        forge_prepare.game_args,
    )
    .await?;
    let a = quilt_download_args.game_args.clone();
    let b = quilt_download_args.jvm_args.clone();
    let c = quilt_download_args.launch_args.clone();
    let t = DownloadArgs {
        game_args: a,
        jvm_args: b,
        launch_args: c,
        ..quilt_download_args
    };
    run_download(stream, t).await?;
    process_forge(
        quilt_download_args.launch_args,
        quilt_download_args.jvm_args,
        quilt_download_args.game_args,
        manifest,
    )
    .await
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
pub enum State {
    Downloading,
    Paused,
    Stopped,
}

impl Default for State {
    fn default() -> Self {
        Self::Stopped
    }
}

lazy_static::lazy_static! {
    static ref STATE: RwLock<State> = RwLock::new(State::default());
    static ref UI_LAYOUT: RwLock<UILayout> = RwLock::new(UILayout::new());
}

#[tokio::main(flavor = "current_thread")]
pub async fn fetch_state() -> State {
    *STATE.read().await
}

#[tokio::main(flavor = "current_thread")]
pub async fn write_state(s: State) {
    *STATE.write().await = s;
}

#[tokio::main(flavor = "current_thread")]
pub async fn fetch_ui_layout() -> UILayout {
    *UI_LAYOUT.read().await
}
