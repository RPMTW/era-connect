import 'package:era_connect/api/lib.dart';
import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginAccountDialog extends StatelessWidget {
  const LoginAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: authenticationApi.loginMinecraft(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildWaitingAuth(snapshot.data!);
          }

          return const EraAlertDialog(
            title: '處理中......',
            description: '正在向 Microsoft 請求資料中，請稍等約 1 ~ 3 秒鐘',
          );
        });
  }

  Widget _buildWaitingAuth(MinecraftLoginData data) {
    final (deviceCode, stageStream, accountFuture) = data;

    return FutureBuilder(
      future: accountFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final account = snapshot.data!;

          return EraAlertDialog(
            title: '登入成功！',
            description: '帳號 ${account.username} 已成功登入！',
            actions: [
              EraDialogButton.iconPrimary(
                icon: const Icon(Icons.check_rounded),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        } else if (snapshot.hasError) {
          return EraAlertDialog(
            title: '登入失敗',
            description: '登入失敗，原因：${snapshot.error}',
            actions: [
              EraDialogButton.iconPrimary(
                icon: const Icon(Icons.close_rounded),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }

        return StreamBuilder(
          stream: stageStream,
          builder: (context, stageSnapshot) {
            if (stageSnapshot.hasData) {
              final stage = stageSnapshot.data!;
              final userAlreadyLogin =
                  stage != LoginFlowStage.FetchingDeviceCode &&
                      stage != LoginFlowStage.WaitingForUser;

              if (userAlreadyLogin) {
                return const EraAlertDialog(
                  title: '正在驗證',
                  description: '我們正在為您登入帳號中，請稍等一下。',
                );
              }
            }

            return _buildDeviceCodeDialog(context, deviceCode);
          },
        );
      },
    );
  }

  Widget _buildDeviceCodeDialog(
      BuildContext context, LoginFlowDeviceCode deviceCode) {
    final userCode = deviceCode.userCode;

    return EraAlertDialog(
      title: '完成登入',
      description:
          '請點擊右下角的按鈕複製代碼後前往 Microsoft 登入頁面並貼上代碼以完成登入，倘若未自動複製代碼請手動輸入至 Microsoft 的登入頁面',
      content: Wrap(
        spacing: 10,
        children: userCode.characters
            .map((e) => Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: context.theme.deepBackgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    e,
                    style: const TextStyle(fontSize: 22),
                  ),
                ))
            .toList(),
      ),
      actions: [
        EraDialogButton.iconSecondary(
          icon: const Icon(Icons.content_copy_rounded),
          onPressed: () {
            _copyCode(userCode);
          },
        ),
        EraDialogButton.iconPrimary(
            icon: const EraIcon(name: 'open_jam'),
            onPressed: () {
              _copyCode(userCode);
              launchUrlString(deviceCode.verificationUri);
            })
      ],
    );
  }

  void _copyCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
  }
}
