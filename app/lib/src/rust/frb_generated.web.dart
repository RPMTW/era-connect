// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.9.

// ignore_for_file: unused_import, unused_element, unnecessary_import, duplicate_ignore, invalid_use_of_internal_member, annotate_overrides, non_constant_identifier_names, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'api/backend_exclusive/storage/account_storage.dart';
import 'api/backend_exclusive/storage/ui_layout.dart';
import 'api/backend_exclusive/vanilla/version.dart';
import 'api/shared_resources/authentication/account.dart';
import 'api/shared_resources/authentication/msa_flow.dart';
import 'api/shared_resources/collection.dart';
import 'api/shared_resources/entry.dart';
import 'dart:async';
import 'dart:convert';
import 'frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated_web.dart';
import 'package:uuid/uuid.dart';

abstract class RustLibApiImplPlatform extends BaseApiImpl<RustLibWire> {
  RustLibApiImplPlatform({
    required super.handler,
    required super.wire,
    required super.generalizedFrbRustBinding,
    required super.portManager,
  });

  CrossPlatformFinalizerArg get rust_arc_decrement_strong_count_PathBufPtr =>
      wire.rust_arc_decrement_strong_count_RustOpaque_stdsyncRwLockPathBuf;

  CrossPlatformFinalizerArg
      get rust_arc_decrement_strong_count_StorageLoaderPtr => wire
          .rust_arc_decrement_strong_count_RustOpaque_stdsyncRwLockVeccrateapibackend_exclusivestoragestorage_loaderStorageLoader;

  CrossPlatformFinalizerArg
      get rust_arc_decrement_strong_count_StorageLoaderPathBufPtr => wire
          .rust_arc_decrement_strong_count_RustOpaque_stdsyncRwLockcrateapibackend_exclusivestoragestorage_loaderStorageLoaderPathBuf;

  CrossPlatformFinalizerArg get rust_arc_decrement_strong_count_CollectionPtr =>
      wire.rust_arc_decrement_strong_count_RustOpaque_stdsyncRwLockcrateapishared_resourcescollectionCollection;

  @protected
  AnyhowException dco_decode_AnyhowException(dynamic raw);

  @protected
  PathBuf dco_decode_Auto_Owned_RustOpaque_stdsyncRwLockPathBuf(dynamic raw);

  @protected
  StorageLoader
      dco_decode_Auto_Owned_RustOpaque_stdsyncRwLockVeccrateapibackend_exclusivestoragestorage_loaderStorageLoader(
          dynamic raw);

  @protected
  StorageLoaderPathBuf
      dco_decode_Auto_Owned_RustOpaque_stdsyncRwLockcrateapibackend_exclusivestoragestorage_loaderStorageLoaderPathBuf(
          dynamic raw);

  @protected
  Collection
      dco_decode_Auto_Ref_RustOpaque_stdsyncRwLockcrateapishared_resourcescollectionCollection(
          dynamic raw);

  @protected
  DateTime dco_decode_Chrono_Utc(dynamic raw);

  @protected
  PathBuf dco_decode_RustOpaque_stdsyncRwLockPathBuf(dynamic raw);

  @protected
  StorageLoader
      dco_decode_RustOpaque_stdsyncRwLockVeccrateapibackend_exclusivestoragestorage_loaderStorageLoader(
          dynamic raw);

  @protected
  StorageLoaderPathBuf
      dco_decode_RustOpaque_stdsyncRwLockcrateapibackend_exclusivestoragestorage_loaderStorageLoaderPathBuf(
          dynamic raw);

  @protected
  Collection
      dco_decode_RustOpaque_stdsyncRwLockcrateapishared_resourcescollectionCollection(
          dynamic raw);

  @protected
  String dco_decode_String(dynamic raw);

  @protected
  UuidValue dco_decode_Uuid(dynamic raw);

  @protected
  AccountStorageKey dco_decode_account_storage_key(dynamic raw);

  @protected
  AccountStorageValue dco_decode_account_storage_value(dynamic raw);

  @protected
  AccountToken dco_decode_account_token(dynamic raw);

  @protected
  AdvancedOptions dco_decode_advanced_options(dynamic raw);

  @protected
  bool dco_decode_bool(dynamic raw);

  @protected
  AdvancedOptions dco_decode_box_autoadd_advanced_options(dynamic raw);

  @protected
  LoginFlowDeviceCode dco_decode_box_autoadd_login_flow_device_code(
      dynamic raw);

  @protected
  LoginFlowErrors dco_decode_box_autoadd_login_flow_errors(dynamic raw);

  @protected
  MinecraftAccount dco_decode_box_autoadd_minecraft_account(dynamic raw);

  @protected
  MinecraftSkin dco_decode_box_autoadd_minecraft_skin(dynamic raw);

  @protected
  ModLoader dco_decode_box_autoadd_mod_loader(dynamic raw);

  @protected
  UILayoutValue dco_decode_box_autoadd_ui_layout_value(dynamic raw);

  @protected
  int dco_decode_box_autoadd_usize(dynamic raw);

  @protected
  VersionMetadata dco_decode_box_autoadd_version_metadata(dynamic raw);

