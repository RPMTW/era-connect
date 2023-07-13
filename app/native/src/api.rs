mod download;
pub mod vanilla;

use flutter_rust_bridge::StreamSink;

pub use vanilla::launch_game;
pub use vanilla::{get_download_progress, Progress};

#[tokio::main(flavor = "current_thread")]
pub async fn test(stream: StreamSink<Progress>) -> anyhow::Result<()> {
    let b = get_download_progress(stream).await?;
    launch_game(b)
}
