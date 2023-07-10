mod download;
pub mod launch;

use flutter_rust_bridge::StreamSink;

pub use super::api::launch::{get_download_progress, Progress};

#[tokio::main(flavor = "current_thread")]
pub async fn test(stream: StreamSink<Progress>) -> anyhow::Result<()> {
    get_download_progress(stream).await
}