  @protected
  CollectionId dco_decode_collection_id(dynamic raw);

  @protected
  int dco_decode_i_32(dynamic raw);

  @protected
  int dco_decode_i_64(dynamic raw);

  @protected
  List<MinecraftAccount> dco_decode_list_minecraft_account(dynamic raw);

  @protected
  List<MinecraftCape> dco_decode_list_minecraft_cape(dynamic raw);

  @protected
  List<MinecraftSkin> dco_decode_list_minecraft_skin(dynamic raw);

  @protected
  Uint8List dco_decode_list_prim_u_8(dynamic raw);

  @protected
  List<VersionMetadata> dco_decode_list_version_metadata(dynamic raw);

  @protected
  LoginFlowDeviceCode dco_decode_login_flow_device_code(dynamic raw);

  @protected
  LoginFlowErrors dco_decode_login_flow_errors(dynamic raw);

  @protected
  LoginFlowEvent dco_decode_login_flow_event(dynamic raw);

  @protected
  LoginFlowStage dco_decode_login_flow_stage(dynamic raw);

  @protected
  MinecraftAccount dco_decode_minecraft_account(dynamic raw);

  @protected
  MinecraftCape dco_decode_minecraft_cape(dynamic raw);

  @protected
  MinecraftSkin dco_decode_minecraft_skin(dynamic raw);

  @protected
  MinecraftSkinVariant dco_decode_minecraft_skin_variant(dynamic raw);

  @protected
  ModLoader dco_decode_mod_loader(dynamic raw);

  @protected
  ModLoaderType dco_decode_mod_loader_type(dynamic raw);

  @protected
  String? dco_decode_opt_String(dynamic raw);

  @protected
  UuidValue? dco_decode_opt_Uuid(dynamic raw);

  @protected
  AdvancedOptions? dco_decode_opt_box_autoadd_advanced_options(dynamic raw);

  @protected
  ModLoader? dco_decode_opt_box_autoadd_mod_loader(dynamic raw);

  @protected
  int? dco_decode_opt_box_autoadd_usize(dynamic raw);

  @protected
  int dco_decode_u_32(dynamic raw);

  @protected
  int dco_decode_u_8(dynamic raw);

  @protected
  UILayoutKey dco_decode_ui_layout_key(dynamic raw);

  @protected
  UILayoutValue dco_decode_ui_layout_value(dynamic raw);

  @protected
  void dco_decode_unit(dynamic raw);

  @protected
  int dco_decode_usize(dynamic raw);

  @protected
  VersionMetadata dco_decode_version_metadata(dynamic raw);

  @protected
  VersionType dco_decode_version_type(dynamic raw);

  @protected
  XstsTokenErrorType dco_decode_xsts_token_error_type(dynamic raw);

  @protected
  AnyhowException sse_decode_AnyhowException(SseDeserializer deserializer);

  @protected
  PathBuf sse_decode_Auto_Owned_RustOpaque_stdsyncRwLockPathBuf(
      SseDeserializer deserializer);

  @protected
  StorageLoader
      sse_decode_Auto_Owned_RustOpaque_stdsyncRwLockVeccrateapibackend_exclusivestoragestorage_loaderStorageLoader(
          SseDeserializer deserializer);

  @protected
  StorageLoaderPathBuf
      sse_decode_Auto_Owned_RustOpaque_stdsyncRwLockcrateapibackend_exclusivestoragestorage_loaderStorageLoaderPathBuf(
          SseDeserializer deserializer);

  @protected
  Collection
      sse_decode_Auto_Ref_RustOpaque_stdsyncRwLockcrateapishared_resourcescollectionCollection(
          SseDeserializer deserializer);

  @protected
  DateTime sse_decode_Chrono_Utc(SseDeserializer deserializer);

  @protected
  PathBuf sse_decode_RustOpaque_stdsyncRwLockPathBuf(
      SseDeserializer deserializer);

  @protected
  StorageLoader
      sse_decode_RustOpaque_stdsyncRwLockVeccrateapibackend_exclusivestoragestorage_loaderStorageLoader(
          SseDeserializer deserializer);

  @protected
  StorageLoaderPathBuf
      sse_decode_RustOpaque_stdsyncRwLockcrateapibackend_exclusivestoragestorage_loaderStorageLoaderPathBuf(
          SseDeserializer deserializer);

  @protected
  Collection
      sse_decode_RustOpaque_stdsyncRwLockcrateapishared_resourcescollectionCollection(
          SseDeserializer deserializer);

  @protected
  String sse_decode_String(SseDeserializer deserializer);

  @protected
  UuidValue sse_decode_Uuid(SseDeserializer deserializer);

  @protected
  AccountStorageKey sse_decode_account_storage_key(
      SseDeserializer deserializer);

  @protected
  AccountStorageValue sse_decode_account_storage_value(
      SseDeserializer deserializer);

  @protected
  AccountToken sse_decode_account_token(SseDeserializer deserializer);

  @protected
  AdvancedOptions sse_decode_advanced_options(SseDeserializer deserializer);

