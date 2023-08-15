pub use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use super::config_loader::ConfigLoader;

const UI_LAYOUT_FILE_NAME: &str = "ui_layout.json";

#[derive(Serialize, Deserialize, Default, Clone, Debug)]
#[serde(default)]
pub struct UILayout {
    pub completed_setup: bool,
}

macro_rules! impl_get_value {
    ($struct_name:ident { $($field:ident : $field_ty:ty,)* }) => {
        pub enum Key {
            $(
                #[allow(non_camel_case_types)]
                $field,
            )*
        }

        pub enum Value {
            $(
                #[allow(non_camel_case_types)]
                $field($field_ty),
            )*
        }
        impl $struct_name {
            pub fn get_value(&self, key: Key) -> Value {
                match key {
                    $(
                        Key::$field => {
                            Value::$field(self.$field.clone())
                        },
                    )*
                }
            }
            pub fn set_value(&mut self, value: Value) {
                match value {
                    $(
                        Value::$field(x) => self.$field = x,
                    )*
                }
            }
        }
    };
}

impl_get_value!(UILayout {
    completed_setup: bool,
});

impl UILayout {
    // pub const fn get_value(&self, key: Key) -> Value {
    //     match key {
    //         Key::CompletedSetup => Value::CompletedSetup(self.completed_setup),
    //     }
    // }

    // pub fn set_value(&mut self, value: Value) {
    //     match value {
    //         Value::CompletedSetup(x) => self.completed_setup = x,
    //     }
    // }

    pub fn load() -> anyhow::Result<Self> {
        let loader = ConfigLoader::new(UI_LAYOUT_FILE_NAME.to_owned());
        loader.load()
    }

    pub fn save(&self) -> anyhow::Result<()> {
        let loader = ConfigLoader::new(UI_LAYOUT_FILE_NAME.to_owned());
        loader.save(&self)
    }
}
