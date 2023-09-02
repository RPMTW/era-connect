//! example
//! ```rust
//! #[derive(VariantStruct)]
//! pub struct {
//!     field1: String,
//!     field2: i32,
//! }
//! ```
//! would turn into
//! ```rust
//! pub enum StructKey {
//!     Field1,
//!     Field2,
//! }
//! pub enum StructValue {
//!     Field1(String)    
//!     Field2(i32)
//! }
//! impl struct {
//!     pub fn get_value(&self, key: StructKey) -> StructValue {
//!         match key {
//!             StructKey::Field1 => StructValue::Field1(self.field1.clone()),
//!             StructKey::Field2 => StructValue::Field2(self.field2.clone()),
//!         }
//!     }
//!     pub fn set_value(&mut self, value: StructValue) {
//!         match value {
//!             StructValue::Field1(x) => self.field1 = x,
//!             StructValue::Field2(x) => self.field2 = x,
//!         }
//!     }
//! }
//! ```
//! The main use case of this library is to provide a idiomatic way to get a single key out of a struct using enums.
//! note that the value WILL be cloned. There is no way around that without using lifetimes hacks.

use inflector::Inflector;
use proc_macro::TokenStream;
use quote::{format_ident, quote};
use syn::{parse_macro_input, Ident, ItemStruct};

#[proc_macro_derive(VariantStruct)]
pub fn variants_enum(input: TokenStream) -> TokenStream {
    let input = parse_macro_input!(input as ItemStruct);
    let struct_ident = input.ident.clone();
    let key_ident = format_ident!("{}Key", input.ident);
    let value_ident = format_ident!("{}Value", input.ident);
    let mut ident = Vec::new();
    let mut camel = Vec::new();
    let mut types = Vec::new();

    for field in input.fields {
        if let Some(x) = field.ident {
            let identifier = x.to_string().to_pascal_case();
            let span = x.span();
            ident.push(x);
            camel.push(Ident::new(identifier.as_str(), span));
        }
        types.push(field.ty);
    }

    let gen = quote! {
        pub enum #key_ident {
            #(#camel),*
        }
        pub enum #value_ident {
            #(#camel(#types)),*
        }
        impl #struct_ident {
            pub fn get_value(&self, key: #key_ident) -> #value_ident {
                match key {
                    #(
                        #key_ident::#camel => #value_ident::#camel(self.#ident.clone())
                    ),*
                }
            }
            pub fn set_value(&mut self, value: #value_ident) {
                match value {
                    #(
                       #value_ident::#camel(x) => self.#ident = x
                    ),*
                }
            }
        }
    };
    gen.into()
}
