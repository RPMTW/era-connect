use anyhow::{anyhow, bail, Context, Result};
use reqwest::Url;
use std::{
    path::PathBuf,
    sync::{atomic::AtomicUsize, atomic::Ordering, Arc},
};
use tokio::{
    fs::File,
    io::{AsyncReadExt, AsyncWriteExt, BufReader},
};
pub async fn download_file(
    url: String,
    name: Option<&PathBuf>,
    current_bytes: Arc<AtomicUsize>,
) -> Result<()> {
    let filename = name.map_or_else(
        || {
            extract_filename(&url)
                .context("Fail to extract filename")
                .unwrap()
        },
        |x| {
            x.to_str()
                .ok_or_else(|| anyhow!("Fail to parse filename path"))
                .unwrap()
                .to_owned()
        },
    );
    let client = reqwest::Client::builder()
        .tcp_keepalive(Some(std::time::Duration::from_secs(10)))
        .http2_keep_alive_timeout(std::time::Duration::from_secs(10))
        .build()
        .map_err(|err| anyhow!("{err:?}\n{}", filename.to_string()))?;
    let response_result = client.get(&url).send().await;
    let retry_amount = 3;
    let mut response = match response_result {
        Ok(x) => Ok(x),
        Err(err) => {
            let mut temp = Err(err);
            for i in 0..retry_amount {
                match client.get(&url).send().await {
                    Ok(x) => {
                        temp = Ok(x);
                        break;
                    }
                    Err(x) => {
                        eprintln!("{}, retry count: {}", x, i);
                    }
                }
            }
            temp
        }
    }?;
    let mut file = File::create(&filename).await?;
    while let Some(chunk) = response.chunk().await? {
        file.write_all(&chunk).await?;
        current_bytes.fetch_add(chunk.len(), Ordering::Relaxed);
    }
    Ok(())
}

pub fn extract_filename(url: &str) -> Result<String> {
    let parsed_url = Url::parse(url)?;
    let path_segments = parsed_url
        .path_segments()
        .ok_or_else(|| anyhow!("Invalid URL"))?;
    let filename = path_segments
        .last()
        .ok_or_else(|| anyhow!("No filename found in URL"))?;
    Ok(filename.to_owned())
}

pub async fn validate_sha1(file_path: &PathBuf, sha1: &str) -> Result<()> {
    use sha1::{Digest, Sha1};
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
