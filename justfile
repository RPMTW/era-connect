default: gen lint

gen:
    cd app && flutter pub get
    cd app && flutter_rust_bridge_codegen \
        --rust-input native/src/api.rs \
        --dart-output lib/bridge_generated.dart \
        --extra-c-output-path macos/Runner/ \
        --dart-decl-output lib/bridge_definitions.dart \
        --wasm

lint:
    cd app/native && cargo fmt
    cd app && dart format .

clean:
    cd app flutter clean
    cd native && cargo clean

# vim:expandtab:sw=4:ts=4
