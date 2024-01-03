use anyhow::{bail, Context};
use dashmap::DashMap;
use flutter_rust_bridge::frb;
use log::{debug, info, warn};
use std::fs::create_dir_all;
use std::path::PathBuf;
use std::sync::Arc;

use uuid::Uuid;

use crate::api::backend_exclusive::{
    modding::{
        forge::{prepare_forge_download, process_forge},
        quilt::prepare_quilt_download,
    },
    vanilla::manifest::fetch_game_manifest,
};

pub use crate::api::backend_exclusive::storage::{
    account_storage::{AccountStorage, AccountStorageKey, AccountStorageValue},
    ui_layout::{UILayout, UILayoutKey, UILayoutValue},
};

use crate::api::backend_exclusive::storage::{
    storage_loader::StorageInstance, storage_state::StorageState,
};
use crate::api::shared_resources::authentication::msa_flow::LoginFlowEvent;
use crate::api::shared_resources::authentication::{self, account::MinecraftSkin};

use crate::api::backend_exclusive::vanilla;
use crate::api::backend_exclusive::vanilla::version::VersionMetadata;

use crate::api::backend_exclusive::download::{execute_and_progress, DownloadBias, Progress};
use crate::api::backend_exclusive::vanilla::launcher::{launch_game, prepare_vanilla_download};
use crate::api::shared_resources::authentication::msa_flow::LoginFlowErrors;
use crate::api::shared_resources::collection::{
    AdvancedOptions, Collection, CollectionId, ModLoader, ModLoaderType, TemporaryTuple,
};
use crate::frb_generated::StreamSink;

lazy_static::lazy_static! {
    pub static ref DATA_DIR : PathBuf = dirs::data_dir().expect("Can't find data_dir").join("era-connect");
    pub static ref DOWNLOAD_PROGRESS: Arc<DashMap<CollectionId, Progress>> = Arc::new(DashMap::default());
    pub static ref STORAGE: StorageState = StorageState::new();
}

#[frb(init)]
pub fn setup_logger() -> anyhow::Result<()> {
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

pub fn remove_minecraft_account(uuid: Uuid) -> anyhow::Result<()> {
    let mut storage = STORAGE.account_storage.blocking_write();
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

            skin.add(LoginFlowEvent::Success(account))?;
            info!("Successfully login minecraft account");
        }
        Err(e) => {
            skin.add(LoginFlowEvent::Error(LoginFlowErrors::UnknownError(
                format!("{e:#}"),
            )))?;
            warn!("Failed to login minecraft account: {:#}", e);
        }
    }

    skin.close()?;
    Ok(())
}