  @protected
  bool sse_decode_bool(SseDeserializer deserializer);

  @protected
  AdvancedOptions sse_decode_box_autoadd_advanced_options(
      SseDeserializer deserializer);

  @protected
  LoginFlowDeviceCode sse_decode_box_autoadd_login_flow_device_code(
      SseDeserializer deserializer);

  @protected
  LoginFlowErrors sse_decode_box_autoadd_login_flow_errors(
      SseDeserializer deserializer);

  @protected
  MinecraftAccount sse_decode_box_autoadd_minecraft_account(
      SseDeserializer deserializer);

  @protected
  MinecraftSkin sse_decode_box_autoadd_minecraft_skin(
      SseDeserializer deserializer);

  @protected
  ModLoader sse_decode_box_autoadd_mod_loader(SseDeserializer deserializer);

  @protected
  UILayoutValue sse_decode_box_autoadd_ui_layout_value(
      SseDeserializer deserializer);

  @protected
  int sse_decode_box_autoadd_usize(SseDeserializer deserializer);

  @protected
  VersionMetadata sse_decode_box_autoadd_version_metadata(
      SseDeserializer deserializer);

  @protected
  CollectionId sse_decode_collection_id(SseDeserializer deserializer);

  @protected
  int sse_decode_i_32(SseDeserializer deserializer);

  @protected
  int sse_decode_i_64(SseDeserializer deserializer);

  @protected
  List<MinecraftAccount> sse_decode_list_minecraft_account(
      SseDeserializer deserializer);

  @protected
  List<MinecraftCape> sse_decode_list_minecraft_cape(
      SseDeserializer deserializer);

  @protected
  List<MinecraftSkin> sse_decode_list_minecraft_skin(
      SseDeserializer deserializer);

  @protected
  Uint8List sse_decode_list_prim_u_8(SseDeserializer deserializer);

  @protected
  List<VersionMetadata> sse_decode_list_version_metadata(
      SseDeserializer deserializer);

  @protected
  LoginFlowDeviceCode sse_decode_login_flow_device_code(
      SseDeserializer deserializer);

  @protected
  LoginFlowErrors sse_decode_login_flow_errors(SseDeserializer deserializer);

  @protected
  LoginFlowEvent sse_decode_login_flow_event(SseDeserializer deserializer);

  @protected
  LoginFlowStage sse_decode_login_flow_stage(SseDeserializer deserializer);

  @protected
  MinecraftAccount sse_decode_minecraft_account(SseDeserializer deserializer);

  @protected
  MinecraftCape sse_decode_minecraft_cape(SseDeserializer deserializer);

  @protected
  MinecraftSkin sse_decode_minecraft_skin(SseDeserializer deserializer);

  @protected
  MinecraftSkinVariant sse_decode_minecraft_skin_variant(
      SseDeserializer deserializer);

  @protected
  ModLoader sse_decode_mod_loader(SseDeserializer deserializer);

  @protected
  ModLoaderType sse_decode_mod_loader_type(SseDeserializer deserializer);

  @protected
  String? sse_decode_opt_String(SseDeserializer deserializer);

  @protected
  UuidValue? sse_decode_opt_Uuid(SseDeserializer deserializer);

  @protected
  AdvancedOptions? sse_decode_opt_box_autoadd_advanced_options(
      SseDeserializer deserializer);

  @protected
  ModLoader? sse_decode_opt_box_autoadd_mod_loader(
      SseDeserializer deserializer);

  @protected
  int? sse_decode_opt_box_autoadd_usize(SseDeserializer deserializer);

  @protected
  int sse_decode_u_32(SseDeserializer deserializer);

  @protected
  int sse_decode_u_8(SseDeserializer deserializer);

  @protected
  UILayoutKey sse_decode_ui_layout_key(SseDeserializer deserializer);

  @protected
  UILayoutValue sse_decode_ui_layout_value(SseDeserializer deserializer);

  @protected
  void sse_decode_unit(SseDeserializer deserializer);

  @protected
  int sse_decode_usize(SseDeserializer deserializer);

  @protected
  VersionMetadata sse_decode_version_metadata(SseDeserializer deserializer);

  @protected
  VersionType sse_decode_version_type(SseDeserializer deserializer);

  @protected
  XstsTokenErrorType sse_decode_xsts_token_error_type(
      SseDeserializer deserializer);

  @protected
  String cst_encode_AnyhowException(AnyhowException raw) {
    throw UnimplementedError();
  }

  @protected
  Object cst_encode_Chrono_Utc(DateTime raw) {
    return cst_encode_i_64(raw.millisecondsSinceEpoch);
  }

  @protected
  String cst_encode_String(String raw) {
    return raw;
  }

  @protected
  Uint8List cst_encode_Uuid(UuidValue raw) {
    return cst_encode_list_prim_u_8(raw.toBytes());
  }

  @protected
  List<dynamic> cst_encode_account_storage_value(AccountStorageValue raw) {
    if (raw is AccountStorageValue_Accounts) {
      return [0, cst_encode_list_minecraft_account(raw.field0)];
    }
    if (raw is AccountStorageValue_MainAccount) {
      return [1, cst_encode_opt_Uuid(raw.field0)];
    }

    throw Exception('unreachable');
  }

