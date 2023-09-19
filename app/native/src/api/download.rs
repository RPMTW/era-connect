use std::{
    collections::VecDeque,
    path::Path,
    sync::{
        atomic::{AtomicBool, AtomicUsize, Ordering},
        Arc,
    },
    time::Duration,
};

use bytes::{BufMut, Bytes, BytesMut};
use color_eyre::eyre::ContextCompat;
use color_eyre::Result;
use futures::StreamExt;
use hex::FromHexError;
use log::{error, info};
use reqwest::Url;
use std::sync::mpsc;
use tokio::{
    fs::File,
    io::{AsyncReadExt, BufReader},
    task::JoinError,
    time::{self, Instant},
};

use super::{
    vanilla::{CustomIoErrorKind, HandlesType},
    DownloadState, STATE,
};

use thiserror::Error;
#[derive(Error, Debug)]
pub enum DownloadError {
    #[error("Fail to build request Builder")]
    ReqwestBuilderFail(String),
    #[error("Fail to fetch a response")]
    ResponseFail(String),
    #[error("Io error")]
    Io {
        msg: String,
        error: CustomIoErrorKind,
    },
    #[error("internal error from thread, {0}")]
    ThreadInternalError(String),
    #[error("thread paniced")]
    ThreadPanic(String),
    #[error("thread was cancelled")]
    CancelledThread(String),
}

#[derive(Error, Debug)]
pub enum ShasumValidationError {
    #[error("failed to turn sha1 binary into string")]
    FailToDecode(HexErrorKind),
    #[error("Io error")]
    Io(CustomIoErrorKind),
    #[error(r#"
{} hash don't fit!
get: {}
expected: {}
"#, .path, .found, .expected)]
    FailToValidate {
        path: String,
        found: String,
        expected: String,
    },
}
impl From<JoinError> for DownloadError {
    fn from(value: JoinError) -> Self {
        if value.is_panic() {
            Self::ThreadPanic(format!("{value:?}"))
        } else if value.is_cancelled() {
            Self::CancelledThread(format!("{value:?}"))
        } else {
            // Repr only contains Thread panic and cancelled thread
            unreachable!()
        }
    }
}
#[derive(Debug, Clone, Copy, PartialEq)]
pub enum HexErrorKind {
    InvalidHexCharacter { c: char, index: usize },
    OddLength,
    InvalidStringLength,
}

impl From<FromHexError> for ShasumValidationError {
    fn from(value: FromHexError) -> Self {
        match value {
            FromHexError::InvalidHexCharacter { c, index } => {
                Self::FailToDecode(HexErrorKind::InvalidHexCharacter { c, index })
            }
            FromHexError::OddLength => Self::FailToDecode(HexErrorKind::OddLength),
            FromHexError::InvalidStringLength => {
                Self::FailToDecode(HexErrorKind::InvalidStringLength)
            }
        }
    }
}
impl From<std::io::Error> for ShasumValidationError {
    fn from(value: std::io::Error) -> Self {
        let error = match value.kind() {
            std::io::ErrorKind::NotFound => CustomIoErrorKind::NotFound,
            std::io::ErrorKind::PermissionDenied => CustomIoErrorKind::PermissionDenied,
            _ => CustomIoErrorKind::Other,
        };
        ShasumValidationError::Io(error)
    }
}

pub async fn download_file(
    url: impl AsRef<str> + Send + Sync,
    current_size_clone: Option<Arc<AtomicUsize>>,
) -> Result<Bytes, DownloadError> {
    let client = reqwest::Client::builder()
        .tcp_keepalive(Some(std::time::Duration::from_secs(10)))
        .http2_keep_alive_timeout(std::time::Duration::from_secs(10))
        .build()
        .map_err(|x| DownloadError::ReqwestBuilderFail(format!("{x:?}")))?;
    let url = url.as_ref();
    let response_result = client.get(url).send().await;

    let retry_amount = 3;
    let mut response = match response_result {
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
    }
    .map_err(|_| DownloadError::ResponseFail(url.to_string()))?;

    let mut bytes = BytesMut::new();
    while let Some(chunk) = response
        .chunk()
        .await
        .map_err(|_| DownloadError::ResponseFail(url.to_string()))?
    {
        if let Some(ref size) = current_size_clone {
            size.fetch_add(chunk.len(), Ordering::Relaxed);
        }
        bytes.put(chunk);
    }

    Ok(bytes.freeze())
}

pub fn extract_filename(url: &str) -> color_eyre::Result<String> {
    let parsed_url = Url::parse(url)?;
    let path_segments = parsed_url.path_segments().context("Invalid URL")?;
    let filename = path_segments.last().context("No filename found in URL")?;
    Ok(filename.to_owned())
}

pub async fn validate_sha1(
    file_path: impl AsRef<Path> + Send + Sync,
    sha1: &str,
) -> Result<(), ShasumValidationError> {
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
        return Err(ShasumValidationError::FailToValidate {
            path: file_path.to_string_lossy().to_string(),
            found: hex::encode(result),
            expected: sha1.to_string(),
        });
    }

    Ok(())
}

#[derive(Clone, Debug)]
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
    sender: mpsc::Sender<Progress>,
    download_args: DownloadArgs<'_>,
    bias: DownloadBias,
) -> Result<(), DownloadError> {
    println!("run_download");
    let handles = download_args.handles;
    let download_complete = Arc::new(AtomicBool::new(false));

    let download_complete_clone = Arc::clone(&download_complete);
    let current_size_clone = Arc::clone(&download_args.current_size);
    let total_size_clone = Arc::clone(&download_args.total_size);

    let multiplier = (bias.end - bias.start) / 100.0;

    *STATE.write().await = DownloadState::Downloading;
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
            info!("{:?}", progress);
            sender.send(progress).unwrap();

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
    join_futures(handles, 128)
        .await
        .map_err(|err| DownloadError::ThreadInternalError(format!("{err:?}")))?;
    download_complete.store(true, Ordering::Release);
    output.await?;

    Ok(())
}

pub async fn join_futures(handles: HandlesType<'_>, concurrency_limit: usize) -> Result<()> {
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

pub struct DownloadArgs<'a> {
    pub current_size: Arc<AtomicUsize>,
    pub total_size: Arc<AtomicUsize>,
    pub handles: HandlesType<'a>,
}
