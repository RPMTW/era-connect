use std::{
    borrow::Cow,
    fs::{create_dir_all, File},
    io::{BufReader, BufWriter},
    path::{Path, PathBuf},
};

use serde::de::DeserializeOwned;
use serde::Serialize;

use crate::api::DATA_DIR;

pub struct StorageLoader {
    file_name: String,
    base_path: PathBuf,
}

impl StorageLoader {
    pub fn new(file_name: String, base_path: Cow<Path>) -> Self {
        let base_path = match base_path {
            Cow::Borrowed(c) => c.to_path_buf(),
            Cow::Owned(x) => x,
        };

        Self {
            file_name,
            base_path,
        }
    }

    pub fn load<T: DeserializeOwned + Serialize>(&self) -> anyhow::Result<T> {
        let file = File::open(self.get_path_buf())?;
        let reader = BufReader::new(file);
        let storage = serde_json::from_reader(reader)?;

        Ok(storage)
    }

    pub fn load_with_default<T: Default + DeserializeOwned + Serialize>(
        &self,
    ) -> anyhow::Result<T> {
        let path = self.get_path_buf();
        if !path.exists() {
            let storage = T::default();
            self.save(&storage)?;
            return Ok(storage);
        }

        self.load()
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

    fn base_path() -> PathBuf {
        PathBuf::from("storages")
    }

    fn save(&self) -> anyhow::Result<()>;

    fn load() -> anyhow::Result<T> {
        let loader =
            StorageLoader::new(Self::file_name().to_owned(), Cow::Owned(Self::base_path()));
        loader.load_with_default::<T>()
    }
}
