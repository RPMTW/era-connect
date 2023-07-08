pub mod minecraft;

use flutter_rust_bridge::StreamSink;

pub use crate::api::minecraft::process_download;
pub use crate::api::minecraft::progress;

#[tokio::main(flavor = "current_thread")]
pub async fn test(a: StreamSink<usize>) {
    let data = process_download().await.unwrap();

    progress(data.0, data.1, data.2, a).await.unwrap();
}
