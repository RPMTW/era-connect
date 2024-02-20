use std::{path::PathBuf, sync::Arc};

use tokio::sync::RwLock;

use crate::api::shared_resources::collection::Collection;

use super::{
    account_storage::AccountStorage, storage_loader::StorageInstance, ui_layout::GlobalSettings,
};

pub struct StorageState {
    pub account_storage: Arc<RwLock<AccountStorage>>,
    pub collections: Arc<RwLock<Vec<Collection>>>,
    pub global_settings: Arc<RwLock<GlobalSettings>>,
}

impl StorageState {
    pub fn new() -> Self {
        let account_storage = AccountStorage::load().unwrap_or_default();
        let collections = Collection::scan().unwrap_or_default();
        let global_settings = GlobalSettings::load().unwrap_or_default();

        Self {
            account_storage: Arc::new(RwLock::new(account_storage)),
            global_settings: Arc::new(RwLock::new(global_settings)),
            collections: Arc::new(RwLock::new(collections)),
        }
    }
}
