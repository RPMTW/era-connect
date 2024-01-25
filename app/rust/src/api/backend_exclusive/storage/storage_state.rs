use std::sync::Arc;

use tokio::sync::RwLock;

use crate::api::shared_resources::collection::Collection;

use super::{
    account_storage::AccountStorage, storage_loader::StorageInstance, ui_layout::UILayout,
};

pub struct StorageState {
    pub account_storage: Arc<RwLock<AccountStorage>>,
    pub ui_layout: Arc<RwLock<UILayout>>,
    pub collections: Arc<RwLock<Vec<Collection>>>,
}

impl StorageState {
    pub fn new() -> Self {
        let account_storage = AccountStorage::load().unwrap_or_default();
        let ui_layout = UILayout::load().unwrap_or_default();
        let collections = Collection::scan().unwrap_or_default();

        Self {
            account_storage: Arc::new(RwLock::new(account_storage)),
            ui_layout: Arc::new(RwLock::new(ui_layout)),
            collections: Arc::new(RwLock::new(collections)),
        }
    }
}