  @protected
  List<dynamic> cst_encode_account_token(AccountToken raw) {
    return [cst_encode_String(raw.token), cst_encode_i_64(raw.expiresAt)];
  }

  @protected
  List<dynamic> cst_encode_advanced_options(AdvancedOptions raw) {
    return [cst_encode_opt_box_autoadd_usize(raw.jvmMaxMemory)];
  }

  @protected
  List<dynamic> cst_encode_box_autoadd_advanced_options(AdvancedOptions raw) {
    return cst_encode_advanced_options(raw);
  }

  @protected
  List<dynamic> cst_encode_box_autoadd_login_flow_device_code(
      LoginFlowDeviceCode raw) {
    return cst_encode_login_flow_device_code(raw);
  }

  @protected
  List<dynamic> cst_encode_box_autoadd_login_flow_errors(LoginFlowErrors raw) {
    return cst_encode_login_flow_errors(raw);
  }

  @protected
  List<dynamic> cst_encode_box_autoadd_minecraft_account(MinecraftAccount raw) {
    return cst_encode_minecraft_account(raw);
  }

  @protected
  List<dynamic> cst_encode_box_autoadd_minecraft_skin(MinecraftSkin raw) {
    return cst_encode_minecraft_skin(raw);
  }

  @protected
  List<dynamic> cst_encode_box_autoadd_mod_loader(ModLoader raw) {
    return cst_encode_mod_loader(raw);
  }

  @protected
  List<dynamic> cst_encode_box_autoadd_ui_layout_value(UILayoutValue raw) {
    return cst_encode_ui_layout_value(raw);
  }

  @protected
  int cst_encode_box_autoadd_usize(int raw) {
    return cst_encode_usize(raw);
  }

  @protected
  List<dynamic> cst_encode_box_autoadd_version_metadata(VersionMetadata raw) {
    return cst_encode_version_metadata(raw);
  }

  @protected
  List<dynamic> cst_encode_collection_id(CollectionId raw) {
    return [cst_encode_String(raw.field0)];
  }

  @protected
  Object cst_encode_i_64(int raw) {
    return castNativeBigInt(raw);
  }

  @protected
  List<dynamic> cst_encode_list_minecraft_account(List<MinecraftAccount> raw) {
    return raw.map(cst_encode_minecraft_account).toList();
  }

  @protected
  List<dynamic> cst_encode_list_minecraft_cape(List<MinecraftCape> raw) {
    return raw.map(cst_encode_minecraft_cape).toList();
  }

  @protected
  List<dynamic> cst_encode_list_minecraft_skin(List<MinecraftSkin> raw) {
    return raw.map(cst_encode_minecraft_skin).toList();
  }

  @protected
  Uint8List cst_encode_list_prim_u_8(Uint8List raw) {
    return raw;
  }

  @protected
  List<dynamic> cst_encode_list_version_metadata(List<VersionMetadata> raw) {
    return raw.map(cst_encode_version_metadata).toList();
  }

  @protected
  List<dynamic> cst_encode_login_flow_device_code(LoginFlowDeviceCode raw) {
    return [
      cst_encode_String(raw.verificationUri),
      cst_encode_String(raw.userCode)
    ];
  }

  @protected
  List<dynamic> cst_encode_login_flow_errors(LoginFlowErrors raw) {
    if (raw is LoginFlowErrors_XstsError) {
      return [0, cst_encode_xsts_token_error_type(raw.field0)];
    }
    if (raw is LoginFlowErrors_GameNotOwned) {
      return [1];
    }
    if (raw is LoginFlowErrors_UnknownError) {
      return [2, cst_encode_String(raw.field0)];
    }

    throw Exception('unreachable');
  }

  @protected
  List<dynamic> cst_encode_login_flow_event(LoginFlowEvent raw) {
    if (raw is LoginFlowEvent_Stage) {
      return [0, cst_encode_login_flow_stage(raw.field0)];
    }
    if (raw is LoginFlowEvent_DeviceCode) {
      return [1, cst_encode_box_autoadd_login_flow_device_code(raw.field0)];
    }
    if (raw is LoginFlowEvent_Error) {
      return [2, cst_encode_box_autoadd_login_flow_errors(raw.field0)];
    }
    if (raw is LoginFlowEvent_Success) {
      return [3, cst_encode_box_autoadd_minecraft_account(raw.field0)];
    }

    throw Exception('unreachable');
  }

  @protected
  List<dynamic> cst_encode_minecraft_account(MinecraftAccount raw) {
    return [
      cst_encode_String(raw.username),
      cst_encode_Uuid(raw.uuid),
      cst_encode_account_token(raw.accessToken),
      cst_encode_account_token(raw.refreshToken),
      cst_encode_list_minecraft_skin(raw.skins),
      cst_encode_list_minecraft_cape(raw.capes)
    ];
  }

  @protected
  List<dynamic> cst_encode_minecraft_cape(MinecraftCape raw) {
    return [
      cst_encode_Uuid(raw.id),
      cst_encode_String(raw.state),
      cst_encode_String(raw.url),
      cst_encode_String(raw.alias)
    ];
  }

