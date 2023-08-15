import 'ffi.dart' show api;

export 'ffi.dart' show api;
export 'config/lib.dart';
export 'authentication/lib.dart';

export 'package:era_connect/api/gen/bridge_definitions.dart'
    show
        LoginFlowDeviceCode,
        LoginFlowStage,
        MinecraftAccount,
        XstsTokenErrorType;

Future<void> initializeAPIs() async {
  await api.setupLogger();
}
