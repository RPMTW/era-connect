use std::{
    fs::{create_dir_all, File},
    io::{BufReader, BufWriter},
    path::PathBuf,
};

use serde::de::DeserializeOwned;
use serde::Serialize;

use crate::api::DATA_DIR;

pub struct StorageLoader {
    file_name: String,
}

impl StorageLoader {
    pub const fn new(file_name: String) -> Self {
        Self { file_name }
    }

    pub fn load<T: Default + DeserializeOwned + Serialize>(&self) -> anyhow::Result<T> {
        let path = self.get_path_buf();
        if !path.exists() {
            let storage = T::default();
            self.save(&storage)?;
            return Ok(storage);
        }

        let file = File::open(path)?;
        let reader = BufReader::new(file);
        let storage = serde_json::from_reader(reader)?;
        Ok(storage)
    }

    pub fn save<T: Serialize>(&self, storage: &T) -> anyhow::Result<()> {
        create_dir_all(Self::get_storage_directory())?;

        let file = File::create(self.get_path_buf())?;
        let writer = BufWriter::new(file);
        serde_json::to_writer(writer, storage)?;
        Ok(())
    }

    fn get_path_buf(&self) -> PathBuf {
        Self::get_storage_directory().join(&self.file_name)
    }

    fn get_storage_directory() -> PathBuf {
        DATA_DIR.join("storages")
    }
}

pub trait StorageInstance<T: Default + DeserializeOwned + Serialize> {
    fn file_name() -> &'static str;

    fn load() -> anyhow::Result<T> {
        let loader = StorageLoader::new(Self::file_name().to_owned());
        loader.load::<T>()
    }

    fn save(&self) -> anyhow::Result<()>;
}
