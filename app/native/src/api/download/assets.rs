use super::util::{download_file, validate_sha1};
use anyhow::{anyhow, Context, Result};
use async_semaphore::Semaphore;
use futures::stream::FuturesUnordered;
use serde::{Deserialize, Serialize};
use serde_json::Value;
use std::{
    path::PathBuf,
    sync::{atomic::AtomicUsize, atomic::Ordering, Arc},
};
use tokio::fs;

#[derive(Debug, PartialEq, Serialize, Deserialize, Default)]
pub struct AssetIndex {
    pub url: String,
    id: String,
    sha1: String,
    size: usize,
    #[serde(rename = "totalSize")]
    total_size: usize,
}

pub struct AssetSettings {
    pub asset_download_list: Vec<String>,
    pub asset_download_hash: Vec<String>,
    pub asset_download_path: Vec<PathBuf>,
    pub asset_download_size: Vec<usize>,
}

pub async fn extract_assets(asset_index: AssetIndex, folder: PathBuf) -> Result<AssetSettings> {
    let asset_response = reqwest::get(asset_index.url).await?;
    let asset_index_content: Value = asset_response.json().await?;
    let asset_objects = asset_index_content
        .get("objects")
        .ok_or_else(|| anyhow!("fail to get content[objects]"))?
        .as_object()
        .ok_or_else(|| anyhow!("Failure to parse asset_index_content[\"objects\"]"))?;
    let mut asset_download_list = Vec::new();
    let mut asset_download_hash = Vec::new();
    let mut asset_download_path = Vec::new();
    let mut asset_download_size = Vec::new();
    for (_, val) in asset_objects.iter() {
        let size = val["size"]
            .as_u64()
            .ok_or_else(|| anyhow!("size don't exist!"))?
            .try_into()
            .context("val[size] u64 to usize fail!")?;
        let hash = val
            .get("hash")
            .ok_or_else(|| anyhow!("hash don't exist!"))?
            .as_str()
            .ok_or_else(|| anyhow!("asset hash is not a string"))?;
        asset_download_list.push(format!(
            "https://resources.download.minecraft.net/{hash:.2}/{hash}",
        ));
        asset_download_hash.push(hash.to_string());
        asset_download_path
            .push(folder.join(PathBuf::from(format!("assets/objects/{hash:.2}/{hash}"))));
        asset_download_size.push(size);
    }
    Ok(AssetSettings {
        asset_download_list,
        asset_download_hash,
        asset_download_path,
        asset_download_size,
    })
}

pub async fn parallel_assets(
    assets: AssetSettings,
    semaphore: &Arc<Semaphore>,
    current_size: &Arc<AtomicUsize>,
    total_size: &Arc<AtomicUsize>,
    handles: &mut FuturesUnordered<tokio::task::JoinHandle<std::result::Result<(), anyhow::Error>>>,
) -> Result<()> {
    let asset_download_list_arc = Arc::new(assets.asset_download_list);
    let asset_download_hash_arc = Arc::new(assets.asset_download_hash);
    let asset_download_path_arc = Arc::new(assets.asset_download_path);
    let asset_download_size_arc = Arc::new(assets.asset_download_size);
    for index in 0..asset_download_list_arc.len() {
        let asset_download_list_clone = Arc::clone(&asset_download_list_arc);
        let asset_download_path_clone = Arc::clone(&asset_download_path_arc);
        let current_size_clone = Arc::clone(current_size);
        fs::create_dir_all(
            asset_download_path_clone[index]
                .parent()
                .ok_or_else(|| anyhow!("can't find asset_download's parent dir"))?,
        )
        .await?;
        let okto_download = if asset_download_path_clone[index].exists() {
            if let Err(x) = validate_sha1(
                &asset_download_path_clone[index],
                &asset_download_hash_arc[index],
            )
            .await
            {
                eprintln!("{x}, \nredownloading.");
                true
            } else {
                false
            }
        } else {
            true
        };
        let semaphore_clone = Arc::clone(semaphore);
        if okto_download {
            total_size.fetch_add(asset_download_size_arc[index], Ordering::Relaxed);
            handles.push(tokio::spawn(async move {
                let _permit = semaphore_clone.acquire_arc().await;
                download_file(
                    asset_download_list_clone[index].clone(),
                    Some(&asset_download_path_clone[index]),
                    current_size_clone,
                )
                .await
            }));
        }
    }
    Ok(())
}
