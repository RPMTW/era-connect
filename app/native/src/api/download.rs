use std::{
    collections::VecDeque,
    path::Path,
    sync::{
        atomic::{AtomicBool, AtomicUsize, Ordering},
        Arc,
    },
    time::Duration,
};

use anyhow::{bail, Context, Result};
use bytes::Bytes;
use flutter_rust_bridge::StreamSink;
use futures::StreamExt;
use log::{error, info};
use reqwest::Url;
use tokio::{
    fs::File,
    io::{AsyncReadExt, BufReader},
    time::{self, Instant},
};

use super::{vanilla::HandlesType, DownloadState, STATE};

pub async fn download_file(
    url: impl AsRef<str> + Send + Sync,
    current_size_clone: Option<Arc<AtomicUsize>>,
) -> Result<Bytes> {
    let client = reqwest::Client::builder()
        .tcp_keepalive(Some(std::time::Duration::from_secs(10)))
        .http2_keep_alive_timeout(std::time::Duration::from_secs(10))
        .build()?;
    let url = url.as_ref();
    let response_result = client.get(url).send().await;

    let retry_amount = 3;
    let mut response = match response_result {
        Ok(x) => Ok(x),
        Err(err) => {
            let mut temp = Err(err);
            for i in 1..=retry_amount {
                match client.get(url).send().await {
                    Ok(x) => {
                        temp = Ok(x);
                        break;
                    }
                    Err(x) => {
                        error!("{x}, retry count: {i}");
                    }
                }
            }
            temp
        }
    }?;
    let mut bytes_vec = Vec::new();
    if let Some(size) = current_size_clone {
        while let Some(chunk) = response.chunk().await? {
            size.fetch_add(chunk.len(), Ordering::Relaxed);
            bytes_vec.push(chunk);
        }
    } else {
        while let Some(chunk) = response.chunk().await? {
            bytes_vec.push(chunk);
        }
    }
    Ok(bytes_vec.into_iter().flatten().collect())
}

pub fn extract_filename(url: &str) -> Result<String> {
    let parsed_url = Url::parse(url)?;
    let path_segments = parsed_url.path_segments().context("Invalid URL")?;
    let filename = path_segments.last().context("No filename found in URL")?;
    Ok(filename.to_owned())
}

pub async fn validate_sha1(file_path: impl AsRef<Path> + Send + Sync, sha1: &str) -> Result<()> {
    use sha1::{Digest, Sha1};
    let file_path = file_path.as_ref();
    let file = File::open(file_path).await?;
    let mut buffer = Vec::new();
    let mut reader = BufReader::new(file);
    reader.read_to_end(&mut buffer).await?;

    let mut hasher = Sha1::new();
    hasher.update(&buffer);
    let result = &hasher.finalize()[..];

    if result != hex::decode(sha1)? {
        bail!(
            r#"
{} hash don't fit!
get: {}
expected: {}
"#,
            file_path.to_string_lossy(),
            hex::encode(result),
            sha1
        );
    }

    Ok(())
}

#[derive(Clone)]
pub struct Progress {
    pub speed: f64,
    pub percentages: f64,
    pub current_size: f64,
    pub total_size: f64,
}

/// set percentages bias
/// example:
/// start: 30.0
/// end: 100.0
pub struct DownloadBias {
    pub start: f64,
    pub end: f64,
}

// get progress and and launch download
pub async fn run_download(
    sink: StreamSink<Progress>,
    download_args: DownloadArgs,
    bias: DownloadBias,
) -> Result<StreamSink<Progress>> {
    let handles = download_args.handles;
    let download_complete = Arc::new(AtomicBool::new(false));

    let download_complete_clone = Arc::clone(&download_complete);
    let current_size_clone = Arc::clone(&download_args.current_size);
    let total_size_clone = Arc::clone(&download_args.total_size);

    let multiplier = (bias.end - bias.start) / 100.0;

    *STATE.write().await = DownloadState::Downloading;
    let sink_clone = sink.clone();
    let sleep_time = 250;
    let rolling_average_window = 5000 / sleep_time;
    let mut average_speed = VecDeque::with_capacity(rolling_average_window);
    let output = tokio::spawn(async move {
        let mut instant = Instant::now();
        let mut prev_bytes = 0.0;
        while !download_complete_clone.load(Ordering::Acquire) {
            time::sleep(Duration::from_millis(sleep_time.try_into().unwrap())).await;
            let current_size = current_size_clone.load(Ordering::Relaxed) as f64;
            let total_size = total_size_clone.load(Ordering::Relaxed) as f64;
            let percentages = (current_size / total_size * 100.0).mul_add(multiplier, bias.start);
            let speed = (current_size - prev_bytes) / instant.elapsed().as_secs_f64() / 1_000_000.0;

            if average_speed.len() < rolling_average_window {
                average_speed.push_back(speed);
            } else {
                average_speed.pop_front();
                average_speed.push_back(speed);
            }

            let speed = average_speed.iter().sum::<f64>() / average_speed.len() as f64;

            let progress = Progress {
                speed,
                percentages,
                current_size,
                total_size,
            };
            prev_bytes = current_size;
            instant = Instant::now();
            sink.add(progress);

            let state = *STATE.read().await;
            match state {
                DownloadState::Downloading => {}
                DownloadState::Paused => {
                    while *STATE.read().await != DownloadState::Downloading {
                        time::sleep(Duration::from_millis(100)).await;
                    }
                }
                DownloadState::Stopped => break,
            }
        }
    });
    // Create a semaphore with a limit on the number of concurrent downloads
    join_futures(handles, 128).await?;
    download_complete.store(true, Ordering::Release);
    output.await?;
    Ok(sink_clone)
}

pub async fn join_futures(
    handles: HandlesType,
    concurrency_limit: usize,
) -> Result<(), anyhow::Error> {
    let mut download_stream = tokio_stream::iter(handles).buffer_unordered(concurrency_limit);
    while let Some(x) = download_stream.next().await {
        let state = *STATE.read().await;
        match state {
            DownloadState::Downloading => x?,
            DownloadState::Paused => {
                while *STATE.read().await != DownloadState::Downloading {
                    time::sleep(Duration::from_millis(100)).await;
                    info!("pausing!");
                }
            }
            DownloadState::Stopped => break,
        }
    }
    Ok(())
}

pub struct DownloadArgs {
    pub current_size: Arc<AtomicUsize>,
    pub total_size: Arc<AtomicUsize>,
    pub handles: HandlesType,
}
