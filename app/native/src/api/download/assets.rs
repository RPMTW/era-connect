use crate::api::vanilla::HandlesType;

use super::util::{download_file, validate_sha1};
use anyhow::{anyhow, Context, Result};
use log::error;
use serde::{Deserialize, Serialize};
use serde_json::Value;
use std::{
    path::PathBuf,
    sync::{atomic::AtomicUsize, atomic::Ordering, Arc},
};
use tokio::fs;

#[derive(Debug, PartialEq, Eq, Serialize, Deserialize, Default)]
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
    let asset_index_path = folder.join(PathBuf::from(format!("indexes/{}.json", asset_index.id)));
    let asset_index_content: Value = if asset_index_path.exists()
        && validate_sha1(&asset_index_path, asset_index.sha1.as_str())
            .await
            .is_ok()
    {
        let b: &[u8] = &fs::read(asset_index_path).await?;
        serde_json::from_slice(b)?
    } else {
        let asset_response_bytes = download_file(asset_index.url, None).await?;
        fs::create_dir_all(
            asset_index_path
                .parent()
                .context("Failed to create asset dir(impossible)")?,
        )
        .await?;
        fs::write(&asset_index_path, &asset_response_bytes).await?;
        serde_json::from_slice(&asset_response_bytes)?
    };
    let asset_objects = asset_index_content
        .get("objects")
        .context("fail to get content[objects]")?
        .as_object()
        .context("Failure to parse asset_index_content[objects]")?;
    let mut asset_download_list = Vec::new();
    let mut asset_download_hash = Vec::new();
    let mut asset_download_path = Vec::new();
    let mut asset_download_size = Vec::new();
    for (_, val) in asset_objects.iter() {
        let size = val
            .get("size")
            .context("size doesn't exist!")?
            .as_u64()
            .context("size is not u64")?
            .try_into()
            .context("val[size] u64 to usize fail!")?;
        let hash = val
            .get("hash")
            .context("hash doesn't exist!")?
            .as_str()
            .context("asset hash is not a string")?;
        asset_download_list.push(format!(
            "https://resources.download.minecraft.net/{hash:.2}/{hash}",
        ));
        asset_download_hash.push(hash.to_owned());
        asset_download_path.push(folder.join(PathBuf::from(format!("objects/{hash:.2}/{hash}"))));
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
    current_size: &Arc<AtomicUsize>,
    total_size: &Arc<AtomicUsize>,
    handles: &mut HandlesType,
) -> Result<()> {
    let asset_download_list_arc = Arc::new(assets.asset_download_list);
    let asset_download_hash_arc = Arc::new(assets.asset_download_hash);
    let asset_download_path_arc = Arc::new(assets.asset_download_path);
    let asset_download_size_arc = Arc::new(assets.asset_download_size);
    for index in 0..asset_download_list_arc.len() {
        let asset_download_list_clone = Arc::clone(&asset_download_list_arc);
        let asset_download_path_clone = Arc::clone(&asset_download_path_arc);
        let asset_download_path = asset_download_path_clone
            .get(index)
            .context("can't get asset_download_path index")?;
        let current_size_clone = Arc::clone(current_size);
        fs::create_dir_all(
            asset_download_path
                .parent()
                .context("can't find asset_download's parent dir")?,
        )
        .await?;
        let okto_download = if asset_download_path.exists() {
            if let Err(x) = validate_sha1(
                asset_download_path,
                asset_download_hash_arc
                    .get(index)
                    .context("Can't get asset download hash")?,
            )
            .await
            {
                error!("{x}, \nredownloading.");
                true
            } else {
                false
            }
        } else {
            true
        };
        if okto_download {
            total_size.fetch_add(
                *asset_download_size_arc
                    .get(index)
                    .context("Can't get asset download size")?,
                Ordering::Relaxed,
            );
            handles.push(Box::pin(async move {
                let bytes = download_file(
                    asset_download_list_clone
                        .get(index)
                        .context("Can't get asset download list")?
                        .clone(),
                    Some(current_size_clone),
                )
                .await?;
                fs::write(
                    asset_download_path_clone
                        .get(index)
                        .context("Can't get asset download path at index: {index}")?,
                    bytes,
                )
                .await
                .map_err(|err| anyhow!(err))
            }));
        }
    }
    Ok(())
}
