import 'dart:async';

import 'package:era_connect/api/gen/bridge_definitions.dart' as bridge;
import 'package:era_connect/api/ffi.dart';

final AuthenticationApi authenticationApi = AuthenticationApi();

typedef MinecraftLoginData = (
  bridge.LoginFlowDeviceCode deviceCode,
  Stream<bridge.LoginFlowStage> stageStream,
  Future<bridge.MinecraftAccount> account
);

class AuthenticationApi {
  Future<MinecraftLoginData> loginMinecraft() async {
    final flowStream = api.minecraftLoginFlow();

    final deviceCodeCompleter = Completer<bridge.LoginFlowDeviceCode>();
    final accountCompleter = Completer<bridge.MinecraftAccount>();
    final stageStreamController = StreamController<bridge.LoginFlowStage>();

    flowStream.listen((event) {
      if (event is bridge.LoginFlowEvent_DeviceCode) {
        deviceCodeCompleter.complete(event.field0);
      } else if (event is bridge.LoginFlowEvent_Stage) {
        stageStreamController.add(event.field0);
      } else if (event is bridge.LoginFlowEvent_Error) {
        throw event.field0;
      } else if (event is bridge.LoginFlowEvent_Success) {
        accountCompleter.complete(event.field0);
      }
    });

    return (
      await deviceCodeCompleter.future,
      stageStreamController.stream,
      accountCompleter.future
    );
  }
}
