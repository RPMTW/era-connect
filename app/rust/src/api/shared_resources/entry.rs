use anyhow::anyhow;
use anyhow::Context;
use flutter_rust_bridge::frb;
use flutter_rust_bridge::setup_default_user_utils;
use log::{debug, info, warn};
use once_cell::sync::Lazy;
use std::collections::HashMap;
use std::path::PathBuf;
use std::sync::Arc;
use std::{fs::create_dir_all, time::Duration};
use tokio::sync::mpsc::unbounded_channel;
use tokio::sync::mpsc::UnboundedReceiver;
use tokio::sync::mpsc::UnboundedSender;

use uuid::Uuid;

use crate::api::backend_exclusive::mod_management::mods::ModOverride;
pub use crate::api::backend_exclusive::storage::{
    account_storage::{AccountStorage, AccountStorageKey, AccountStorageValue},
    ui_layout::{UILayout, UILayoutKey, UILayoutValue},
};

use crate::api::backend_exclusive::vanilla::version::get_versions;
use crate::api::backend_exclusive::{
    download::Progress,
    storage::{storage_loader::StorageInstance, storage_state::StorageState},
};
use crate::api::shared_resources::authentication::msa_flow::LoginFlowEvent;
use crate::api::shared_resources::authentication::{self, account::MinecraftSkin};

use crate::api::backend_exclusive::vanilla;
use crate::api::backend_exclusive::vanilla::version::VersionMetadata;

use crate::api::shared_resources::authentication::msa_flow::LoginFlowErrors;
use crate::api::shared_resources::collection::Collection;
use crate::api::shared_resources::collection::ModLoaderType;
use crate::frb_generated::StreamSink;

use super::collection::AdvancedOptions;
use super::collection::CollectionId;
use super::collection::ModLoader;

pub static DATA_DIR: Lazy<PathBuf> = Lazy::new(|| {
    dirs::data_dir()
        .expect("Can't find data_dir")
        .join("era-connect")
});

pub static DOWNLOAD_PROGRESS: Lazy<UnboundedSender<HashMapMessage>> = Lazy::new(|| {
    let (sender, receiver) = unbounded_channel();
    spawn_hashmap_manager_thread(receiver);
    sender
});

pub static STORAGE: Lazy<StorageState> = Lazy::new(StorageState::new);

pub enum HashMapMessage {
    Insert(Arc<CollectionId>, Progress),
    Remove(Arc<CollectionId>),
    Get(Arc<CollectionId>, UnboundedSender<Option<Arc<Progress>>>),
}

fn spawn_hashmap_manager_thread(mut receiver: UnboundedReceiver<HashMapMessage>) {
    flutter_rust_bridge::spawn(async move {
        let mut hashmap: HashMap<Arc<CollectionId>, Arc<Progress>> = HashMap::new();

        loop {
            if let Some(message) = receiver.recv().await {
                match message {
                    HashMapMessage::Insert(key, value) => {
                        hashmap.insert(key, Arc::new(value));
                    }
                    HashMapMessage::Remove(key) => {
                        hashmap.remove(&key);
                    }
                    HashMapMessage::Get(key, response_sender) => {
                        let response = hashmap.get(&key).map(Arc::clone);
                        let _ = response_sender.send(response);
                    }
                }
            }
        }
    });
}

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
    //     let mut p = STORAGE.collections.write().await;
    //     let collection = p.last_mut().unwrap();
    //     dbg!(&collection);
    // NOTE: testing purposes
    let mod_loader = Some(ModLoader {
        mod_loader_type: ModLoaderType::Fabric,
        version: None,
    });
    let version_metadata = get_versions()
        .await?
        .into_iter()
        .find(|x| x.id == "1.20.2")
        .unwrap();
    let mut collection =
        Collection::create(display_name, version_metadata, mod_loader, advanced_options)?;

    collection
        .add_multiple_modrinth_mod(
            vec![
                "fabric-api",
                "distanthorizons",
                "sodium",
                "modmenu",
                "ferrite-core",
                "lazydfu",
                "iris",
                "continuity",
                "indium",
            ],
            vec![],
            None,
        )
        .await?;

    // collection
    //     .add_modrinth_mod("fabric-api", vec![], None)
    //     .await?;
    // collection
    //     .add_modrinth_mod("c2me-fabric", vec![], None)
    //     .await?;
    // collection
    //     .add_modrinth_mod("distanthorizons", vec![], None)
    //     .await?;
    // collection.add_modrinth_mod("sodium", vec![], None).await?;
    // collection.add_modrinth_mod("modmenu", vec![], None).await?;
    // collection
    //     .add_modrinth_mod("ferrite-core", vec![], None)
    //     .await?;
    // collection.add_modrinth_mod("lazydfu", vec![], None).await?;
    // collection.add_modrinth_mod("iris", vec![], None).await?;
    // collection
    //     .add_modrinth_mod("continuity", vec![], None)
    //     .await?;
    // collection.add_modrinth_mod("indium", vec![], None).await?;
    // collection
    //     .add_modrinth_mod("entityculling", vec![], None)
    //     .await?;

    info!(
        "Successfully created collection basic file at {}",
        collection.entry_path.display()
    );
    let id = Arc::new(collection.get_collection_id());
    let download_handle = tokio::spawn(async move {
        loop {
            let (tx, mut rx) = unbounded_channel();
            DOWNLOAD_PROGRESS.send(HashMapMessage::Get(Arc::clone(&id), tx))?;
            if let Some(Some(x)) = rx.recv().await {
                if x.percentages >= 100.0 {
                    break;
                }
                debug!("{:#?}", x);
            }
            tokio::time::sleep(Duration::from_millis(500)).await;
        }
        Ok::<(), anyhow::Error>(())
    });

    info!(
        "Successfully created collection basic file at {}",
        collection.entry_path.display()
    );

    collection.download_mods().await?;
    // dbg!(&collection.mod_manager.mods);

    collection.launch_game().await?;

    info!("Successfully finished downloading game");

    download_handle.await??;

    Ok(())
}
