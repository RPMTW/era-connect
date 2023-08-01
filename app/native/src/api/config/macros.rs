// use crate::api::UILayout;
use std::path::PathBuf;

macro_rules! impl_get_value {
    ($struct_name:ident { $($field:ident : $field_ty:ty,)* }) => {
        pub struct $struct_name {
            $(
              $field : $field_ty,
            )*
        }
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
        }
    };
}

impl_get_value!(UILayout {
    fail: String,
    completed_setup: bool,
    another_thing: PathBuf,
});
