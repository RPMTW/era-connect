mod download;
pub mod quilt;
pub mod vanilla;

pub use std::sync::mpsc;
pub use std::sync::mpsc::{Receiver, Sender};
use std::sync::Arc;

use flutter_rust_bridge::RustOpaque;
use flutter_rust_bridge::StreamSink;

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

pub fn test(channels: StateChannel) -> anyhow::Result<()> {
    std::thread::spawn(move || {
        println!("imafailure");
        dbg!(channels.receiver.recv().unwrap());
    })
    .join()
    .unwrap();
    Ok(())
}

#[tokio::main(flavor = "current_thread")]
pub async fn download_vanilla(
    stream: StreamSink<ReturnType>,
    channels: StateChannel,
) -> anyhow::Result<()> {
    let c = prepare_vanilla_download().await?;
    run_download(stream, channels, c).await
}

#[tokio::main(flavor = "current_thread")]
pub async fn launch_game(pre_launch_arguments: PrepareGameArgs) -> anyhow::Result<()> {
    vanilla::launch_game(pre_launch_arguments.launch_args)?;
    Ok(())
}

#[tokio::main(flavor = "current_thread")]
pub async fn download_quilt(
    stream: StreamSink<ReturnType>,
    channels: StateChannel,
    quilt_prepare: PrepareGameArgs,
) -> anyhow::Result<()> {
    let quilt_download_args = prepare_quilt_download(
        "1.20.1".to_string(),
        quilt_prepare.launch_args,
        quilt_prepare.jvm_args,
        quilt_prepare.game_args,
    )
    .await?;
    run_download(stream, channels, quilt_download_args).await?;
    Ok(())
}

#[derive(Debug, Copy, Clone, PartialEq, Eq)]
pub enum State {
    Downloading,
    Paused,
    ForceCancel,
}

pub use crossbeam::channel;
#[derive(Debug)]
pub struct StateChannel {
    pub sender: RustOpaque<channel::Sender<State>>,
    pub receiver: RustOpaque<channel::Receiver<State>>,
}

pub fn fetch() -> StateChannel {
    let state = State::Paused;
    let (tx, rx) = channel::unbounded();
    tx.send(state).unwrap();
    StateChannel {
        sender: RustOpaque::new(tx),
        receiver: RustOpaque::new(rx),
    }
}

pub fn state_write(s: State, channel: StateChannel) -> StateChannel {
    channel.sender.send(s).unwrap();
    channel
}
