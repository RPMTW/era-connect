default: _install_cargo_deps gen lint

gen:
    cd app && flutter pub get
    cd app && flutter_rust_bridge_codegen \
        --rust-input native/src/api.rs \
        --dart-output lib/api/gen/bridge_generated.dart \
        --c-output macos/Runner/bridge_generated.h \
        --dart-decl-output lib/api/gen/bridge_definitions.dart

lint:
    cd app/native && cargo fmt
    cd app && dart format .

clean:
    cd app flutter clean
    cd native && cargo clean

run: 
    cd app && flutter pub get && flutter run

test:
    dart pub global activate full_coverage
    rm -rf coverage
    mkdir -p coverage

    cd app && flutter pub get
    just _ignore_generated_files_coverage
    cd app && dart pub global run full_coverage

    cd app && flutter test --coverage
    cd app && sed "s/^SF:.*lib/SF:app\/lib/g" coverage/lcov.info >> ../coverage/lcov.info    

    cd packages && for d in */ ; do \
      echo "Processing $d"; \
      cd $d; \
      flutter pub get; \
      dart pub global run full_coverage; \
      flutter test --coverage; \
      escaped_path="$(echo packages/$d | sed 's/\//\\\//g')"; \
      sed "s/^SF:.*lib/SF:${escaped_path}lib/g" coverage/lcov.info >> ../../coverage/lcov.info; \
      rm -rf coverage; \
      cd ..; \
    done

_ignore_generated_files_coverage:
    generated_files=$(find app/lib/api/gen -name '*.dart' -type f); \
    generated_files="$generated_files app/lib/api/ffi.dart"; \
    for file in $generated_files; do \
      grep -q "// coverage:ignore-file" $file && continue; \
      echo "// coverage:ignore-file" | cat - $file > temp && mv temp $file; \
    done

_install_cargo_deps:
    cargo install flutter_rust_bridge_codegen
    cargo install cargo-expand

# vim:expandtab:sw=4:ts=4
