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
        } else if (snapshot.hasError) {
          return _buildErrorResponse(context, snapshot.error);
        }

        return const EraAlertDialog(
          title: '處理中......',
          description: '正在向 Microsoft 請求資料中，請稍等約 1 ~ 3 秒鐘',
        );
      },
    );
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
          return _buildErrorResponse(context, snapshot.error);
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

  Widget _buildErrorResponse(BuildContext context, Object? error) {
    const String needsAdultVerification =
        '本帳號需要在 [Xbox 頁面](live.xbox.com/ageverification) 完成成人驗證（僅限南韓）。';
    final String description;
    if (error is LoginXstsError) {
      switch (error.field0) {
        case XstsTokenErrorType.DoesNotHaveXboxAccount:
          description =
              '您的 Microsoft 帳號尚未連結 Xbox 帳號。請確認您登入的帳號是否正確，並且您至少在官方啟動器中登入過一次這個帳號。';
        case XstsTokenErrorType.CountryNotAvailable:
          description = '本帳號所在的國家或地區不受 Xbox Live 支援，因此無法登入 Minecraft 帳號。';
        case XstsTokenErrorType.NeedsAdultVerificationKR1:
          description = needsAdultVerification;
        case XstsTokenErrorType.NeedsAdultVerificationKR2:
          description = needsAdultVerification;
        case XstsTokenErrorType.ChildAccount:
          description = '''您的帳號為未成年帳號，根據 Microsoft (微軟) 政策限制，不允許未成年帳號透過第三方啟動器登入。
          \\
          \\
          倘若您認為有誤，請至 [Microsoft 帳號頁面](https://account.microsoft.com/profile) 修改為正確的生日。  
          此外，倘若您需要透過多人伺服器與好友一同享受遊戲，請開啟 [Xbox 頁面](https://account.xbox.com/Settings?wa=wsignin1.0&activetab=main%3aprivacytab) 找到一個類似「在 Xbox Live 上與其他玩家遊玩」的選項，並確保該選項已開啟。
          \\
          \\
          最後等待一段時間再重新登入應該就會成功了，若仍無效可到我們的 [Discord 群組](https://discord.gg/5xApZtgV2u) 尋求技術支援。
          ''';
      }
    } else if (error is LoginErrorGameNotOwn) {
      description =
          '''請確認您的帳號已購買 Minecraft: Java Edition 或 Xbox Game Pass 並且至少在官方啟動器中登入過一次這個帳號。
          \\
          倘若您尚未購買 Minecraft: Java Edition 可至 [Minecraft 官方網站](https://www.minecraft.net/store/minecraft-java-bedrock-edition-pc) 購買''';
    } else {
      description = '執行登入作業時發生未知錯誤，請再試一次，若仍失敗請聯繫開發者協助您解決問題，原因如下：\\$error';
    }

    return EraAlertDialog(
      title: '登入失敗',
      description: description,
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

  Widget _buildDeviceCodeDialog(
      BuildContext context, LoginFlowDeviceCode deviceCode) {
    final userCode = deviceCode.userCode;

    return EraAlertDialog(
      title: '完成登入',
      description: '請在瀏覽器中打開 ${deviceCode.verificationUri} 並輸入下方驗證碼即可完成登入。',
      content: Wrap(
        spacing: 10,
        children: userCode.characters
            .map(
              (code) => Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: context.theme.deepBackgroundColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  code,
                  style: const TextStyle(
                    fontSize: 22,
                    fontFamily: 'BaiJamjuree',
                  ),
                ),
              ),
            )
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
