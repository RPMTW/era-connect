use std::{
    collections::VecDeque,
    convert::TryInto,
    path::Path,
    sync::{
        atomic::{AtomicBool, AtomicUsize, Ordering},
        Arc,
    },
    time::Duration,
};

use anyhow::{bail, Context};
use bytes::{BufMut, Bytes, BytesMut};
use futures::{future::BoxFuture, StreamExt};
use log::error;
use reqwest::Url;
use tokio::{
    fs::File,
    io::{AsyncReadExt, BufReader},
    time::{self, Instant},
};

use crate::api::shared_resources::{collection::CollectionId, entry::DOWNLOAD_PROGRESS};

pub type HandlesType<'a> = Vec<BoxFuture<'a, anyhow::Result<()>>>;

pub async fn download_file(
    url: impl AsRef<str> + Send + Sync,
    current_size_clone: Option<Arc<AtomicUsize>>,
) -> Result<Bytes, anyhow::Error> {
    let url = url.as_ref();
    let client = reqwest::Client::builder()
        .tcp_keepalive(Some(std::time::Duration::from_secs(10)))
        .http2_keep_alive_timeout(std::time::Duration::from_secs(10))
        .build()?;
    let response_result = client.get(url).send().await;

    let retry_amount = 3;
    let response = match response_result {
        Ok(x) => Ok(x),
        Err(err) => {
            let mut temp = Err(err);
            for i in 1..=retry_amount {
                // Wait 0.5s before retry.
                time::sleep(Duration::from_millis(500)).await;
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

    let bytes = match chunked_download(response, current_size_clone.clone()).await {
        Ok(x) => x,
        Err(err) => {
            error!("{err:?} you fucked up.");
            if let Some(ref size) = current_size_clone {
                size.fetch_sub(err.1, Ordering::Relaxed);
            }
            chunked_download(client.get(url).send().await?, current_size_clone)
                .await
                .map_err(|err| err.0)?
        }
    };

    Ok(bytes)
}

async fn chunked_download(
    mut response: reqwest::Response,
    current_size_clone: Option<Arc<AtomicUsize>>,
) -> Result<Bytes, (reqwest::Error, usize)> {
    let mut bytes = BytesMut::new();
    while let Some(chunk) = response.chunk().await.map_err(|err| (err, bytes.len()))? {
        if let Some(ref size) = current_size_clone {
            size.fetch_add(chunk.len(), Ordering::Relaxed);
        }
        bytes.put(chunk);
    }
    Ok(bytes.freeze())
}

pub fn extract_filename(url: &str) -> anyhow::Result<String> {
    let parsed_url = Url::parse(url)?;
    let path_segments = parsed_url.path_segments().context("Invalid URL")?;
    let filename = path_segments.last().context("No filename found in URL")?;
    Ok(filename.to_owned())
}

pub async fn validate_sha1(
    file_path: impl AsRef<Path> + Send + Sync,
    sha1: &str,
) -> anyhow::Result<()> {
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
pub async fn get_hash(file_path: impl AsRef<Path> + Send + Sync) -> anyhow::Result<Vec<u8>> {
    use sha1::{Digest, Sha1};
    let file_path = file_path.as_ref();
    let file = File::open(file_path).await?;
    let mut buffer = Vec::new();
    let mut reader = BufReader::new(file);
    reader.read_to_end(&mut buffer).await?;
    let mut hasher = Sha1::new();
    hasher.update(&buffer);
    let mut vec = Vec::new();
    vec.extend_from_slice(&hasher.finalize()[..]);
    Ok(vec)
}

#[derive(Clone, Debug)]
pub struct Progress {
    pub percentages: f64,
    pub speed: Option<f64>,
    pub current_size: Option<f64>,
    pub total_size: Option<f64>,
}

/// set percentages bias
/// example:
/// start: 30.0
/// end: 100.0
pub struct DownloadBias {
    pub start: f64,
    pub end: f64,
}
impl Default for DownloadBias {
    fn default() -> Self {
        Self {
            start: 0.0,
            end: 100.0,
        }
    }
}

// get progress and and launch download, if HandlesType doesn't exist, does not calculate speed
pub async fn execute_and_progress(
    id: CollectionId,
    download_args: DownloadArgs<'_>,
    bias: DownloadBias,
) -> anyhow::Result<()> {
    println!("run_download");
    let handles = download_args.handles;
    let calculate_speed = download_args.is_size;
    let download_complete = Arc::new(AtomicBool::new(false));

    let download_complete_clone = Arc::clone(&download_complete);
    let current_size_clone = Arc::clone(&download_args.current);
    let total_size_clone = Arc::clone(&download_args.total);

    let output = tokio::spawn(async move {
        rolling_average(
            download_complete_clone,
            current_size_clone,
            total_size_clone,
            bias,
            id,
            calculate_speed,
        )
        .await;
    });
    // Create a semaphore with a limit on the number of concurrent downloads
    join_futures(handles, 128).await?;
    download_complete.store(true, Ordering::Release);
    output.await?;

    Ok(())
}

pub async fn rolling_average(
    download_complete: Arc<AtomicBool>,
    current: Arc<AtomicUsize>,
    total: Arc<AtomicUsize>,
    bias: DownloadBias,
    id: CollectionId,
    calculate_speed: bool,
) {
    let mut instant = Instant::now();
    let mut prev_bytes = 0.0;
    while !download_complete.load(Ordering::Acquire) {
        let multiplier = (bias.end - bias.start) / 100.0;

        let sleep_time = 250;

        time::sleep(Duration::from_millis(sleep_time.try_into().unwrap())).await;
        let current = current.load(Ordering::Relaxed) as f64;
        let total = total.load(Ordering::Relaxed) as f64;
        let percentages = (current / total * 100.0).mul_add(multiplier, bias.start);

        let progress = if calculate_speed {
            let rolling_average_window = 5000 / sleep_time;
            let mut average_speed = VecDeque::with_capacity(rolling_average_window);

            let speed = (current - prev_bytes) / instant.elapsed().as_secs_f64() / 1_000_000.0;

            if average_speed.len() < rolling_average_window {
                average_speed.push_back(speed);
            } else {
                average_speed.pop_front();
                average_speed.push_back(speed);
            }

            let speed = average_speed.iter().sum::<f64>() / average_speed.len() as f64;

            Progress {
                percentages,
                speed: Some(speed),
                current_size: Some(current),
                total_size: Some(total),
            }
        } else {
            Progress {
                percentages,
                speed: None,
                current_size: None,
                total_size: None,
            }
        };

        prev_bytes = current;
        instant = Instant::now();
        DOWNLOAD_PROGRESS.insert(id.clone(), progress);
    }
}

pub async fn join_futures(
    handles: HandlesType<'_>,
    concurrency_limit: usize,
) -> Result<(), anyhow::Error> {
    let mut download_stream = tokio_stream::iter(handles).buffer_unordered(concurrency_limit);
    while let Some(x) = download_stream.next().await {
        x?
    }
    Ok(())
}

pub struct DownloadArgs<'a> {
    pub current: Arc<AtomicUsize>,
    pub total: Arc<AtomicUsize>,
    pub handles: HandlesType<'a>,
    pub is_size: bool,
}
