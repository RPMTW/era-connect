use std::{
    fs::{create_dir_all, File},
    io::{BufReader, BufWriter},
    path::PathBuf,
};

use serde::de::DeserializeOwned;
use serde::Serialize;

pub struct ConfigLoader {
    file_name: String,
    config_directory: PathBuf,
}

impl ConfigLoader {
    pub fn new(file_name: String) -> Self {
        Self {
            file_name,
            config_directory: dirs::data_dir().unwrap().join("era-connect/config"),
        }
    }

    pub fn load<T: Default + DeserializeOwned + Serialize>(&self) -> anyhow::Result<T> {
        let path = &self.get_path();
        if !path.exists() {
            create_dir_all(&self.config_directory)?;
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
        let file = File::create(&self.get_path())?;
        let writer = BufWriter::new(file);
        serde_json::to_writer_pretty(writer, config)?;
        Ok(())
    }

    fn get_path(&self) -> PathBuf {
        self.config_directory.join(&self.file_name)
    }
}
