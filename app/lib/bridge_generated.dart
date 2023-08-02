// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.79.0.
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
  Stream<ReturnType> downloadVanilla({dynamic hint}) {
    return _platform.executeStream(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_download_vanilla(port_),
      parseSuccessData: _wire2api_return_type,
      constMeta: kDownloadVanillaConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kDownloadVanillaConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "download_vanilla",
        argNames: [],
      );

  Future<void> launchGame(
      {required PrepareGameArgs preLaunchArguments, dynamic hint}) {
    var arg0 =
        _platform.api2wire_box_autoadd_prepare_game_args(preLaunchArguments);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_launch_game(port_, arg0),
      parseSuccessData: _wire2api_unit,
      constMeta: kLaunchGameConstMeta,
      argValues: [preLaunchArguments],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kLaunchGameConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "launch_game",
        argNames: ["preLaunchArguments"],
      );

  Stream<ReturnType> downloadForge(
      {required PrepareGameArgs forgePrepare, dynamic hint}) {
    var arg0 = _platform.api2wire_box_autoadd_prepare_game_args(forgePrepare);
    return _platform.executeStream(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_download_forge(port_, arg0),
      parseSuccessData: _wire2api_return_type,
      constMeta: kDownloadForgeConstMeta,
      argValues: [forgePrepare],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kDownloadForgeConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "download_forge",
        argNames: ["forgePrepare"],
      );

  Stream<ReturnType> downloadQuilt(
      {required PrepareGameArgs quiltPrepare, dynamic hint}) {
    var arg0 = _platform.api2wire_box_autoadd_prepare_game_args(quiltPrepare);
    return _platform.executeStream(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_download_quilt(port_, arg0),
      parseSuccessData: _wire2api_return_type,
      constMeta: kDownloadQuiltConstMeta,
      argValues: [quiltPrepare],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kDownloadQuiltConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "download_quilt",
        argNames: ["quiltPrepare"],
      );

  Future<State> fetchState({dynamic hint}) {
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_fetch_state(port_),
      parseSuccessData: _wire2api_state,
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

  Future<void> writeState({required State s, dynamic hint}) {
    var arg0 = api2wire_state(s);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_write_state(port_, arg0),
      parseSuccessData: _wire2api_unit,
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

  Future<UILayout> fetchUiLayout({dynamic hint}) {
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_fetch_ui_layout(port_),
      parseSuccessData: _wire2api_ui_layout,
      constMeta: kFetchUiLayoutConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kFetchUiLayoutConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "fetch_ui_layout",
        argNames: [],
      );

  DropFnType get dropOpaquePathBuf => _platform.inner.drop_opaque_PathBuf;
  ShareFnType get shareOpaquePathBuf => _platform.inner.share_opaque_PathBuf;
  OpaqueTypeFinalizer get PathBufFinalizer => _platform.PathBufFinalizer;

  void dispose() {
    _platform.dispose();
  }
// Section: wire2api

  PathBuf _wire2api_PathBuf(dynamic raw) {
    return PathBuf.fromRaw(raw[0], raw[1], this);
  }

  String _wire2api_String(dynamic raw) {
    return raw as String;
  }

  List<String> _wire2api_StringList(dynamic raw) {
    return (raw as List<dynamic>).cast<String>();
  }

  bool _wire2api_bool(dynamic raw) {
    return raw as bool;
  }

  PrepareGameArgs _wire2api_box_autoadd_prepare_game_args(dynamic raw) {
    return _wire2api_prepare_game_args(raw);
  }

  Progress _wire2api_box_autoadd_progress(dynamic raw) {
    return _wire2api_progress(raw);
  }

  double _wire2api_f64(dynamic raw) {
    return raw as double;
  }

  GameOptions _wire2api_game_options(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 8)
      throw Exception('unexpected arr length: expect 8 but see ${arr.length}');
    return GameOptions(
      authPlayerName: _wire2api_String(arr[0]),
      gameVersionName: _wire2api_String(arr[1]),
      gameDirectory: _wire2api_PathBuf(arr[2]),
      assetsRoot: _wire2api_PathBuf(arr[3]),
      assetsIndexName: _wire2api_String(arr[4]),
      authUuid: _wire2api_String(arr[5]),
      userType: _wire2api_String(arr[6]),
      versionType: _wire2api_String(arr[7]),
    );
  }

  int _wire2api_i32(dynamic raw) {
    return raw as int;
  }

  JvmOptions _wire2api_jvm_options(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 8)
      throw Exception('unexpected arr length: expect 8 but see ${arr.length}');
    return JvmOptions(
      launcherName: _wire2api_String(arr[0]),
      launcherVersion: _wire2api_String(arr[1]),
      classpath: _wire2api_String(arr[2]),
      classpathSeparator: _wire2api_String(arr[3]),
      primaryJar: _wire2api_String(arr[4]),
      libraryDirectory: _wire2api_PathBuf(arr[5]),
      gameDirectory: _wire2api_PathBuf(arr[6]),
      nativeDirectory: _wire2api_PathBuf(arr[7]),
    );
  }

  LaunchArgs _wire2api_launch_args(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 3)
      throw Exception('unexpected arr length: expect 3 but see ${arr.length}');
    return LaunchArgs(
      jvmArgs: _wire2api_StringList(arr[0]),
      mainClass: _wire2api_String(arr[1]),
      gameArgs: _wire2api_StringList(arr[2]),
    );
  }

  PrepareGameArgs? _wire2api_opt_box_autoadd_prepare_game_args(dynamic raw) {
    return raw == null ? null : _wire2api_box_autoadd_prepare_game_args(raw);
  }

  Progress? _wire2api_opt_box_autoadd_progress(dynamic raw) {
    return raw == null ? null : _wire2api_box_autoadd_progress(raw);
  }

  PrepareGameArgs _wire2api_prepare_game_args(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 3)
      throw Exception('unexpected arr length: expect 3 but see ${arr.length}');
    return PrepareGameArgs(
      launchArgs: _wire2api_launch_args(arr[0]),
      jvmArgs: _wire2api_jvm_options(arr[1]),
      gameArgs: _wire2api_game_options(arr[2]),
    );
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

  ReturnType _wire2api_return_type(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 2)
      throw Exception('unexpected arr length: expect 2 but see ${arr.length}');
    return ReturnType(
      progress: _wire2api_opt_box_autoadd_progress(arr[0]),
      prepareNameArgs: _wire2api_opt_box_autoadd_prepare_game_args(arr[1]),
    );
  }

  State _wire2api_state(dynamic raw) {
    return State.values[raw as int];
  }

  int _wire2api_u8(dynamic raw) {
    return raw as int;
  }

  UILayout _wire2api_ui_layout(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 1)
      throw Exception('unexpected arr length: expect 1 but see ${arr.length}');
    return UILayout(
      completedSetup: _wire2api_bool(arr[0]),
    );
  }

  Uint8List _wire2api_uint_8_list(dynamic raw) {
    return raw as Uint8List;
  }

  void _wire2api_unit(dynamic raw) {
    return;
  }
}

