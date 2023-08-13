import 'ffi.dart' show api;

export 'ffi.dart' show api;
export 'config/lib.dart';

Future<void> initializeAPIs() async {
  await api.setupLogger();
}
