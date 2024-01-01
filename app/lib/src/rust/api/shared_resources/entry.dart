// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.7.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../frb_generated.dart';
import '../backend_exclusive/storage/account_storage.dart';
import '../backend_exclusive/storage/ui_layout.dart';
import '../backend_exclusive/vanilla/version.dart';
import 'authentication/account.dart';
import 'authentication/msa_flow.dart';
import 'collection.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:uuid/uuid.dart';

Future<void> setupLogger({dynamic hint}) =>
    RustLib.instance.api.setupLogger(hint: hint);

UILayoutValue getUiLayoutStorage({required UILayoutKey key, dynamic hint}) =>
    RustLib.instance.api.getUiLayoutStorage(key: key, hint: hint);

Future<List<VersionMetadata>> getVanillaVersions({dynamic hint}) =>
    RustLib.instance.api.getVanillaVersions(hint: hint);

Future<void> setUiLayoutStorage({required UILayoutValue value, dynamic hint}) =>
    RustLib.instance.api.setUiLayoutStorage(value: value, hint: hint);

AccountStorageValue getAccountStorage(
        {required AccountStorageKey key, dynamic hint}) =>
    RustLib.instance.api.getAccountStorage(key: key, hint: hint);

String getSkinFilePath({required MinecraftSkin skin, dynamic hint}) =>
    RustLib.instance.api.getSkinFilePath(skin: skin, hint: hint);

Future<void> removeMinecraftAccount({required UuidValue uuid, dynamic hint}) =>
    RustLib.instance.api.removeMinecraftAccount(uuid: uuid, hint: hint);

Stream<LoginFlowEvent> minecraftLoginFlow({dynamic hint}) =>
    RustLib.instance.api.minecraftLoginFlow(hint: hint);

Future<void> createCollection(
        {required String displayName,
        required VersionMetadata versionMetadata,
        ModLoader? modLoader,
        AdvancedOptions? advancedOptions,
        dynamic hint}) =>
    RustLib.instance.api.createCollection(
        displayName: displayName,
        versionMetadata: versionMetadata,
        modLoader: modLoader,
        advancedOptions: advancedOptions,
        hint: hint);