// Section: api2wire

@protected
int api2wire_i32(int raw) {
  return raw;
}

@protected
int api2wire_state(State raw) {
  return api2wire_i32(raw.index);
}

@protected
int api2wire_u8(int raw) {
  return raw;
}

// Section: finalizer

class NativePlatform extends FlutterRustBridgeBase<NativeWire> {
  NativePlatform(ffi.DynamicLibrary dylib) : super(NativeWire(dylib));

// Section: api2wire

  @protected
  wire_PathBuf api2wire_PathBuf(PathBuf raw) {
    final ptr = inner.new_PathBuf();
    _api_fill_to_wire_PathBuf(raw, ptr);
    return ptr;
  }

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_String(String raw) {
    return api2wire_uint_8_list(utf8.encoder.convert(raw));
  }

  @protected
  ffi.Pointer<wire_StringList> api2wire_StringList(List<String> raw) {
    final ans = inner.new_StringList_0(raw.length);
    for (var i = 0; i < raw.length; i++) {
      ans.ref.ptr[i] = api2wire_String(raw[i]);
    }
    return ans;
  }

  @protected
  ffi.Pointer<wire_PrepareGameArgs> api2wire_box_autoadd_prepare_game_args(
      PrepareGameArgs raw) {
    final ptr = inner.new_box_autoadd_prepare_game_args_0();
    _api_fill_to_wire_prepare_game_args(raw, ptr.ref);
    return ptr;
  }

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_uint_8_list(Uint8List raw) {
    final ans = inner.new_uint_8_list_0(raw.length);
    ans.ref.ptr.asTypedList(raw.length).setAll(0, raw);
    return ans;
  }
// Section: finalizer

  late final OpaqueTypeFinalizer _PathBufFinalizer =
      OpaqueTypeFinalizer(inner._drop_opaque_PathBufPtr);
  OpaqueTypeFinalizer get PathBufFinalizer => _PathBufFinalizer;
// Section: api_fill_to_wire

  void _api_fill_to_wire_PathBuf(PathBuf apiObj, wire_PathBuf wireObj) {
    wireObj.ptr = apiObj.shareOrMove();
  }

  void _api_fill_to_wire_box_autoadd_prepare_game_args(
      PrepareGameArgs apiObj, ffi.Pointer<wire_PrepareGameArgs> wireObj) {
    _api_fill_to_wire_prepare_game_args(apiObj, wireObj.ref);
  }

