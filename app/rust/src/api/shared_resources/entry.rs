use anyhow::anyhow;
use anyhow::Context;
use dashmap::DashMap;
use flutter_rust_bridge::frb;
use flutter_rust_bridge::setup_default_user_utils;
use log::{debug, info, warn};
use once_cell::sync::Lazy;
use std::path::PathBuf;
use std::{fs::create_dir_all, time::Duration};

use uuid::Uuid;

pub use crate::api::backend_exclusive::storage::{
    account_storage::{AccountStorage, AccountStorageKey, AccountStorageValue},
    ui_layout::{UILayout, UILayoutKey, UILayoutValue},
};

use crate::api::backend_exclusive::{
    download::Progress,
    storage::{storage_loader::StorageInstance, storage_state::StorageState},
};
use crate::api::shared_resources::authentication::msa_flow::LoginFlowEvent;
use crate::api::shared_resources::authentication::{self, account::MinecraftSkin};

use crate::api::backend_exclusive::vanilla;
pub use crate::api::backend_exclusive::vanilla::version::VersionMetadata;

use crate::api::shared_resources::authentication::msa_flow::LoginFlowErrors;
use crate::api::shared_resources::collection::ModLoaderType;
use crate::api::shared_resources::collection::{
    AdvancedOptions, Collection, CollectionId, ModLoader,
};
use crate::frb_generated::StreamSink;

pub static DATA_DIR: Lazy<PathBuf> = Lazy::new(|| {
    dirs::data_dir()
        .expect("Can't find data_dir")
        .join("era-connect")
});
pub static DOWNLOAD_PROGRESS: Lazy<DashMap<CollectionId, Progress>> = Lazy::new(DashMap::default);
pub static STORAGE: Lazy<StorageState> = Lazy::new(StorageState::new);

#[frb(init)]
pub fn init_app() -> anyhow::Result<()> {
    setup_default_user_utils();
    setup_logger()?;
    Ok(())
}

fn setup_logger() -> anyhow::Result<()> {
    use chrono::Local;

    let file_name = format!("{}.log", Local::now().format("%Y-%m-%d-%H-%M-%S"));
    let file_path = DATA_DIR.join("logs").join(file_name);
    let parent = file_path
        .parent()
        .context("Failed to get the parent directory of logs directory")?;
    create_dir_all(parent)?;

    fern::Dispatch::new()
        .format(|out, message, record| {
            out.finish(format_args!(
                "[{}] {} | {}:{} | {}",
                Local::now().format("%Y-%m-%d %H:%M:%S"),
                record.level(),
                record.file().unwrap_or_else(|| record.target()),
                record.line().unwrap_or(0),
                message
            ));
        })
        .chain(std::io::stdout())
        .chain(fern::log_file(file_path)?)
        .filter(|metadata| {
            if cfg!(debug_assertions) {
                metadata.level() <= log::LevelFilter::Debug
            } else {
                metadata.level() <= log::LevelFilter::Info
            }
        })
        .apply()?;

    info!("Successfully setup logger");
    Ok(())
}

#[frb(sync)]
pub fn get_ui_layout_storage(key: UILayoutKey) -> UILayoutValue {
    let value = STORAGE.ui_layout.blocking_read().get_value(key);
    value
}

pub async fn get_vanilla_versions() -> anyhow::Result<Vec<VersionMetadata>> {
    vanilla::version::get_versions().await
}

pub fn set_ui_layout_storage(value: UILayoutValue) -> anyhow::Result<()> {
    let mut storage = STORAGE.ui_layout.blocking_write();
    storage.set_value(value);
    storage.save()?;
    Ok(())
}

#[frb(sync)]
pub fn get_account_storage(key: AccountStorageKey) -> AccountStorageValue {
    STORAGE.account_storage.blocking_read().get_value(key)
}

#[frb(sync)]
pub fn get_skin_file_path(skin: MinecraftSkin) -> String {
    skin.get_head_file_path().to_string_lossy().to_string()
}

pub async fn remove_minecraft_account(uuid: Uuid) -> anyhow::Result<()> {
    let mut storage = STORAGE.account_storage.write().await;
    storage.remove_account(uuid);
    storage.save()?;
    Ok(())
}

pub async fn minecraft_login_flow(skin: StreamSink<LoginFlowEvent>) -> anyhow::Result<()> {
    let result = authentication::msa_flow::login_flow(&skin).await;
    match result {
        Ok(account) => {
            if let Some(skin) = account.skins.first() {
                skin.download_skin().await?;
            }

            let mut storage = STORAGE.account_storage.write().await;
            storage.add_account(account.clone(), true);
            storage.save()?;

            skin.add(LoginFlowEvent::Success(account))
                .map_err(|x| anyhow!(x))?;
            info!("Successfully login minecraft account");
        }
        Err(e) => {
            skin.add(LoginFlowEvent::Error(LoginFlowErrors::UnknownError(
                format!("{e:#}"),
            )))
            .map_err(|x| anyhow!(x))?;
            warn!("Failed to login minecraft account: {:#}", e);
        }
    }

    Ok(())
}

pub async fn create_collection(
    display_name: String,
    version_metadata: VersionMetadata,
    mod_loader: Option<ModLoader>,
    advanced_options: Option<AdvancedOptions>,
) -> anyhow::Result<()> {
    let mod_loader = Some(ModLoader {
        mod_loader_type: ModLoaderType::Fabric,
        version: String::new(),
    });
    let mut collection =
        Collection::create(display_name, version_metadata, mod_loader, advanced_options)?;

    info!(
        "Successfully created collection basic file at {}",
        collection.entry_path.display()
    );
    let id = collection.get_collection_id();
    let download_handle = tokio::spawn(async move {
        loop {
            if let Some(x) = DOWNLOAD_PROGRESS.get(&id) {
                if x.percentages >= 100.0 {
                    break;
                }
                debug!("{:#?}", &*x);
            }
            tokio::time::sleep(Duration::from_millis(500)).await;
        }
    });

    collection.launch_game().await?;

    download_handle.await?;

    info!("Successfully finished downloading game");

    Ok(())
}