  @protected
  List<dynamic> cst_encode_minecraft_skin(MinecraftSkin raw) {
    return [
      cst_encode_Uuid(raw.id),
      cst_encode_String(raw.state),
      cst_encode_String(raw.url),
      cst_encode_minecraft_skin_variant(raw.variant)
    ];
  }

  @protected
  List<dynamic> cst_encode_mod_loader(ModLoader raw) {
    return [
      cst_encode_mod_loader_type(raw.modLoaderType),
      cst_encode_opt_String(raw.version)
    ];
  }

  @protected
  String? cst_encode_opt_String(String? raw) {
    return raw == null ? null : cst_encode_String(raw);
  }

  @protected
  Uint8List? cst_encode_opt_Uuid(UuidValue? raw) {
    return raw == null ? null : cst_encode_Uuid(raw);
  }

  @protected
  List<dynamic>? cst_encode_opt_box_autoadd_advanced_options(
      AdvancedOptions? raw) {
    return raw == null ? null : cst_encode_box_autoadd_advanced_options(raw);
  }

  @protected
  List<dynamic>? cst_encode_opt_box_autoadd_mod_loader(ModLoader? raw) {
    return raw == null ? null : cst_encode_box_autoadd_mod_loader(raw);
  }

  @protected
  int? cst_encode_opt_box_autoadd_usize(int? raw) {
    return raw == null ? null : cst_encode_box_autoadd_usize(raw);
  }

  @protected
  List<dynamic> cst_encode_ui_layout_value(UILayoutValue raw) {
    if (raw is UILayoutValue_CompletedSetup) {
      return [0, cst_encode_bool(raw.field0)];
    }

    throw Exception('unreachable');
  }

  @protected
  List<dynamic> cst_encode_version_metadata(VersionMetadata raw) {
    return [
      cst_encode_String(raw.id),
      cst_encode_version_type(raw.versionType),
      cst_encode_String(raw.url),
      cst_encode_Chrono_Utc(raw.uploadedTime),
      cst_encode_Chrono_Utc(raw.releaseTime),
      cst_encode_String(raw.sha1),
      cst_encode_u_32(raw.complianceLevel)
    ];
  }

  @protected
  PlatformPointer cst_encode_Auto_Owned_RustOpaque_stdsyncRwLockPathBuf(
      PathBuf raw);

  @protected
  PlatformPointer
      cst_encode_Auto_Owned_RustOpaque_stdsyncRwLockVeccrateapibackend_exclusivestoragestorage_loaderStorageLoader(
          StorageLoader raw);

  @protected
  PlatformPointer
      cst_encode_Auto_Owned_RustOpaque_stdsyncRwLockcrateapibackend_exclusivestoragestorage_loaderStorageLoaderPathBuf(
          StorageLoaderPathBuf raw);

  @protected
  PlatformPointer
      cst_encode_Auto_Ref_RustOpaque_stdsyncRwLockcrateapishared_resourcescollectionCollection(
          Collection raw);

  @protected
  PlatformPointer cst_encode_RustOpaque_stdsyncRwLockPathBuf(PathBuf raw);

  @protected
  PlatformPointer
      cst_encode_RustOpaque_stdsyncRwLockVeccrateapibackend_exclusivestoragestorage_loaderStorageLoader(
          StorageLoader raw);

  @protected
  PlatformPointer
      cst_encode_RustOpaque_stdsyncRwLockcrateapibackend_exclusivestoragestorage_loaderStorageLoaderPathBuf(
          StorageLoaderPathBuf raw);

  @protected
  PlatformPointer
      cst_encode_RustOpaque_stdsyncRwLockcrateapishared_resourcescollectionCollection(
          Collection raw);

  @protected
  int cst_encode_account_storage_key(AccountStorageKey raw);

  @protected
  bool cst_encode_bool(bool raw);

  @protected
  int cst_encode_i_32(int raw);

  @protected
  int cst_encode_login_flow_stage(LoginFlowStage raw);

  @protected
  int cst_encode_minecraft_skin_variant(MinecraftSkinVariant raw);

  @protected
  int cst_encode_mod_loader_type(ModLoaderType raw);

  @protected
  int cst_encode_u_32(int raw);

  @protected
  int cst_encode_u_8(int raw);

  @protected
  int cst_encode_ui_layout_key(UILayoutKey raw);

  @protected
  void cst_encode_unit(void raw);

  @protected
  int cst_encode_usize(int raw);

  @protected
  int cst_encode_version_type(VersionType raw);

  @protected
  int cst_encode_xsts_token_error_type(XstsTokenErrorType raw);

  @protected
  void sse_encode_AnyhowException(
      AnyhowException self, SseSerializer serializer);

  @protected
  void sse_encode_Auto_Owned_RustOpaque_stdsyncRwLockPathBuf(
      PathBuf self, SseSerializer serializer);

  @protected
  void
      sse_encode_Auto_Owned_RustOpaque_stdsyncRwLockVeccrateapibackend_exclusivestoragestorage_loaderStorageLoader(
          StorageLoader self, SseSerializer serializer);

