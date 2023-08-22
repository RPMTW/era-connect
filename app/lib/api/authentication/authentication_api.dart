import 'dart:async';
import 'dart:io';

import 'package:era_connect/api/gen/bridge_definitions.dart' as bridge;
import 'package:era_connect/api/ffi.dart';
import 'package:flutter/widgets.dart';

final AuthenticationApi authenticationApi = AuthenticationApi();

typedef MinecraftLoginData = (
  bridge.LoginFlowDeviceCode deviceCode,
  Stream<bridge.LoginFlowStage> stageStream,
  Future<bridge.MinecraftAccount> account
);

typedef LoginXstsError = bridge.LoginFlowErrors_XstsError;
typedef LoginErrorGameNotOwn = bridge.LoginFlowErrors_GameNotOwned;

class AuthenticationApi {
  Future<MinecraftLoginData> loginMinecraft() async {
    final flowStream = api.minecraftLoginFlow();

    final deviceCodeCompleter = Completer<bridge.LoginFlowDeviceCode>();
    final accountCompleter = Completer<bridge.MinecraftAccount>();
    final stageStreamController = StreamController<bridge.LoginFlowStage>();

    flowStream.listen((event) {
      if (accountCompleter.isCompleted) return;

      if (event is bridge.LoginFlowEvent_DeviceCode) {
        deviceCodeCompleter.complete(event.field0);
      } else if (event is bridge.LoginFlowEvent_Stage) {
        stageStreamController.add(event.field0);
      } else if (event is bridge.LoginFlowEvent_Error) {
        accountCompleter.completeError(event.field0);
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

extension MinecraftSkinExtension on bridge.MinecraftSkin {
  Image renderHead({required double size}) {
    final defaultImage = Image.asset(
      'assets/images/steve.png',
      width: size,
      height: size,
    );

    final path = api.getSkinFilePath(skin: this);
    if (path == null) return defaultImage;

    final file = File(path);
    if (!file.existsSync()) return defaultImage;

    return Image.file(
      file,
      scale: 0.9,
      width: size,
      height: size,
      errorBuilder: (context, error, stackTrace) {
        return defaultImage;
      },
    );
  }
}
