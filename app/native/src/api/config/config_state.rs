use tokio::sync::RwLock;

use super::{account_storage::AccountStorage, config_loader::ConfigInstance, ui_layout::UILayout};
use anyhow::Error;
use log::error;

pub struct ConfigState {
    pub account_storage: RwLock<AccountStorage>,
    pub ui_layout: RwLock<UILayout>,
}

impl ConfigState {
    pub fn new() -> Self {
        let account_storage = Self::load_config(AccountStorage::load());
        let ui_layout = Self::load_config(UILayout::load());

        Self {
            account_storage: RwLock::new(account_storage),
            ui_layout: RwLock::new(ui_layout),
        }
    }

    fn load_config<T: Default>(result: Result<T, Error>) -> T {
        match result {
            Ok(config) => config,
            Err(e) => {
                error!(
                    "Failed to load {} config: {:#?}",
                    std::any::type_name::<T>(),
                    e
                );
                T::default()
            }
        }
    }
}
