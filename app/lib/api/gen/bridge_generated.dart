// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.82.4.
// ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, unnecessary_import, prefer_single_quotes, prefer_const_constructors, use_super_parameters, always_use_package_imports, annotate_overrides, invalid_use_of_protected_member, constant_identifier_names, invalid_use_of_internal_member, prefer_is_empty, unnecessary_const

import "bridge_definitions.dart";
import 'dart:convert';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:uuid/uuid.dart';

import 'dart:convert';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:uuid/uuid.dart';

import 'dart:ffi' as ffi;

class NativeImpl implements Native {
  final NativePlatform _platform;
  factory NativeImpl(ExternalLibrary dylib) =>
      NativeImpl.raw(NativePlatform(dylib));

  /// Only valid on web/WASM platforms.
  factory NativeImpl.wasm(FutureOr<WasmModule> module) =>
      NativeImpl(module as ExternalLibrary);
  NativeImpl.raw(this._platform);
  Future<void> setupLogger({dynamic hint}) {
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_setup_logger(port_),
      parseSuccessData: _wire2api_unit,
      parseErrorData: _wire2api_FrbAnyhowException,
      constMeta: kSetupLoggerConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kSetupLoggerConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "setup_logger",
        argNames: [],
      );

  Stream<Progress> launchVanilla({dynamic hint}) {
    return _platform.executeStream(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_launch_vanilla(port_),
      parseSuccessData: _wire2api_progress,
      parseErrorData: _wire2api_FrbAnyhowException,
      constMeta: kLaunchVanillaConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kLaunchVanillaConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "launch_vanilla",
        argNames: [],
      );

  Stream<Progress> launchForge({dynamic hint}) {
    return _platform.executeStream(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_launch_forge(port_),
      parseSuccessData: _wire2api_progress,
      parseErrorData: _wire2api_FrbAnyhowException,
      constMeta: kLaunchForgeConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kLaunchForgeConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "launch_forge",
        argNames: [],
      );

  Stream<Progress> launchQuilt({dynamic hint}) {
    return _platform.executeStream(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_launch_quilt(port_),
      parseSuccessData: _wire2api_progress,
      parseErrorData: _wire2api_FrbAnyhowException,
      constMeta: kLaunchQuiltConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kLaunchQuiltConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "launch_quilt",
        argNames: [],
      );

  Future<DownloadState> fetchState({dynamic hint}) {
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_fetch_state(port_),
      parseSuccessData: _wire2api_download_state,
      parseErrorData: null,
      constMeta: kFetchStateConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kFetchStateConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "fetch_state",
        argNames: [],
      );

  Future<void> writeState({required DownloadState s, dynamic hint}) {
    var arg0 = api2wire_download_state(s);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_write_state(port_, arg0),
      parseSuccessData: _wire2api_unit,
      parseErrorData: null,
      constMeta: kWriteStateConstMeta,
      argValues: [s],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kWriteStateConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "write_state",
        argNames: ["s"],
      );

  UILayoutValue getUiLayoutStorage({required UILayoutKey key, dynamic hint}) {
    var arg0 = api2wire_ui_layout_key(key);
    return _platform.executeSync(FlutterRustBridgeSyncTask(
      callFfi: () => _platform.inner.wire_get_ui_layout_storage(arg0),
      parseSuccessData: _wire2api_ui_layout_value,
      parseErrorData: null,
      constMeta: kGetUiLayoutStorageConstMeta,
      argValues: [key],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kGetUiLayoutStorageConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "get_ui_layout_storage",
        argNames: ["key"],
      );

  Future<void> setUiLayoutStorage(
      {required UILayoutValue value, dynamic hint}) {
    var arg0 = _platform.api2wire_box_autoadd_ui_layout_value(value);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) =>
          _platform.inner.wire_set_ui_layout_storage(port_, arg0),
      parseSuccessData: _wire2api_unit,
      parseErrorData: _wire2api_FrbAnyhowException,
      constMeta: kSetUiLayoutStorageConstMeta,
      argValues: [value],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kSetUiLayoutStorageConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "set_ui_layout_storage",
        argNames: ["value"],
      );

  AccountStorageValue getAccountStorage(
      {required AccountStorageKey key, dynamic hint}) {
    var arg0 = api2wire_account_storage_key(key);
    return _platform.executeSync(FlutterRustBridgeSyncTask(
      callFfi: () => _platform.inner.wire_get_account_storage(arg0),
      parseSuccessData: _wire2api_account_storage_value,
      parseErrorData: null,
      constMeta: kGetAccountStorageConstMeta,
      argValues: [key],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kGetAccountStorageConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "get_account_storage",
        argNames: ["key"],
      );

  String getSkinFilePath({required MinecraftSkin skin, dynamic hint}) {
    var arg0 = _platform.api2wire_box_autoadd_minecraft_skin(skin);
    return _platform.executeSync(FlutterRustBridgeSyncTask(
      callFfi: () => _platform.inner.wire_get_skin_file_path(arg0),
      parseSuccessData: _wire2api_String,
      parseErrorData: null,
      constMeta: kGetSkinFilePathConstMeta,
      argValues: [skin],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kGetSkinFilePathConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "get_skin_file_path",
        argNames: ["skin"],
      );

  Future<void> removeMinecraftAccount({required UuidValue uuid, dynamic hint}) {
    var arg0 = _platform.api2wire_Uuid(uuid);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) =>
          _platform.inner.wire_remove_minecraft_account(port_, arg0),
      parseSuccessData: _wire2api_unit,
      parseErrorData: _wire2api_FrbAnyhowException,
      constMeta: kRemoveMinecraftAccountConstMeta,
      argValues: [uuid],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kRemoveMinecraftAccountConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "remove_minecraft_account",
        argNames: ["uuid"],
      );

  Stream<LoginFlowEvent> minecraftLoginFlow({dynamic hint}) {
    return _platform.executeStream(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_minecraft_login_flow(port_),
      parseSuccessData: _wire2api_login_flow_event,
      parseErrorData: _wire2api_FrbAnyhowException,
      constMeta: kMinecraftLoginFlowConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kMinecraftLoginFlowConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "minecraft_login_flow",
        argNames: [],
      );

  void dispose() {
    _platform.dispose();
  }
// Section: wire2api

  FrbAnyhowException _wire2api_FrbAnyhowException(dynamic raw) {
    return FrbAnyhowException(raw as String);
  }

  String _wire2api_String(dynamic raw) {
    return raw as String;
  }

  UuidValue _wire2api_Uuid(dynamic raw) {
    return UuidValue.fromByteList(_wire2api_uint_8_list(raw));
  }

  AccountStorageValue _wire2api_account_storage_value(dynamic raw) {
    switch (raw[0]) {
      case 0:
        return AccountStorageValue_Accounts(
          _wire2api_list_minecraft_account(raw[1]),
        );
      case 1:
        return AccountStorageValue_MainAccount(
          _wire2api_opt_Uuid(raw[1]),
        );
      default:
        throw Exception("unreachable");
    }
  }

  AccountToken _wire2api_account_token(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 2)
      throw Exception('unexpected arr length: expect 2 but see ${arr.length}');
    return AccountToken(
      token: _wire2api_String(arr[0]),
      expiresAt: _wire2api_i64(arr[1]),
    );
  }

  bool _wire2api_bool(dynamic raw) {
    return raw as bool;
  }

  LoginFlowDeviceCode _wire2api_box_autoadd_login_flow_device_code(
      dynamic raw) {
    return _wire2api_login_flow_device_code(raw);
  }

  LoginFlowErrors _wire2api_box_autoadd_login_flow_errors(dynamic raw) {
    return _wire2api_login_flow_errors(raw);
  }

  MinecraftAccount _wire2api_box_autoadd_minecraft_account(dynamic raw) {
    return _wire2api_minecraft_account(raw);
  }

  DownloadState _wire2api_download_state(dynamic raw) {
    return DownloadState.values[raw as int];
  }

  double _wire2api_f64(dynamic raw) {
    return raw as double;
  }

  int _wire2api_i32(dynamic raw) {
    return raw as int;
  }

  int _wire2api_i64(dynamic raw) {
    return castInt(raw);
  }

  List<MinecraftAccount> _wire2api_list_minecraft_account(dynamic raw) {
    return (raw as List<dynamic>).map(_wire2api_minecraft_account).toList();
  }

  List<MinecraftCape> _wire2api_list_minecraft_cape(dynamic raw) {
    return (raw as List<dynamic>).map(_wire2api_minecraft_cape).toList();
  }

  List<MinecraftSkin> _wire2api_list_minecraft_skin(dynamic raw) {
    return (raw as List<dynamic>).map(_wire2api_minecraft_skin).toList();
  }

  LoginFlowDeviceCode _wire2api_login_flow_device_code(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 2)
      throw Exception('unexpected arr length: expect 2 but see ${arr.length}');
    return LoginFlowDeviceCode(
      verificationUri: _wire2api_String(arr[0]),
      userCode: _wire2api_String(arr[1]),
    );
  }

  LoginFlowErrors _wire2api_login_flow_errors(dynamic raw) {
    switch (raw[0]) {
      case 0:
        return LoginFlowErrors_XstsError(
          _wire2api_xsts_token_error_type(raw[1]),
        );
      case 1:
        return LoginFlowErrors_GameNotOwned();
      case 2:
        return LoginFlowErrors_UnknownError(
          _wire2api_String(raw[1]),
        );
      default:
        throw Exception("unreachable");
    }
  }

  LoginFlowEvent _wire2api_login_flow_event(dynamic raw) {
    switch (raw[0]) {
      case 0:
        return LoginFlowEvent_Stage(
          _wire2api_login_flow_stage(raw[1]),
        );
      case 1:
        return LoginFlowEvent_DeviceCode(
          _wire2api_box_autoadd_login_flow_device_code(raw[1]),
        );
      case 2:
        return LoginFlowEvent_Error(
          _wire2api_box_autoadd_login_flow_errors(raw[1]),
        );
      case 3:
        return LoginFlowEvent_Success(
          _wire2api_box_autoadd_minecraft_account(raw[1]),
        );
      default:
        throw Exception("unreachable");
    }
  }

  LoginFlowStage _wire2api_login_flow_stage(dynamic raw) {
    return LoginFlowStage.values[raw as int];
  }

  MinecraftAccount _wire2api_minecraft_account(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 6)
      throw Exception('unexpected arr length: expect 6 but see ${arr.length}');
    return MinecraftAccount(
      username: _wire2api_String(arr[0]),
      uuid: _wire2api_Uuid(arr[1]),
      accessToken: _wire2api_account_token(arr[2]),
      refreshToken: _wire2api_account_token(arr[3]),
      skins: _wire2api_list_minecraft_skin(arr[4]),
      capes: _wire2api_list_minecraft_cape(arr[5]),
    );
  }

  MinecraftCape _wire2api_minecraft_cape(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 4)
      throw Exception('unexpected arr length: expect 4 but see ${arr.length}');
    return MinecraftCape(
      id: _wire2api_Uuid(arr[0]),
      state: _wire2api_String(arr[1]),
      url: _wire2api_String(arr[2]),
      alias: _wire2api_String(arr[3]),
    );
  }

  MinecraftSkin _wire2api_minecraft_skin(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 4)
      throw Exception('unexpected arr length: expect 4 but see ${arr.length}');
    return MinecraftSkin(
      id: _wire2api_Uuid(arr[0]),
      state: _wire2api_String(arr[1]),
      url: _wire2api_String(arr[2]),
      variant: _wire2api_minecraft_skin_variant(arr[3]),
    );
  }

  MinecraftSkinVariant _wire2api_minecraft_skin_variant(dynamic raw) {
    return MinecraftSkinVariant.values[raw as int];
  }

  UuidValue? _wire2api_opt_Uuid(dynamic raw) {
    return raw == null ? null : _wire2api_Uuid(raw);
  }

  Progress _wire2api_progress(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 4)
      throw Exception('unexpected arr length: expect 4 but see ${arr.length}');
    return Progress(
      speed: _wire2api_f64(arr[0]),
      percentages: _wire2api_f64(arr[1]),
      currentSize: _wire2api_f64(arr[2]),
      totalSize: _wire2api_f64(arr[3]),
    );
  }

  int _wire2api_u8(dynamic raw) {
    return raw as int;
  }

  UILayoutValue _wire2api_ui_layout_value(dynamic raw) {
    switch (raw[0]) {
      case 0:
        return UILayoutValue_CompletedSetup(
          _wire2api_bool(raw[1]),
        );
      default:
        throw Exception("unreachable");
    }
  }

  Uint8List _wire2api_uint_8_list(dynamic raw) {
    return raw as Uint8List;
  }

  void _wire2api_unit(dynamic raw) {
    return;
  }

  XstsTokenErrorType _wire2api_xsts_token_error_type(dynamic raw) {
    return XstsTokenErrorType.values[raw as int];
  }
}

// Section: api2wire

@protected
int api2wire_account_storage_key(AccountStorageKey raw) {
  return api2wire_i32(raw.index);
}

@protected
bool api2wire_bool(bool raw) {
  return raw;
}

@protected
int api2wire_download_state(DownloadState raw) {
  return api2wire_i32(raw.index);
}

@protected
int api2wire_i32(int raw) {
  return raw;
}

@protected
int api2wire_minecraft_skin_variant(MinecraftSkinVariant raw) {
  return api2wire_i32(raw.index);
}

@protected
int api2wire_u8(int raw) {
  return raw;
}

@protected
int api2wire_ui_layout_key(UILayoutKey raw) {
  return api2wire_i32(raw.index);
}

// Section: finalizer

class NativePlatform extends FlutterRustBridgeBase<NativeWire> {
  NativePlatform(ffi.DynamicLibrary dylib) : super(NativeWire(dylib));

// Section: api2wire

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_String(String raw) {
    return api2wire_uint_8_list(utf8.encoder.convert(raw));
  }

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_Uuid(UuidValue raw) {
    return api2wire_uint_8_list(raw.toBytes());
  }

  @protected
  ffi.Pointer<wire_MinecraftSkin> api2wire_box_autoadd_minecraft_skin(
      MinecraftSkin raw) {
    final ptr = inner.new_box_autoadd_minecraft_skin_0();
    _api_fill_to_wire_minecraft_skin(raw, ptr.ref);
    return ptr;
  }

  @protected
  ffi.Pointer<wire_UILayoutValue> api2wire_box_autoadd_ui_layout_value(
      UILayoutValue raw) {
    final ptr = inner.new_box_autoadd_ui_layout_value_0();
    _api_fill_to_wire_ui_layout_value(raw, ptr.ref);
    return ptr;
  }

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_uint_8_list(Uint8List raw) {
    final ans = inner.new_uint_8_list_0(raw.length);
    ans.ref.ptr.asTypedList(raw.length).setAll(0, raw);
    return ans;
  }
// Section: finalizer

// Section: api_fill_to_wire

  void _api_fill_to_wire_box_autoadd_minecraft_skin(
      MinecraftSkin apiObj, ffi.Pointer<wire_MinecraftSkin> wireObj) {
    _api_fill_to_wire_minecraft_skin(apiObj, wireObj.ref);
  }

  void _api_fill_to_wire_box_autoadd_ui_layout_value(
      UILayoutValue apiObj, ffi.Pointer<wire_UILayoutValue> wireObj) {
    _api_fill_to_wire_ui_layout_value(apiObj, wireObj.ref);
  }

  void _api_fill_to_wire_minecraft_skin(
      MinecraftSkin apiObj, wire_MinecraftSkin wireObj) {
    wireObj.id = api2wire_Uuid(apiObj.id);
    wireObj.state = api2wire_String(apiObj.state);
    wireObj.url = api2wire_String(apiObj.url);
    wireObj.variant = api2wire_minecraft_skin_variant(apiObj.variant);
  }

  void _api_fill_to_wire_ui_layout_value(
      UILayoutValue apiObj, wire_UILayoutValue wireObj) {
    if (apiObj is UILayoutValue_CompletedSetup) {
      var pre_field0 = api2wire_bool(apiObj.field0);
      wireObj.tag = 0;
      wireObj.kind = inner.inflate_UILayoutValue_CompletedSetup();
      wireObj.kind.ref.CompletedSetup.ref.field0 = pre_field0;
      return;
    }
  }
}

// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_positional_boolean_parameters, annotate_overrides, constant_identifier_names

// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
// ignore_for_file: type=lint

/// generated by flutter_rust_bridge
class NativeWire implements FlutterRustBridgeWireBase {
  @internal
  late final dartApi = DartApiDl(init_frb_dart_api_dl);

  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  NativeWire(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  NativeWire.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  void store_dart_post_cobject(
    DartPostCObjectFnType ptr,
  ) {
    return _store_dart_post_cobject(
      ptr,
    );
  }

  late final _store_dart_post_cobjectPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(DartPostCObjectFnType)>>(
          'store_dart_post_cobject');
  late final _store_dart_post_cobject = _store_dart_post_cobjectPtr
      .asFunction<void Function(DartPostCObjectFnType)>();

  Object get_dart_object(
    int ptr,
  ) {
    return _get_dart_object(
      ptr,
    );
  }

  late final _get_dart_objectPtr =
      _lookup<ffi.NativeFunction<ffi.Handle Function(ffi.UintPtr)>>(
          'get_dart_object');
  late final _get_dart_object =
      _get_dart_objectPtr.asFunction<Object Function(int)>();

  void drop_dart_object(
    int ptr,
  ) {
    return _drop_dart_object(
      ptr,
    );
  }

  late final _drop_dart_objectPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.UintPtr)>>(
          'drop_dart_object');
  late final _drop_dart_object =
      _drop_dart_objectPtr.asFunction<void Function(int)>();

  int new_dart_opaque(
    Object handle,
  ) {
    return _new_dart_opaque(
      handle,
    );
  }

  late final _new_dart_opaquePtr =
      _lookup<ffi.NativeFunction<ffi.UintPtr Function(ffi.Handle)>>(
          'new_dart_opaque');
  late final _new_dart_opaque =
      _new_dart_opaquePtr.asFunction<int Function(Object)>();

  int init_frb_dart_api_dl(
    ffi.Pointer<ffi.Void> obj,
  ) {
    return _init_frb_dart_api_dl(
      obj,
    );
  }

  late final _init_frb_dart_api_dlPtr =
      _lookup<ffi.NativeFunction<ffi.IntPtr Function(ffi.Pointer<ffi.Void>)>>(
          'init_frb_dart_api_dl');
  late final _init_frb_dart_api_dl = _init_frb_dart_api_dlPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  void wire_setup_logger(
    int port_,
  ) {
    return _wire_setup_logger(
      port_,
    );
  }

  late final _wire_setup_loggerPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_setup_logger');
  late final _wire_setup_logger =
      _wire_setup_loggerPtr.asFunction<void Function(int)>();

  void wire_launch_vanilla(
    int port_,
  ) {
    return _wire_launch_vanilla(
      port_,
    );
  }

  late final _wire_launch_vanillaPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_launch_vanilla');
  late final _wire_launch_vanilla =
      _wire_launch_vanillaPtr.asFunction<void Function(int)>();

  void wire_launch_forge(
    int port_,
  ) {
    return _wire_launch_forge(
      port_,
    );
  }

  late final _wire_launch_forgePtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_launch_forge');
  late final _wire_launch_forge =
      _wire_launch_forgePtr.asFunction<void Function(int)>();

  void wire_launch_quilt(
    int port_,
  ) {
    return _wire_launch_quilt(
      port_,
    );
  }

  late final _wire_launch_quiltPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_launch_quilt');
  late final _wire_launch_quilt =
      _wire_launch_quiltPtr.asFunction<void Function(int)>();

  void wire_fetch_state(
    int port_,
  ) {
    return _wire_fetch_state(
      port_,
    );
  }

  late final _wire_fetch_statePtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_fetch_state');
  late final _wire_fetch_state =
      _wire_fetch_statePtr.asFunction<void Function(int)>();

  void wire_write_state(
    int port_,
    int s,
  ) {
    return _wire_write_state(
      port_,
      s,
    );
  }

  late final _wire_write_statePtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64, ffi.Int32)>>(
          'wire_write_state');
  late final _wire_write_state =
      _wire_write_statePtr.asFunction<void Function(int, int)>();

  WireSyncReturn wire_get_ui_layout_storage(
    int key,
  ) {
    return _wire_get_ui_layout_storage(
      key,
    );
  }

  late final _wire_get_ui_layout_storagePtr =
      _lookup<ffi.NativeFunction<WireSyncReturn Function(ffi.Int32)>>(
          'wire_get_ui_layout_storage');
  late final _wire_get_ui_layout_storage =
      _wire_get_ui_layout_storagePtr.asFunction<WireSyncReturn Function(int)>();

  void wire_set_ui_layout_storage(
    int port_,
    ffi.Pointer<wire_UILayoutValue> value,
  ) {
    return _wire_set_ui_layout_storage(
      port_,
      value,
    );
  }

  late final _wire_set_ui_layout_storagePtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64,
              ffi.Pointer<wire_UILayoutValue>)>>('wire_set_ui_layout_storage');
  late final _wire_set_ui_layout_storage = _wire_set_ui_layout_storagePtr
      .asFunction<void Function(int, ffi.Pointer<wire_UILayoutValue>)>();

