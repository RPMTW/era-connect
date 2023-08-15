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
            ident.push(x);
            let t = ident.last().unwrap();
            let span = t.span();
            camel.push(Ident::new(t.to_string().to_pascal_case().as_str(), span));
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
