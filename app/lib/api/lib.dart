import 'ffi.dart' show api;

export 'config/config_api.dart';

Future<void> initializeAPIs() async {
  await api.setupLogger();
}
