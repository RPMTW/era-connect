use std::sync::Arc;

use tokio::sync::RwLock;

use crate::api::shared_resources::collection::Collection;

use super::{
    account_storage::AccountStorage,
    storage_loader::{StorageInstance, StorageLoader},
    ui_layout::UILayout,
};
use anyhow::Error;
use log::error;

pub struct StorageState {
    pub account_storage: Arc<RwLock<AccountStorage>>,
    pub ui_layout: Arc<RwLock<UILayout>>,
    pub collections: Arc<RwLock<Vec<Collection>>>,
}

impl StorageState {
    pub fn new() -> Self {
        let account_storage = Self::load_storage(AccountStorage::load());
        let ui_layout = Self::load_storage(UILayout::load());
        let collection_loaders = Self::load_storage(Collection::scan());

        Self {
            account_storage: Arc::new(RwLock::new(account_storage)),
            ui_layout: Arc::new(RwLock::new(ui_layout)),
            collections: Arc::new(RwLock::new(
                collection_loaders
                    .iter()
                    .flat_map(StorageLoader::load)
                    .collect(),
            )),
        }
    }

    fn load_storage<T: Default>(result: Result<T, Error>) -> T {
        match result {
            Ok(storage) => storage,
            Err(e) => {
                error!(
                    "Failed to load {} storage file: {:#?}",
                    std::any::type_name::<T>(),
                    e
                );
                T::default()
            }
        }
    }
}