  @protected
  void
      sse_encode_Auto_Owned_RustOpaque_stdsyncRwLockcrateapibackend_exclusivestoragestorage_loaderStorageLoaderPathBuf(
          StorageLoaderPathBuf self, SseSerializer serializer);

  @protected
  void
      sse_encode_Auto_Ref_RustOpaque_stdsyncRwLockcrateapishared_resourcescollectionCollection(
          Collection self, SseSerializer serializer);

  @protected
  void sse_encode_Chrono_Utc(DateTime self, SseSerializer serializer);

  @protected
  void sse_encode_RustOpaque_stdsyncRwLockPathBuf(
      PathBuf self, SseSerializer serializer);

  @protected
  void
      sse_encode_RustOpaque_stdsyncRwLockVeccrateapibackend_exclusivestoragestorage_loaderStorageLoader(
          StorageLoader self, SseSerializer serializer);

  @protected
  void
      sse_encode_RustOpaque_stdsyncRwLockcrateapibackend_exclusivestoragestorage_loaderStorageLoaderPathBuf(
          StorageLoaderPathBuf self, SseSerializer serializer);

  @protected
  void
      sse_encode_RustOpaque_stdsyncRwLockcrateapishared_resourcescollectionCollection(
          Collection self, SseSerializer serializer);

  @protected
  void sse_encode_String(String self, SseSerializer serializer);

  @protected
  void sse_encode_Uuid(UuidValue self, SseSerializer serializer);

  @protected
  void sse_encode_account_storage_key(
      AccountStorageKey self, SseSerializer serializer);

  @protected
  void sse_encode_account_storage_value(
      AccountStorageValue self, SseSerializer serializer);

  @protected
  void sse_encode_account_token(AccountToken self, SseSerializer serializer);

  @protected
  void sse_encode_advanced_options(
      AdvancedOptions self, SseSerializer serializer);

  @protected
  void sse_encode_bool(bool self, SseSerializer serializer);

  @protected
  void sse_encode_box_autoadd_advanced_options(
      AdvancedOptions self, SseSerializer serializer);

  @protected
  void sse_encode_box_autoadd_login_flow_device_code(
      LoginFlowDeviceCode self, SseSerializer serializer);

  @protected
  void sse_encode_box_autoadd_login_flow_errors(
      LoginFlowErrors self, SseSerializer serializer);

  @protected
  void sse_encode_box_autoadd_minecraft_account(
      MinecraftAccount self, SseSerializer serializer);

  @protected
  void sse_encode_box_autoadd_minecraft_skin(
      MinecraftSkin self, SseSerializer serializer);

  @protected
  void sse_encode_box_autoadd_mod_loader(
      ModLoader self, SseSerializer serializer);

  @protected
  void sse_encode_box_autoadd_ui_layout_value(
      UILayoutValue self, SseSerializer serializer);

  @protected
  void sse_encode_box_autoadd_usize(int self, SseSerializer serializer);

  @protected
  void sse_encode_box_autoadd_version_metadata(
      VersionMetadata self, SseSerializer serializer);

  @protected
  void sse_encode_collection_id(CollectionId self, SseSerializer serializer);

  @protected
  void sse_encode_i_32(int self, SseSerializer serializer);

  @protected
  void sse_encode_i_64(int self, SseSerializer serializer);

  @protected
  void sse_encode_list_minecraft_account(
      List<MinecraftAccount> self, SseSerializer serializer);

  @protected
  void sse_encode_list_minecraft_cape(
      List<MinecraftCape> self, SseSerializer serializer);

  @protected
  void sse_encode_list_minecraft_skin(
      List<MinecraftSkin> self, SseSerializer serializer);

  @protected
  void sse_encode_list_prim_u_8(Uint8List self, SseSerializer serializer);

  @protected
  void sse_encode_list_version_metadata(
      List<VersionMetadata> self, SseSerializer serializer);

  @protected
  void sse_encode_login_flow_device_code(
      LoginFlowDeviceCode self, SseSerializer serializer);

  @protected
  void sse_encode_login_flow_errors(
      LoginFlowErrors self, SseSerializer serializer);

  @protected
  void sse_encode_login_flow_event(
      LoginFlowEvent self, SseSerializer serializer);

  @protected
  void sse_encode_login_flow_stage(
      LoginFlowStage self, SseSerializer serializer);

  @protected
  void sse_encode_minecraft_account(
      MinecraftAccount self, SseSerializer serializer);

  @protected
  void sse_encode_minecraft_cape(MinecraftCape self, SseSerializer serializer);

  @protected
  void sse_encode_minecraft_skin(MinecraftSkin self, SseSerializer serializer);

  @protected
  void sse_encode_minecraft_skin_variant(
      MinecraftSkinVariant self, SseSerializer serializer);

  @protected
  void sse_encode_mod_loader(ModLoader self, SseSerializer serializer);

  @protected
  void sse_encode_mod_loader_type(ModLoaderType self, SseSerializer serializer);

  @protected
  void sse_encode_opt_String(String? self, SseSerializer serializer);

