import 'ffi.dart' show api;

export 'storage/lib.dart';
export 'authentication/lib.dart';
export 'meta/lib.dart';
export 'collection/collection_api.dart';

Future<void> initializeAPIs() async {
  await api.setupLogger();
}
