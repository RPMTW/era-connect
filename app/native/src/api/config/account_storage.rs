use std::collections::HashMap;

use serde::{Deserialize, Serialize};
use uuid::Uuid;

use crate::api::MinecraftAccount;

use super::config_loader::{ConfigInstance, ConfigLoader};

const ACCOUNT_FILE_NAME: &str = "accounts.json";

#[derive(Serialize, Deserialize, Default, Clone, Debug)]
#[serde(default)]
pub struct AccountStorage {
    pub accounts: HashMap<Uuid, MinecraftAccount>,
    /// The uuid of the main account in the [accounts] vector
    pub main_account: Option<Uuid>,
}

impl ConfigInstance<Self> for AccountStorage {
    fn file_name() -> &'static str {
        ACCOUNT_FILE_NAME
    }

    fn save(&self) -> anyhow::Result<()> {
        let loader = ConfigLoader::new(Self::file_name().to_owned());
        loader.save(self)
    }
}

impl AccountStorage {
    pub fn add_account(&mut self, account: &MinecraftAccount, is_main_account: Option<bool>) {
        self.accounts.insert(account.uuid, account.clone());

        let set_as_main_account = is_main_account.unwrap_or(false)
            || self.accounts.len() == 1
            || self.main_account.is_none();

        if set_as_main_account {
            self.main_account = Some(account.uuid);
        }
    }
}