  @protected
  void sse_encode_opt_Uuid(UuidValue? self, SseSerializer serializer);

  @protected
  void sse_encode_opt_box_autoadd_advanced_options(
      AdvancedOptions? self, SseSerializer serializer);

  @protected
  void sse_encode_opt_box_autoadd_mod_loader(
      ModLoader? self, SseSerializer serializer);

  @protected
  void sse_encode_opt_box_autoadd_usize(int? self, SseSerializer serializer);

  @protected
  void sse_encode_u_32(int self, SseSerializer serializer);

  @protected
  void sse_encode_u_8(int self, SseSerializer serializer);

  @protected
  void sse_encode_ui_layout_key(UILayoutKey self, SseSerializer serializer);

  @protected
  void sse_encode_ui_layout_value(UILayoutValue self, SseSerializer serializer);

  @protected
  void sse_encode_unit(void self, SseSerializer serializer);

  @protected
  void sse_encode_usize(int self, SseSerializer serializer);

  @protected
  void sse_encode_version_metadata(
      VersionMetadata self, SseSerializer serializer);

  @protected
  void sse_encode_version_type(VersionType self, SseSerializer serializer);

  @protected
  void sse_encode_xsts_token_error_type(
      XstsTokenErrorType self, SseSerializer serializer);
}

// Section: wire_class

class RustLibWire extends BaseWire {
  RustLibWire.fromExternalLibrary(ExternalLibrary lib);

  void dart_fn_deliver_output(int call_id, PlatformGeneralizedUint8ListPtr ptr_,
          int rust_vec_len_, int data_len_) =>
      wasmModule.dart_fn_deliver_output(
          call_id, ptr_, rust_vec_len_, data_len_);

  void wire_MinecraftSkin_get_head_file_path(
          NativePortType port_, List<dynamic> that) =>
      wasmModule.wire_MinecraftSkin_get_head_file_path(port_, that);

  void wire_Collection_create_loader(
          NativePortType port_, String display_name) =>
      wasmModule.wire_Collection_create_loader(port_, display_name);

  void wire_Collection_game_directory(NativePortType port_, Object that) =>
      wasmModule.wire_Collection_game_directory(port_, that);

  void wire_Collection_get_base_path(NativePortType port_) =>
      wasmModule.wire_Collection_get_base_path(port_);

  void wire_Collection_get_collection_id(NativePortType port_, Object that) =>
      wasmModule.wire_Collection_get_collection_id(port_, that);

  void wire_Collection_scan(NativePortType port_) =>
      wasmModule.wire_Collection_scan(port_);

  void wire_create_collection(
          NativePortType port_,
          String display_name,
          List<dynamic> version_metadata,
          List<dynamic>? mod_loader,
          List<dynamic>? advanced_options) =>
      wasmModule.wire_create_collection(
          port_, display_name, version_metadata, mod_loader, advanced_options);

  dynamic /* flutter_rust_bridge::for_generated::WireSyncRust2DartDco */
      wire_get_account_storage(int key) =>
          wasmModule.wire_get_account_storage(key);

  dynamic /* flutter_rust_bridge::for_generated::WireSyncRust2DartDco */
      wire_get_skin_file_path(List<dynamic> skin) =>
          wasmModule.wire_get_skin_file_path(skin);

  dynamic /* flutter_rust_bridge::for_generated::WireSyncRust2DartDco */
      wire_get_ui_layout_storage(int key) =>
          wasmModule.wire_get_ui_layout_storage(key);

  void wire_get_vanilla_versions(NativePortType port_) =>
      wasmModule.wire_get_vanilla_versions(port_);

  void wire_minecraft_login_flow(NativePortType port_) =>
      wasmModule.wire_minecraft_login_flow(port_);

  void wire_remove_minecraft_account(NativePortType port_, Uint8List uuid) =>
      wasmModule.wire_remove_minecraft_account(port_, uuid);

  void wire_set_ui_layout_storage(NativePortType port_, List<dynamic> value) =>
      wasmModule.wire_set_ui_layout_storage(port_, value);

  void wire_setup_logger(NativePortType port_) =>
      wasmModule.wire_setup_logger(port_);

  void rust_arc_increment_strong_count_RustOpaque_stdsyncRwLockPathBuf(
          dynamic ptr) =>
      wasmModule
          .rust_arc_increment_strong_count_RustOpaque_stdsyncRwLockPathBuf(ptr);

  void rust_arc_decrement_strong_count_RustOpaque_stdsyncRwLockPathBuf(
          dynamic ptr) =>
      wasmModule
          .rust_arc_decrement_strong_count_RustOpaque_stdsyncRwLockPathBuf(ptr);

  void rust_arc_increment_strong_count_RustOpaque_stdsyncRwLockVeccrateapibackend_exclusivestoragestorage_loaderStorageLoader(
          dynamic ptr) =>
      wasmModule
          .rust_arc_increment_strong_count_RustOpaque_stdsyncRwLockVeccrateapibackend_exclusivestoragestorage_loaderStorageLoader(
              ptr);