  void _api_fill_to_wire_game_options(
      GameOptions apiObj, wire_GameOptions wireObj) {
    wireObj.auth_player_name = api2wire_String(apiObj.authPlayerName);
    wireObj.game_version_name = api2wire_String(apiObj.gameVersionName);
    wireObj.game_directory = api2wire_PathBuf(apiObj.gameDirectory);
    wireObj.assets_root = api2wire_PathBuf(apiObj.assetsRoot);
    wireObj.assets_index_name = api2wire_String(apiObj.assetsIndexName);
    wireObj.auth_uuid = api2wire_String(apiObj.authUuid);
    wireObj.user_type = api2wire_String(apiObj.userType);
    wireObj.version_type = api2wire_String(apiObj.versionType);
  }

  void _api_fill_to_wire_jvm_options(
      JvmOptions apiObj, wire_JvmOptions wireObj) {
    wireObj.launcher_name = api2wire_String(apiObj.launcherName);
    wireObj.launcher_version = api2wire_String(apiObj.launcherVersion);
    wireObj.classpath = api2wire_String(apiObj.classpath);
    wireObj.classpath_separator = api2wire_String(apiObj.classpathSeparator);
    wireObj.primary_jar = api2wire_String(apiObj.primaryJar);
    wireObj.library_directory = api2wire_PathBuf(apiObj.libraryDirectory);
    wireObj.game_directory = api2wire_PathBuf(apiObj.gameDirectory);
    wireObj.native_directory = api2wire_PathBuf(apiObj.nativeDirectory);
  }

  void _api_fill_to_wire_launch_args(
      LaunchArgs apiObj, wire_LaunchArgs wireObj) {
    wireObj.jvm_args = api2wire_StringList(apiObj.jvmArgs);
    wireObj.main_class = api2wire_String(apiObj.mainClass);
    wireObj.game_args = api2wire_StringList(apiObj.gameArgs);
  }

  void _api_fill_to_wire_prepare_game_args(
      PrepareGameArgs apiObj, wire_PrepareGameArgs wireObj) {
    _api_fill_to_wire_launch_args(apiObj.launchArgs, wireObj.launch_args);
    _api_fill_to_wire_jvm_options(apiObj.jvmArgs, wireObj.jvm_args);
    _api_fill_to_wire_game_options(apiObj.gameArgs, wireObj.game_args);
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

  void wire_download_vanilla(
    int port_,
  ) {
    return _wire_download_vanilla(
      port_,
    );
  }

  late final _wire_download_vanillaPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_download_vanilla');
  late final _wire_download_vanilla =
      _wire_download_vanillaPtr.asFunction<void Function(int)>();

  void wire_launch_game(
    int port_,
    ffi.Pointer<wire_PrepareGameArgs> pre_launch_arguments,
  ) {
    return _wire_launch_game(
      port_,
      pre_launch_arguments,
    );
  }

  late final _wire_launch_gamePtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64,
              ffi.Pointer<wire_PrepareGameArgs>)>>('wire_launch_game');
  late final _wire_launch_game = _wire_launch_gamePtr
      .asFunction<void Function(int, ffi.Pointer<wire_PrepareGameArgs>)>();

  void wire_download_forge(
    int port_,
    ffi.Pointer<wire_PrepareGameArgs> forge_prepare,
  ) {
    return _wire_download_forge(
      port_,
      forge_prepare,
    );
  }

