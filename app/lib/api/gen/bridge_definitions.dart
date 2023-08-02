// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.80.1.
// ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, unnecessary_import, prefer_single_quotes, prefer_const_constructors, use_super_parameters, always_use_package_imports, annotate_overrides, invalid_use_of_protected_member, constant_identifier_names, invalid_use_of_internal_member, prefer_is_empty, unnecessary_const

import 'dart:convert';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:uuid/uuid.dart';
import 'package:freezed_annotation/freezed_annotation.dart' hide protected;

part 'bridge_definitions.freezed.dart';

abstract class Native {
  Stream<LogEntry> setupLogger({dynamic hint});

  FlutterRustBridgeTaskConstMeta get kSetupLoggerConstMeta;

  Stream<ReturnType> downloadVanilla({dynamic hint});

  FlutterRustBridgeTaskConstMeta get kDownloadVanillaConstMeta;

  Future<void> launchGame(
      {required PrepareGameArgs preLaunchArguments, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kLaunchGameConstMeta;

  Stream<ReturnType> downloadQuilt(
      {required PrepareGameArgs quiltPrepare, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kDownloadQuiltConstMeta;

  Future<DownloadState> fetchState({dynamic hint});

  FlutterRustBridgeTaskConstMeta get kFetchStateConstMeta;

  Future<void> writeState({required DownloadState s, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kWriteStateConstMeta;

  Value getUiLayoutConfig({required Key key, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kGetUiLayoutConfigConstMeta;

  Future<void> setUiLayoutConfig({required Value value, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kSetUiLayoutConfigConstMeta;

  DropFnType get dropOpaquePathBuf;
  ShareFnType get shareOpaquePathBuf;
  OpaqueTypeFinalizer get PathBufFinalizer;
}

@sealed
class PathBuf extends FrbOpaque {
  final Native bridge;
  PathBuf.fromRaw(int ptr, int size, this.bridge) : super.unsafe(ptr, size);
  @override
  DropFnType get dropFn => bridge.dropOpaquePathBuf;

  @override
  ShareFnType get shareFn => bridge.shareOpaquePathBuf;

  @override
  OpaqueTypeFinalizer get staticFinalizer => bridge.PathBufFinalizer;
}

enum DownloadState {
  Downloading,
  Paused,
  Stopped,
}

class GameOptions {
  final String authPlayerName;
  final String gameVersionName;
  final PathBuf gameDirectory;
  final PathBuf assetsRoot;
  final String assetsIndexName;
  final String authUuid;
  final String userType;
  final String versionType;

  const GameOptions({
    required this.authPlayerName,
    required this.gameVersionName,
    required this.gameDirectory,
    required this.assetsRoot,
    required this.assetsIndexName,
    required this.authUuid,
    required this.userType,
    required this.versionType,
  });
}

class JvmOptions {
  final String launcherName;
  final String launcherVersion;
  final String classpath;
  final String classpathSeparator;
  final String primaryJar;
  final PathBuf libraryDirectory;
  final PathBuf gameDirectory;
  final PathBuf nativeDirectory;

  const JvmOptions({
    required this.launcherName,
    required this.launcherVersion,
    required this.classpath,
    required this.classpathSeparator,
    required this.primaryJar,
    required this.libraryDirectory,
    required this.gameDirectory,
    required this.nativeDirectory,
  });
}

enum Key {
  CompletedSetup,
}

class LaunchArgs {
  final List<String> jvmArgs;
  final String mainClass;
  final List<String> gameArgs;

  const LaunchArgs({
    required this.jvmArgs,
    required this.mainClass,
    required this.gameArgs,
  });
}

class LogEntry {
  final LogLevel level;
  final String message;
  final int timestamp;

  const LogEntry({
    required this.level,
    required this.message,
    required this.timestamp,
  });
}

enum LogLevel {
  Error,
  Warn,
  Info,
  Debug,
  Trace,
}

class PrepareGameArgs {
  final LaunchArgs launchArgs;
  final JvmOptions jvmArgs;
  final GameOptions gameArgs;

  const PrepareGameArgs({
    required this.launchArgs,
    required this.jvmArgs,
    required this.gameArgs,
  });
}

class Progress {
  final double speed;
  final double percentages;
  final double currentSize;
  final double totalSize;

  const Progress({
    required this.speed,
    required this.percentages,
    required this.currentSize,
    required this.totalSize,
  });
}

class ReturnType {
  final Progress? progress;
  final PrepareGameArgs? prepareNameArgs;

  const ReturnType({
    this.progress,
    this.prepareNameArgs,
  });
}

@freezed
sealed class Value with _$Value {
  const factory Value.completedSetup(
    bool field0,
  ) = Value_CompletedSetup;
}