  WireSyncReturn wire_get_account_storage(
    int key,
  ) {
    return _wire_get_account_storage(
      key,
    );
  }

  late final _wire_get_account_storagePtr =
      _lookup<ffi.NativeFunction<WireSyncReturn Function(ffi.Int32)>>(
          'wire_get_account_storage');
  late final _wire_get_account_storage =
      _wire_get_account_storagePtr.asFunction<WireSyncReturn Function(int)>();

  WireSyncReturn wire_get_skin_file_path(
    ffi.Pointer<wire_MinecraftSkin> skin,
  ) {
    return _wire_get_skin_file_path(
      skin,
    );
  }

  late final _wire_get_skin_file_pathPtr = _lookup<
      ffi.NativeFunction<
          WireSyncReturn Function(
              ffi.Pointer<wire_MinecraftSkin>)>>('wire_get_skin_file_path');
  late final _wire_get_skin_file_path = _wire_get_skin_file_pathPtr
      .asFunction<WireSyncReturn Function(ffi.Pointer<wire_MinecraftSkin>)>();

  void wire_remove_minecraft_account(
    int port_,
    ffi.Pointer<wire_uint_8_list> uuid,
  ) {
    return _wire_remove_minecraft_account(
      port_,
      uuid,
    );
  }

  late final _wire_remove_minecraft_accountPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64,
              ffi.Pointer<wire_uint_8_list>)>>('wire_remove_minecraft_account');
  late final _wire_remove_minecraft_account = _wire_remove_minecraft_accountPtr
      .asFunction<void Function(int, ffi.Pointer<wire_uint_8_list>)>();

  void wire_minecraft_login_flow(
    int port_,
  ) {
    return _wire_minecraft_login_flow(
      port_,
    );
  }

  late final _wire_minecraft_login_flowPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_minecraft_login_flow');
  late final _wire_minecraft_login_flow =
      _wire_minecraft_login_flowPtr.asFunction<void Function(int)>();

  ffi.Pointer<wire_MinecraftSkin> new_box_autoadd_minecraft_skin_0() {
    return _new_box_autoadd_minecraft_skin_0();
  }

  late final _new_box_autoadd_minecraft_skin_0Ptr =
      _lookup<ffi.NativeFunction<ffi.Pointer<wire_MinecraftSkin> Function()>>(
          'new_box_autoadd_minecraft_skin_0');
  late final _new_box_autoadd_minecraft_skin_0 =
      _new_box_autoadd_minecraft_skin_0Ptr
          .asFunction<ffi.Pointer<wire_MinecraftSkin> Function()>();

  ffi.Pointer<wire_UILayoutValue> new_box_autoadd_ui_layout_value_0() {
    return _new_box_autoadd_ui_layout_value_0();
  }

  late final _new_box_autoadd_ui_layout_value_0Ptr =
      _lookup<ffi.NativeFunction<ffi.Pointer<wire_UILayoutValue> Function()>>(
          'new_box_autoadd_ui_layout_value_0');
  late final _new_box_autoadd_ui_layout_value_0 =
      _new_box_autoadd_ui_layout_value_0Ptr
          .asFunction<ffi.Pointer<wire_UILayoutValue> Function()>();

  ffi.Pointer<wire_uint_8_list> new_uint_8_list_0(
    int len,
  ) {
    return _new_uint_8_list_0(
      len,
    );
  }

  late final _new_uint_8_list_0Ptr = _lookup<
          ffi
          .NativeFunction<ffi.Pointer<wire_uint_8_list> Function(ffi.Int32)>>(
      'new_uint_8_list_0');
  late final _new_uint_8_list_0 = _new_uint_8_list_0Ptr
      .asFunction<ffi.Pointer<wire_uint_8_list> Function(int)>();

  ffi.Pointer<UILayoutValueKind> inflate_UILayoutValue_CompletedSetup() {
    return _inflate_UILayoutValue_CompletedSetup();
  }

  late final _inflate_UILayoutValue_CompletedSetupPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<UILayoutValueKind> Function()>>(
          'inflate_UILayoutValue_CompletedSetup');
  late final _inflate_UILayoutValue_CompletedSetup =
      _inflate_UILayoutValue_CompletedSetupPtr
          .asFunction<ffi.Pointer<UILayoutValueKind> Function()>();

  void free_WireSyncReturn(
    WireSyncReturn ptr,
  ) {
    return _free_WireSyncReturn(
      ptr,
    );
  }

  late final _free_WireSyncReturnPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(WireSyncReturn)>>(
          'free_WireSyncReturn');
  late final _free_WireSyncReturn =
      _free_WireSyncReturnPtr.asFunction<void Function(WireSyncReturn)>();
}

final class _Dart_Handle extends ffi.Opaque {}

final class wire_UILayoutValue_CompletedSetup extends ffi.Struct {
  @ffi.Bool()
  external bool field0;
}

final class UILayoutValueKind extends ffi.Union {
  external ffi.Pointer<wire_UILayoutValue_CompletedSetup> CompletedSetup;
}

final class wire_UILayoutValue extends ffi.Struct {
  @ffi.Int32()
  external int tag;

  external ffi.Pointer<UILayoutValueKind> kind;
}

final class wire_uint_8_list extends ffi.Struct {
  external ffi.Pointer<ffi.Uint8> ptr;

  @ffi.Int32()
  external int len;
}

final class wire_MinecraftSkin extends ffi.Struct {
  external ffi.Pointer<wire_uint_8_list> id;

  external ffi.Pointer<wire_uint_8_list> state;

  external ffi.Pointer<wire_uint_8_list> url;

  @ffi.Int32()
  external int variant;
}

typedef DartPostCObjectFnType = ffi.Pointer<
    ffi.NativeFunction<
        ffi.Bool Function(DartPort port_id, ffi.Pointer<ffi.Void> message)>>;
typedef DartPort = ffi.Int64;
