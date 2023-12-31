import 'ffi.dart' show api;

export 'storage/lib.dart';
export 'authentication/lib.dart';

export 'package:era_connect/api/gen/bridge_definitions.dart'
    show
        LoginFlowDeviceCode,
        LoginFlowStage,
        MinecraftAccount,
        AccountToken,
        MinecraftSkin,
        XstsTokenErrorType;

Future<void> initializeAPIs() async {
  await api.setupLogger();
}
