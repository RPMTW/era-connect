import 'package:era_connect/api/lib.dart';
import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginAccountDialog extends StatelessWidget {
  final VoidCallback? callback;

  const LoginAccountDialog({super.key, this.callback});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: authenticationApi.loginMinecraft(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildWaitingAuth(snapshot.data!);
        } else if (snapshot.hasError) {
          return _LoginErrorDialog(error: snapshot.error, callback: callback);
        }

        return const EraAlertDialog(
          title: '處理中......',
          description: '正在向 Microsoft 請求資料中，請稍等約 1 ~ 2 秒鐘',
          loadingIndicator: true,
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
            description: '您的帳號（${account.username}）已成功登入！',
            actions: [
              EraPrimaryButton.icon(
                icon: EraIcon.material(Icons.check_rounded),
                onPressed: () {
                  callback?.call();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        } else if (snapshot.hasError) {
          return _LoginErrorDialog(error: snapshot.error, callback: callback);
        }

        return StreamBuilder(
          stream: stageStream,
          builder: (context, stageSnapshot) {
            if (stageSnapshot.hasData) {
              final stage = stageSnapshot.data!;
              final userAlreadyLogin =
                  stage != LoginFlowStage.fetchingDeviceCode &&
                      stage != LoginFlowStage.waitingForUser;

              if (userAlreadyLogin) {
                return const EraAlertDialog(
                  title: '正在驗證',
                  description: '我們正在為您登入帳號中，請稍等一下。',
                  loadingIndicator: true,
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
      description: '請在瀏覽器中打開 ${deviceCode.verificationUri} 並輸入下方驗證碼即可完成登入。',
      loadingIndicator: true,
      content: Wrap(
        spacing: 10,
        children: userCode.characters
            .map(
              (code) => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                decoration: BoxDecoration(
                    color: context.theme.dialogBarrierColor,
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
        EraSecondaryButton.icon(
          icon: EraIcon.material(Icons.content_copy_rounded),
          onPressed: () {
            _copyCode(userCode);
          },
        ),
        EraPrimaryButton.icon(
            icon: EraIcon.assets('open_jam'),
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

class _LoginErrorDialog extends StatelessWidget {
  final Object? error;
  final VoidCallback? callback;

  const _LoginErrorDialog({required this.error, required this.callback});

  @override
  Widget build(BuildContext context) {
    final error = this.error;
    final String title;
    final String description;

    if (error is LoginXstsError) {
      const String needsAdultVerification =
          '本帳號需要在 [Xbox 頁面](live.xbox.com/ageverification) 完成成人驗證（僅限南韓）。';

      switch (error.field0) {
        case XstsTokenErrorType.doesNotHaveXboxAccount:
          title = '未連結 Xbox 帳號';
          description =
              '您的 Microsoft 帳號尚未連結 Xbox 帳號。請確認您登入的帳號是否正確，並且您至少在官方啟動器中登入過一次這個帳號。';
        case XstsTokenErrorType.countryNotAvailable:
          title = '國家或地區不受支援';
          description = '本帳號所在的國家或地區不受 Xbox Live 支援，因此無法登入 Minecraft 帳號。';
        case XstsTokenErrorType.needsAdultVerificationKr1:
          title = '未完成成人驗證';
          description = needsAdultVerification;
        case XstsTokenErrorType.needsAdultVerificationKr2:
          title = '未完成成人驗證';
          description = needsAdultVerification;
        case XstsTokenErrorType.childAccount:
          title = '未成年帳號';
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
      title = '未購買遊戲';
      description =
          '''請確認您的帳號已購買 Minecraft: Java Edition 或 Xbox Game Pass 並且至少在官方啟動器中登入過一次這個帳號。
          \\
          倘若您尚未購買 Minecraft: Java Edition 可至 [Minecraft 官方網站](https://www.minecraft.net/store/minecraft-java-bedrock-edition-pc) 購買''';
    } else {
      title = '未知錯誤';
      description = '執行登入作業時發生未知錯誤，請再試一次，若仍失敗請聯繫開發者協助您解決問題，原因如下：\\$error';
    }

    final backgroundColor = context.theme.dialogBarrierColor;
    final border =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));

    return EraAlertDialog(
      title: '登入失敗',
      description: '不好意思，登入過程中出了一點問題！您可以展開下方的解決方案來嘗試解決問題。',
      content: ExpansionTile(
        title: Text(title, style: TextStyle(color: context.theme.textColor)),
        shape: border,
        collapsedShape: border,
        backgroundColor: backgroundColor,
        collapsedBackgroundColor: backgroundColor,
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 5, right: 25, left: 25, bottom: 25),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: MarkdownText(description,
                style: TextStyle(
                    fontSize: 16, color: context.theme.tertiaryTextColor)),
          )
        ],
      ),
      actions: [
        EraSecondaryButton.icon(
          icon: EraIcon.material(Icons.close_rounded),
          onPressed: () {
            callback?.call();
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
