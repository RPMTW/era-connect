import 'package:era_connect/api/lib.dart';
import 'package:era_connect_ui/components/dialog/step_dialog.dart';
import 'package:era_connect_i18n/era_connect_i18n.dart';
import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SetupDialog extends StatelessWidget {
  const SetupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return StepDialog(
      steps: [
        StepData(
          stepDescription: '匯入或新建設定',
          title: context.i18n['dialog.setup.welcome'],
          description: context.i18n['dialog.setup.01.description'],
          hasBrandText: true,
          contentPages: const [_ImportProfiles()],
        ),
        StepData(
            stepDescription: '登入帳號',
            title: context.i18n['dialog.setup.welcome'],
            description: context.i18n['dialog.setup.01.description'],
            contentPages: const [_LoginAccount()]),
        StepData(
            stepDescription: '建立第一個收藏',
            title: context.i18n['dialog.setup.welcome'],
            description: 'Test Description',
            contentPages: [
              const Text('Test 3 PAGE 1'),
              const Text('Test 3 PAGE 2'),
              const Text('Test 3 PAGE 3')
            ]),
        StepData(
            stepDescription: '為您的收藏加入內容',
            title: context.i18n['dialog.setup.welcome'],
            description: 'Test Description',
            contentPages: [const Text('Test 4')]),
        StepData(
          stepDescription: '大功告成！',
          title: '大功告成！',
          description: 'Test Description',
          contentPages: [const SizedBox.shrink()],
          onEvent: (event) {
            if (event == StepEvent.done) {
              configApi.uiLayout.completedSetup = true;
            }

            return true;
          },
        )
      ],
    );
  }
}

class _ImportProfiles extends StatelessWidget {
  const _ImportProfiles();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.i18n['dialog.setup.01.content.title'],
          style: TextStyle(
            color: context.theme.textColor,
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          context.i18n['dialog.setup.01.content.description'],
          style:
              TextStyle(color: context.theme.tertiaryTextColor, fontSize: 15),
        ),
        const SizedBox(height: 25),
        Expanded(
          child: DialogRectangleTab(
            title: '選擇方式',
            tabs: [
              TabItem(
                title: context.i18n['dialog.setup.01.content.tabs.empty.title'],
                icon: 'deployed_code',
              ),
              TabItem(
                  title:
                      context.i18n['dialog.setup.01.content.tabs.import.title'],
                  icon: 'deployed_code_update',
                  content: const DialogContentBox(
                    title: '匯入平台',
                    content: SizedBox.shrink(),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

class _LoginAccount extends StatelessWidget {
  const _LoginAccount();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '登入帳號',
          style: TextStyle(
            color: context.theme.textColor,
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          '登入帳號後即可開始享受遊戲的樂趣！',
          style:
              TextStyle(color: context.theme.tertiaryTextColor, fontSize: 15),
        ),
        const SizedBox(height: 25),
        Expanded(
          child: DialogRectangleTab(
            title: '選擇方式',
            tabs: [
              TabItem(
                title: '只登入主要帳號',
                icon: 'person',
                content: _buildSingleAccount(context),
              ),
              const TabItem(
                  title: '登入多個帳號',
                  icon: 'group',
                  content: DialogContentBox(
                    title: '多個帳號',
                    content: SizedBox.shrink(),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildSingleAccount(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: DialogContentBox(
            title: '登入動作',
            content: Center(
              child: EraDialogButton.textPrimary(
                text: '立即登入',
                onPressed: () {
                  showEraDialog(
                      context: context,
                      barrierDismissible: true,
                      dialog: const _LoginDialog());
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          '此動作將僅登入一個主要帳號，稍後你可以在帳號管理頁面中新增更多帳號。',
          style:
              TextStyle(color: context.theme.tertiaryTextColor, fontSize: 13),
        )
      ],
    );
  }
}

class _LoginDialog extends StatelessWidget {
  const _LoginDialog();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: authenticationApi.loginMinecraft(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final (deviceCode, accountFuture) = snapshot.data!;
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
                    copyCode(userCode);
                  },
                ),
                EraDialogButton.iconPrimary(
                    icon: const EraIcon(name: 'open_jam'),
                    onPressed: () {
                      copyCode(userCode);
                      launchUrlString(deviceCode.verificationUri);
                    })
              ],
            );
          }

          return const EraAlertDialog(
            title: '處理中......',
            description: '正在向 Microsoft 請求資料中，請稍等約 1 ~ 3 秒鐘',
          );
        });
  }

  void copyCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
  }
}