  late final _wire_download_forgePtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64,
              ffi.Pointer<wire_PrepareGameArgs>)>>('wire_download_forge');
  late final _wire_download_forge = _wire_download_forgePtr
      .asFunction<void Function(int, ffi.Pointer<wire_PrepareGameArgs>)>();

  void wire_download_quilt(
    int port_,
    ffi.Pointer<wire_PrepareGameArgs> quilt_prepare,
  ) {
    return _wire_download_quilt(
      port_,
      quilt_prepare,
    );
  }

  late final _wire_download_quiltPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64,
              ffi.Pointer<wire_PrepareGameArgs>)>>('wire_download_quilt');
  late final _wire_download_quilt = _wire_download_quiltPtr
      .asFunction<void Function(int, ffi.Pointer<wire_PrepareGameArgs>)>();

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

  void wire_fetch_ui_layout(
    int port_,
  ) {
    return _wire_fetch_ui_layout(
      port_,
    );
  }

  late final _wire_fetch_ui_layoutPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_fetch_ui_layout');
  late final _wire_fetch_ui_layout =
      _wire_fetch_ui_layoutPtr.asFunction<void Function(int)>();

  wire_PathBuf new_PathBuf() {
    return _new_PathBuf();
  }

  late final _new_PathBufPtr =
      _lookup<ffi.NativeFunction<wire_PathBuf Function()>>('new_PathBuf');
  late final _new_PathBuf =
      _new_PathBufPtr.asFunction<wire_PathBuf Function()>();

  ffi.Pointer<wire_StringList> new_StringList_0(
    int len,
  ) {
    return _new_StringList_0(
      len,
    );
  }

  late final _new_StringList_0Ptr = _lookup<
          ffi.NativeFunction<ffi.Pointer<wire_StringList> Function(ffi.Int32)>>(
      'new_StringList_0');
  late final _new_StringList_0 = _new_StringList_0Ptr
      .asFunction<ffi.Pointer<wire_StringList> Function(int)>();

  ffi.Pointer<wire_PrepareGameArgs> new_box_autoadd_prepare_game_args_0() {
    return _new_box_autoadd_prepare_game_args_0();
  }

  late final _new_box_autoadd_prepare_game_args_0Ptr =
      _lookup<ffi.NativeFunction<ffi.Pointer<wire_PrepareGameArgs> Function()>>(
          'new_box_autoadd_prepare_game_args_0');
  late final _new_box_autoadd_prepare_game_args_0 =
      _new_box_autoadd_prepare_game_args_0Ptr
          .asFunction<ffi.Pointer<wire_PrepareGameArgs> Function()>();

  ffi.Pointer<wire_uint_8_list> new_uint_8_list_0(
    int len,
  ) {
    return _new_uint_8_list_0(
      len,
    );
  }

  late final _new_uint_8_list_0Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<wire_uint_8_list> Function(
              ffi.Int32)>>('new_uint_8_list_0');
  late final _new_uint_8_list_0 = _new_uint_8_list_0Ptr
      .asFunction<ffi.Pointer<wire_uint_8_list> Function(int)>();

  void drop_opaque_PathBuf(
    ffi.Pointer<ffi.Void> ptr,
  ) {
    return _drop_opaque_PathBuf(
      ptr,
    );
  }

  late final _drop_opaque_PathBufPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>(
          'drop_opaque_PathBuf');
  late final _drop_opaque_PathBuf = _drop_opaque_PathBufPtr
      .asFunction<void Function(ffi.Pointer<ffi.Void>)>();

  ffi.Pointer<ffi.Void> share_opaque_PathBuf(
    ffi.Pointer<ffi.Void> ptr,
  ) {
    return _share_opaque_PathBuf(
      ptr,
    );
  }

  late final _share_opaque_PathBufPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>)>>('share_opaque_PathBuf');
  late final _share_opaque_PathBuf = _share_opaque_PathBufPtr
      .asFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();

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

final class wire_uint_8_list extends ffi.Struct {
  external ffi.Pointer<ffi.Uint8> ptr;

  @ffi.Int32()
  external int len;
}

final class wire_StringList extends ffi.Struct {
  external ffi.Pointer<ffi.Pointer<wire_uint_8_list>> ptr;

  @ffi.Int32()
  external int len;
}

final class wire_LaunchArgs extends ffi.Struct {
  external ffi.Pointer<wire_StringList> jvm_args;

  external ffi.Pointer<wire_uint_8_list> main_class;

  external ffi.Pointer<wire_StringList> game_args;
}

final class wire_PathBuf extends ffi.Struct {
  external ffi.Pointer<ffi.Void> ptr;
}

final class wire_JvmOptions extends ffi.Struct {
  external ffi.Pointer<wire_uint_8_list> launcher_name;

  external ffi.Pointer<wire_uint_8_list> launcher_version;

  external ffi.Pointer<wire_uint_8_list> classpath;

  external ffi.Pointer<wire_uint_8_list> classpath_separator;

  external ffi.Pointer<wire_uint_8_list> primary_jar;

  external wire_PathBuf library_directory;

  external wire_PathBuf game_directory;

  external wire_PathBuf native_directory;
}

final class wire_GameOptions extends ffi.Struct {
  external ffi.Pointer<wire_uint_8_list> auth_player_name;

  external ffi.Pointer<wire_uint_8_list> game_version_name;

  external wire_PathBuf game_directory;

  external wire_PathBuf assets_root;

  external ffi.Pointer<wire_uint_8_list> assets_index_name;

  external ffi.Pointer<wire_uint_8_list> auth_uuid;

  external ffi.Pointer<wire_uint_8_list> user_type;

  external ffi.Pointer<wire_uint_8_list> version_type;
}

final class wire_PrepareGameArgs extends ffi.Struct {
  external wire_LaunchArgs launch_args;

  external wire_JvmOptions jvm_args;

  external wire_GameOptions game_args;
}

typedef DartPostCObjectFnType = ffi.Pointer<
    ffi.NativeFunction<
        ffi.Bool Function(DartPort port_id, ffi.Pointer<ffi.Void> message)>>;
typedef DartPort = ffi.Int64;
