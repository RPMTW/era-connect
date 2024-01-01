// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.9.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:uuid/uuid.dart';

// Rust type: flutter_rust_bridge::RustOpaque<std::sync::RwLock<PathBuf>>
@sealed
class PathBuf extends RustOpaque {
  PathBuf.dcoDecode(dynamic wire) : super.dcoDecode(wire, _kStaticData);

  PathBuf.sseDecode(int ptr, int externalSizeOnNative)
      : super.sseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount:
        RustLib.instance.api.rust_arc_increment_strong_count_PathBuf,
    rustArcDecrementStrongCount:
        RustLib.instance.api.rust_arc_decrement_strong_count_PathBuf,
    rustArcDecrementStrongCountPtr:
        RustLib.instance.api.rust_arc_decrement_strong_count_PathBufPtr,
  );
}

class AccountToken {
  final String token;
  final int expiresAt;

  const AccountToken({
    required this.token,
    required this.expiresAt,
  });

  @override
  int get hashCode => token.hashCode ^ expiresAt.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountToken &&
          runtimeType == other.runtimeType &&
          token == other.token &&
          expiresAt == other.expiresAt;
}

class MinecraftAccount {
  final String username;
  final UuidValue uuid;
  final AccountToken accessToken;
  final AccountToken refreshToken;
  final List<MinecraftSkin> skins;
  final List<MinecraftCape> capes;

  const MinecraftAccount({
    required this.username,
    required this.uuid,
    required this.accessToken,
    required this.refreshToken,
    required this.skins,
    required this.capes,
  });

  @override
  int get hashCode =>
      username.hashCode ^
      uuid.hashCode ^
      accessToken.hashCode ^
      refreshToken.hashCode ^
      skins.hashCode ^
      capes.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MinecraftAccount &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          uuid == other.uuid &&
          accessToken == other.accessToken &&
          refreshToken == other.refreshToken &&
          skins == other.skins &&
          capes == other.capes;
}

class MinecraftCape {
  final UuidValue id;
  final String state;
  final String url;
  final String alias;

  const MinecraftCape({
    required this.id,
    required this.state,
    required this.url,
    required this.alias,
  });

  @override
  int get hashCode =>
      id.hashCode ^ state.hashCode ^ url.hashCode ^ alias.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MinecraftCape &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          state == other.state &&
          url == other.url &&
          alias == other.alias;
}

class MinecraftSkin {
  final UuidValue id;
  final String state;
  final String url;
  final MinecraftSkinVariant variant;

  const MinecraftSkin({
    required this.id,
    required this.state,
    required this.url,
    required this.variant,
  });

  Future<PathBuf> getHeadFilePath({dynamic hint}) =>
      RustLib.instance.api.minecraftSkinGetHeadFilePath(
        that: this,
      );

  @override
  int get hashCode =>
      id.hashCode ^ state.hashCode ^ url.hashCode ^ variant.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MinecraftSkin &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          state == other.state &&
          url == other.url &&
          variant == other.variant;
}

enum MinecraftSkinVariant {
  classic,
  slim,
}