pub async fn create_collection(
    display_name: String,
    version_metadata: VersionMetadata,
    mod_loader: Option<ModLoader>,
    advanced_options: Option<AdvancedOptions>,
) -> anyhow::Result<()> {
    // NOTE: testing purposes
    let mod_loader = Some(ModLoader {
        mod_loader_type: ModLoaderType::Forge,
        version: None,
    });
    tokio::spawn(async {
        let p = DOWNLOAD_PROGRESS
            .iter()
            .map(|x| x.clone())
            .collect::<Vec<_>>();
        dbg!(p);
    });

    let TemporaryTuple(mut collection, loader) =
        Collection::create(display_name, version_metadata, mod_loader, advanced_options)?;

    // NOTE: testing purposes
    collection.add_mod("rpmtw-update-mod", vec![], None).await?;
    debug!(
        "{:?}",
        &collection
            .mod_manager
            .mods
            .iter()
            .map(|x| (&x.name, &x.mod_version, &x.incompatiable_mods))
            .collect::<Vec<_>>()
    );
    collection.download_mods().await?;

    loader.save(&collection)?;
    let collection_id = collection.get_collection_id();

    info!(
        "Successfully created collection basic file at {}",
        collection.entry_path.display()
    );
    let collection_id = collection.get_collection_id();
    let mod_loader_clone = collection.mod_loader.clone();

    let handle = tokio::spawn(async move {
        if let Some(mod_loader) = mod_loader_clone {
            match mod_loader.mod_loader_type {
                ModLoaderType::Forge | ModLoaderType::NeoForge => {
                    launch_forge(collection, collection_id).await?
                }
                ModLoaderType::Quilt => launch_quilt(collection, collection_id).await?,
                _ => bail!("you useless!"),
            }
        } else {
            launch_vanilla(collection, collection_id).await?
        }
    });

    handle.await??;
    Ok(())
}
async fn launch_forge(
    collection: Collection,
    collection_id: CollectionId,
) -> anyhow::Result<anyhow::Result<()>> {
    info!("Starts Vanilla Downloading");
    let vanilla_bias = DownloadBias {
        start: 0.0,
        end: 80.0,
    };
    let game_manifest = fetch_game_manifest(&collection.minecraft_version.url).await?;
    let (vanilla_download_args, vanilla_arguments) =
        prepare_vanilla_download(collection, game_manifest.clone()).await?;
    execute_and_progress(collection_id.clone(), vanilla_download_args, vanilla_bias).await?;

    info!("Starts Forge Downloading");
    let forge_download_bias = DownloadBias {
        start: 80.0,
        end: 90.0,
    };
    let (forge_download_args, forge_arguments, manifest) = prepare_forge_download(
        vanilla_arguments.launch_args,
        vanilla_arguments.jvm_args,
        vanilla_arguments.game_args,
    )
    .await?;
    execute_and_progress(
        collection_id.clone(),
        forge_download_args,
        forge_download_bias,
    )
    .await?;

    info!("Starts Forge Processing");
    let forge_processor_bias = DownloadBias {
        start: 90.0,
        end: 100.0,
    };

    let (processed_arguments, forge_processor_progress) = process_forge(
        forge_arguments.launch_args,
        forge_arguments.jvm_args,
        forge_arguments.game_args,
        game_manifest,
        manifest,
    )
    .await?;
    execute_and_progress(
        collection_id,
        forge_processor_progress,
        forge_processor_bias,
    )
    .await?;
    Ok(launch_game(processed_arguments).await)
}

async fn launch_quilt(
    collection: Collection,
    collection_id: CollectionId,
) -> anyhow::Result<anyhow::Result<()>> {
    info!("Starts Vanilla Downloading");
    let vanilla_bias = DownloadBias {
        start: 0.0,
        end: 80.0,
    };
    let game_manifest = fetch_game_manifest(&collection.minecraft_version.url).await?;
    let (vanilla_download_args, vanilla_arguments) =
        prepare_vanilla_download(collection, game_manifest.clone()).await?;
    execute_and_progress(collection_id.clone(), vanilla_download_args, vanilla_bias).await?;

    info!("Starts Quilt Downloading");
    let quilt_download_bias = DownloadBias {
        start: 90.0,
        end: 100.0,
    };

    let (quilt_download_args, processed_arguments) = prepare_quilt_download(
        vanilla_arguments.launch_args,
        vanilla_arguments.jvm_args,
        vanilla_arguments.game_args,
    )
    .await?;
    execute_and_progress(
        collection_id.clone(),
        quilt_download_args,
        quilt_download_bias,
    )
    .await?;

    Ok(launch_game(processed_arguments.launch_args).await)
}

async fn launch_vanilla(
    collection: Collection,
    collection_id: CollectionId,
) -> anyhow::Result<anyhow::Result<()>> {
    info!("Starts Vanilla Downloading");
    let vanilla_bias = DownloadBias {
        start: 0.0,
        end: 100.0,
    };
    let game_manifest = fetch_game_manifest(&collection.minecraft_version.url).await?;
    let (vanilla_download_args, vanilla_arguments) =
        prepare_vanilla_download(collection, game_manifest.clone()).await?;
    execute_and_progress(collection_id, vanilla_download_args, vanilla_bias).await?;

    Ok(launch_game(vanilla_arguments.launch_args).await)
}
