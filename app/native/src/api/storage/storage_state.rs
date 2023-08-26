use std::sync::Arc;

use tokio::sync::RwLock;

use crate::api::Collection;

use super::{
    account_storage::AccountStorage, storage_loader::StorageInstance, ui_layout::UILayout,
};
use anyhow::Error;
use log::error;

pub struct StorageState {
    pub account_storage: Arc<RwLock<AccountStorage>>,
    pub ui_layout: Arc<RwLock<UILayout>>,
    pub collection: Arc<RwLock<Vec<Collection>>>,
}

impl StorageState {
    pub fn new() -> Self {
        let account_storage = Self::load_storage(AccountStorage::load());
        let ui_layout = Self::load_storage(UILayout::load());
        let mut collection = Self::load_storage(Collection::scan());

        Self {
            account_storage: Arc::new(RwLock::new(account_storage)),
            ui_layout: Arc::new(RwLock::new(ui_layout)),
            collection: Arc::new(RwLock::new(
                collection.iter().flat_map(|x| x.load()).collect(),
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
