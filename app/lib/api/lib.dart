import 'ffi.dart' show api;

export 'storage/lib.dart';
export 'authentication/lib.dart';
export 'meta/lib.dart';

Future<void> initializeAPIs() async {
  await api.setupLogger();
}
