# Era Connect (WIP)
<img src="readme/era_connect_coming_soon.png" width="7680"/>

## 📖 Introduction

## 🎉 How To Use

### Download the installer
- Windows: WIP
- macOS: WIP
- Linux: WIP

## ⚙️ Getting Started For Developers

To begin, ensure that you have a working installation of the following items:
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Rust language](https://rustup.rs/)

```bash
cargo install flutter_rust_bridge_codegen # https://cjycode.com/flutter_rust_bridge/integrate/deps.html#build-time-dependencies
cargo install just # https://crates.io/crates/just
```

### Generate binding for Rust <-> Dart
```bash
just gen lint
```

If you are using an Arch Linux machine, please execute the following command before generating the bindings:
```bash
export CPATH="$(clang -v 2>&1 | grep "Selected GCC installation" | rev | cut -d' ' -f1 | rev)/include"
```


## 🎓 LICENSE
The source code of this application is released under the [GNU General Public License v3.0 (GPL-3.0)](https://www.gnu.org/licenses/gpl-3.0.html). For more details, please refer to the [LICENSE](LICENSE) file.  

The fonts used in this project are licensed under the [SIL Open Font License (version 1.1)](https://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL). Please refer to the [license file](app/assets/fonts/SIL_Open_Font_License_1.1.txt) for the complete terms and conditions.

---
NOT AN OFFICIAL MINECRAFT PRODUCT. NOT APPROVED BY OR ASSOCIATED WITH MOJANG.