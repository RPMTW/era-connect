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
    base_path: PathBuf,
}

impl StorageLoader {
    pub const fn new(file_name: String, base_path: PathBuf) -> Self {
        Self {
            file_name,
            base_path,
        }
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
        create_dir_all(self.get_storage_directory())?;

        let file = File::create(self.get_path_buf())?;
        let writer = BufWriter::new(file);
        serde_json::to_writer(writer, storage)?;
        Ok(())
    }

    fn get_path_buf(&self) -> PathBuf {
        self.get_storage_directory().join(&self.file_name)
    }

    fn get_storage_directory(&self) -> PathBuf {
        DATA_DIR.join(&self.base_path)
    }
}

pub trait StorageInstance<T: Default + DeserializeOwned + Serialize> {
    fn file_name() -> &'static str;

    fn base_path() -> PathBuf;

    fn save(&self) -> anyhow::Result<()>;

    fn load() -> anyhow::Result<T> {
        let loader = StorageLoader::new(Self::file_name().to_owned(), Self::base_path());
        loader.load::<T>()
    }
}

pub trait StorageInstanceMultiple<T: Default + DeserializeOwned + Serialize> {
    fn file_names() -> Vec<String>;

    fn base_path() -> PathBuf;

    fn save(&self) -> anyhow::Result<()>;

    fn load() -> anyhow::Result<Vec<T>> {
        let mut p = Vec::new();
        for file_name in Self::file_names() {
            let loader = StorageLoader::new(file_name.to_owned(), Self::base_path());
            p.push(loader.load::<T>()?)
        }
        Ok(p)
    }
}
