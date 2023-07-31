use std::{
    fs::{create_dir_all, File},
    io::{BufReader, BufWriter},
    path::PathBuf,
};

use serde::de::DeserializeOwned;
use serde::Serialize;

use crate::api::DATA_DIR;

pub struct ConfigLoader {
    file_name: String,
}

impl ConfigLoader {
    pub fn new(file_name: &str) -> Self {
        Self {
            file_name: file_name.to_string(),
        }
    }

    pub fn load<T: Default + DeserializeOwned + Serialize>(&self) -> anyhow::Result<T> {
        let path: &PathBuf = &self.get_path();
        if !path.exists() {
            let config = T::default();
            self.save(&config)?;
            return Ok(config);
        }

        let file = File::open(path)?;
        let reader = BufReader::new(file);
        let config = serde_json::from_reader(reader)?;
        Ok(config)
    }

    pub fn save<T: Serialize>(&self, config: &T) -> anyhow::Result<()> {
        create_dir_all(Self::get_config_directory())?;

        let file = File::create(self.get_path())?;
        let writer = BufWriter::new(file);
        serde_json::to_writer(writer, config)?;
        Ok(())
    }

    fn get_path(&self) -> PathBuf {
        Self::get_config_directory().join(&self.file_name)
    }

    fn get_config_directory() -> PathBuf {
        DATA_DIR.join("config")
    }
}
