import 'dart:async';

import 'package:era_connect/api/gen/bridge_definitions.dart' as bridge;
import 'package:era_connect/api/ffi.dart';

final AuthenticationApi authenticationApi = AuthenticationApi();

class AuthenticationApi {
  Future<
      (
        bridge.LoginFlowDeviceCode deviceCode,
        Future<bridge.MinecraftAccount> account
      )> loginMinecraft() async {
    final flowStream = api.minecraftLoginFlow();
    final accountCompleter = Completer<bridge.MinecraftAccount>();
    final deviceCodeCompleter = Completer<bridge.LoginFlowDeviceCode>();

    flowStream.listen((event) {
      if (event is bridge.LoginFlowEvent_DeviceCode) {
        deviceCodeCompleter.complete(event.field0);
      } else if (event is bridge.LoginFlowEvent_Stage) {
        // TODO: Handle stage
        print(event.field0);
      } else if (event is bridge.LoginFlowEvent_Error) {
        throw event.field0;
      } else if (event is bridge.LoginFlowEvent_Success) {
        accountCompleter.complete(event.field0);
      }
    });

    return (await deviceCodeCompleter.future, accountCompleter.future);
  }
}
