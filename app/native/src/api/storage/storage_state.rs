use tokio::sync::RwLock;

use super::{
    account_storage::AccountStorage, storage_loader::StorageInstance, ui_layout::UILayout,
};
use anyhow::Error;
use log::error;

pub struct StorageState {
    pub account_storage: RwLock<AccountStorage>,
    pub ui_layout: RwLock<UILayout>,
}

impl StorageState {
    pub fn new() -> Self {
        let account_storage = Self::load_storage(AccountStorage::load());
        let ui_layout = Self::load_storage(UILayout::load());

        Self {
            account_storage: RwLock::new(account_storage),
            ui_layout: RwLock::new(ui_layout),
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
