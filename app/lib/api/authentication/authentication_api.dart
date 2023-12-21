import 'dart:async';
import 'dart:io';

import 'package:era_connect/src/rust/api.dart';
import 'package:era_connect/src/rust/api/authentication/account.dart';
import 'package:era_connect/src/rust/api/authentication/msa_flow.dart';
import 'package:flutter/widgets.dart';

const authenticationApi = AuthenticationApi();

typedef MinecraftLoginData = (
  LoginFlowDeviceCode deviceCode,
  Stream<LoginFlowStage> stageStream,
  Future<MinecraftAccount> account
);

typedef LoginXstsError = LoginFlowErrors_XstsError;
typedef LoginErrorGameNotOwn = LoginFlowErrors_GameNotOwned;

class AuthenticationApi {
  const AuthenticationApi();

  Future<MinecraftLoginData> loginMinecraft() async {
    final flowStream = minecraftLoginFlow();

    final deviceCodeCompleter = Completer<LoginFlowDeviceCode>();
    final accountCompleter = Completer<MinecraftAccount>();
    final stageStreamController = StreamController<LoginFlowStage>();

    flowStream.listen((event) {
      if (accountCompleter.isCompleted) return;

      if (event is LoginFlowEvent_DeviceCode) {
        deviceCodeCompleter.complete(event.field0);
      } else if (event is LoginFlowEvent_Stage) {
        stageStreamController.add(event.field0);
      } else if (event is LoginFlowEvent_Error) {
        accountCompleter.completeError(event.field0);
      } else if (event is LoginFlowEvent_Success) {
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

extension MinecraftSkinExtension on MinecraftSkin {
  Image renderHead({required double size}) {
    final defaultImage = Image.asset(
      'assets/images/steve.png',
      width: size,
      height: size,
    );

    final String path = getSkinFilePath(skin: this);
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
