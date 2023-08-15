use inflector::Inflector;
use proc_macro::TokenStream;
use quote::{format_ident, quote};
use syn::{parse_macro_input, spanned::Spanned, Ident, ItemStruct};

#[proc_macro_derive(VariantStruct)]
pub fn variants_enum(input: TokenStream) -> TokenStream {
    let input = parse_macro_input!(input as ItemStruct);
    let span = input.span();
    let struct_ident = input.ident.clone();
    let key_ident = format_ident!("{}Key", input.ident);
    let value_ident = format_ident!("{}Value", input.ident);
    let ident = input
        .fields
        .iter()
        .map(|field| field.ident.as_ref())
        .flatten()
        .collect::<Vec<_>>();
    let camel = ident
        .iter()
        .map(|ident| Ident::new(ident.to_string().to_pascal_case().as_str(), span))
        .collect::<Vec<_>>();
    let types = input
        .fields
        .clone()
        .into_iter()
        .map(|x| x.ty)
        .collect::<Vec<_>>();
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
