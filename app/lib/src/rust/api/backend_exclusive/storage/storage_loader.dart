// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.21.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../../frb_generated.dart';
import '../../shared_resources/authentication/account.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

class StorageLoader {
  final String fileName;
  final PathBuf basePath;

  const StorageLoader({
    required this.fileName,
    required this.basePath,
  });

  @override
  int get hashCode => fileName.hashCode ^ basePath.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StorageLoader &&
          runtimeType == other.runtimeType &&
          fileName == other.fileName &&
          basePath == other.basePath;
}
