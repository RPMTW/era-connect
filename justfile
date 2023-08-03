default: gen lint

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

test:
    dart pub global activate full_coverage
    rm -rf coverage
    mkdir -p coverage

    cd app && flutter pub get
    cd app && dart pub global run full_coverage --ignore bridge_generated.dart,bridge_definitions.dart,bridge_generated.io.dart,ffi.dart
    cd app && flutter test --coverage
    cd app && sed "s/^SF:.*lib/SF:app\/lib/g" coverage/lcov.info >> ../coverage/lcov.info

    cd packages && for d in */ ; do \
      echo "Processing $d"; \
      cd $d; \
      flutter pub get; \
      dart pub global run full_coverage; \
      flutter test --coverage; \
      escapedPath="$(echo packages/$d | sed 's/\//\\\//g')"; \
      sed "s/^SF:.*lib/SF:${escapedPath}lib/g" coverage/lcov.info >> ../../coverage/lcov.info; \
      rm -rf coverage; \
      cd ..; \
    done

# vim:expandtab:sw=4:ts=4
