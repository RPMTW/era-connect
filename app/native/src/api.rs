pub mod minecraft;

use flutter_rust_bridge::StreamSink;
use tokio::sync::{Mutex, RwLock};

pub use crate::api::minecraft::get_progress;

pub struct Progress {
    pub speed: f64,
    pub percentages: f64,
    pub current_size: f64,
    pub total_size: f64,
}

#[tokio::main(flavor = "current_thread")]
pub async fn test(stream: StreamSink<Progress>) -> anyhow::Result<()> {
    get_progress(stream).await
}
