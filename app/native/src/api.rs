mod download;
pub mod vanilla;

use flutter_rust_bridge::StreamSink;

pub use self::vanilla::prepare_quilt_download;
pub use self::vanilla::prepare_vanilla_download;
pub use self::vanilla::PathBuf;
pub use self::vanilla::{run_download, Progress};

pub use self::vanilla::DownloadArgs;
pub use self::vanilla::GameArgs;
pub use self::vanilla::JvmArgs;
pub use self::vanilla::LaunchArgs;

pub struct ReturnType {
    pub progress: Option<Progress>,
    pub prepare_name_args: Option<PrepareGameArgs>,
}

#[derive(Debug)]
pub struct PrepareGameArgs {
    pub launch_args: LaunchArgs,
    pub jvm_args: JvmArgs,
    pub game_args: GameArgs,
}

#[tokio::main(flavor = "current_thread")]
pub async fn test(stream: StreamSink<ReturnType>) -> anyhow::Result<()> {
    let c = prepare_vanilla_download().await?;
    run_download(stream, c).await
}

#[tokio::main(flavor = "current_thread")]
pub async fn launch_quilt(
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
    let launch_args = quilt_download_args.launch_args.clone();
    run_download(stream, quilt_download_args).await?;
    vanilla::launch_game(launch_args)?;
    Ok(())
}