  void rust_arc_decrement_strong_count_RustOpaque_stdsyncRwLockVeccrateapibackend_exclusivestoragestorage_loaderStorageLoader(
          dynamic ptr) =>
      wasmModule
          .rust_arc_decrement_strong_count_RustOpaque_stdsyncRwLockVeccrateapibackend_exclusivestoragestorage_loaderStorageLoader(
              ptr);

  void rust_arc_increment_strong_count_RustOpaque_stdsyncRwLockcrateapibackend_exclusivestoragestorage_loaderStorageLoaderPathBuf(
          dynamic ptr) =>
      wasmModule
          .rust_arc_increment_strong_count_RustOpaque_stdsyncRwLockcrateapibackend_exclusivestoragestorage_loaderStorageLoaderPathBuf(
              ptr);

  void rust_arc_decrement_strong_count_RustOpaque_stdsyncRwLockcrateapibackend_exclusivestoragestorage_loaderStorageLoaderPathBuf(
          dynamic ptr) =>
      wasmModule
          .rust_arc_decrement_strong_count_RustOpaque_stdsyncRwLockcrateapibackend_exclusivestoragestorage_loaderStorageLoaderPathBuf(
              ptr);

  void rust_arc_increment_strong_count_RustOpaque_stdsyncRwLockcrateapishared_resourcescollectionCollection(
          dynamic ptr) =>
      wasmModule
          .rust_arc_increment_strong_count_RustOpaque_stdsyncRwLockcrateapishared_resourcescollectionCollection(
              ptr);

  void rust_arc_decrement_strong_count_RustOpaque_stdsyncRwLockcrateapishared_resourcescollectionCollection(
          dynamic ptr) =>
      wasmModule
          .rust_arc_decrement_strong_count_RustOpaque_stdsyncRwLockcrateapishared_resourcescollectionCollection(
              ptr);
}

@JS('wasm_bindgen')
external RustLibWasmModule get wasmModule;

@JS()
@anonymous
class RustLibWasmModule implements WasmModule {
  @override
  external Object /* Promise */ call([String? moduleName]);

  @override
  external RustLibWasmModule bind(dynamic thisArg, String moduleName);

  external void dart_fn_deliver_output(int call_id,
      PlatformGeneralizedUint8ListPtr ptr_, int rust_vec_len_, int data_len_);

  external void wire_MinecraftSkin_get_head_file_path(
      NativePortType port_, List<dynamic> that);

  external void wire_Collection_create_loader(
      NativePortType port_, String display_name);

  external void wire_Collection_game_directory(
      NativePortType port_, Object that);

  external void wire_Collection_get_base_path(NativePortType port_);

  external void wire_Collection_get_collection_id(
      NativePortType port_, Object that);

  external void wire_Collection_scan(NativePortType port_);

  external void wire_create_collection(
      NativePortType port_,
      String display_name,
      List<dynamic> version_metadata,
      List<dynamic>? mod_loader,
      List<dynamic>? advanced_options);

  external dynamic /* flutter_rust_bridge::for_generated::WireSyncRust2DartDco */
      wire_get_account_storage(int key);

  external dynamic /* flutter_rust_bridge::for_generated::WireSyncRust2DartDco */
      wire_get_skin_file_path(List<dynamic> skin);

  external dynamic /* flutter_rust_bridge::for_generated::WireSyncRust2DartDco */
      wire_get_ui_layout_storage(int key);

  external void wire_get_vanilla_versions(NativePortType port_);

  external void wire_minecraft_login_flow(NativePortType port_);

  external void wire_remove_minecraft_account(
      NativePortType port_, Uint8List uuid);

  external void wire_set_ui_layout_storage(
      NativePortType port_, List<dynamic> value);

  external void wire_setup_logger(NativePortType port_);

  external void rust_arc_increment_strong_count_RustOpaque_stdsyncRwLockPathBuf(
      dynamic ptr);

  external void rust_arc_decrement_strong_count_RustOpaque_stdsyncRwLockPathBuf(
      dynamic ptr);

  external void
      rust_arc_increment_strong_count_RustOpaque_stdsyncRwLockVeccrateapibackend_exclusivestoragestorage_loaderStorageLoader(
          dynamic ptr);

  external void
      rust_arc_decrement_strong_count_RustOpaque_stdsyncRwLockVeccrateapibackend_exclusivestoragestorage_loaderStorageLoader(
          dynamic ptr);

  external void
      rust_arc_increment_strong_count_RustOpaque_stdsyncRwLockcrateapibackend_exclusivestoragestorage_loaderStorageLoaderPathBuf(
          dynamic ptr);

  external void
      rust_arc_decrement_strong_count_RustOpaque_stdsyncRwLockcrateapibackend_exclusivestoragestorage_loaderStorageLoaderPathBuf(
          dynamic ptr);

  external void
      rust_arc_increment_strong_count_RustOpaque_stdsyncRwLockcrateapishared_resourcescollectionCollection(
          dynamic ptr);

  external void
      rust_arc_decrement_strong_count_RustOpaque_stdsyncRwLockcrateapishared_resourcescollectionCollection(
          dynamic ptr);
}
