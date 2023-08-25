import 'package:era_connect/api/lib.dart';
import 'package:era_connect_i18n/era_connect_i18n.dart';
import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';

import 'login_account_dialog.dart';

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
              storageApi.uiLayout.completedSetup = true;
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

class _LoginAccount extends StatefulWidget {
  const _LoginAccount();

  @override
  State<_LoginAccount> createState() => _LoginAccountState();
}

class _LoginAccountState extends State<_LoginAccount> {
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
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSingleAccount(BuildContext context) {
    final accounts = storageApi.accountStorage.accounts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: DialogContentBox(
            title: '登入動作',
            content: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: accounts.isEmpty
                      ? _buildLoginButton()
                      : _buildAccountTile(accounts.first),
                ),
              ],
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

  Widget _buildAccountTile(MinecraftAccount account) {
    final isMainAccount = storageApi.accountStorage.mainAccount == account.uuid;

    final leading = Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: account.skins.first.renderHead(size: 50),
        ),
        const SizedBox(width: 15),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  account.username,
                  style:
                      TextStyle(color: context.theme.textColor, fontSize: 18),
                ),
                const SizedBox(width: 5),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: isMainAccount
                        ? context.theme.accentColor
                        : context.theme.secondarySurfaceColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isMainAccount ? '主要' : '次要',
                    style:
                        TextStyle(color: context.theme.textColor, fontSize: 12),
                  ),
                )
              ],
            ),
            Text(
              'Minecraft 帳號',
              style: TextStyle(
                  color: context.theme.tertiaryTextColor, fontSize: 14),
            )
          ],
        ),
      ],
    );

    final actions = EraSecondaryButton(
      borderRadius: 50,
      hoverColor: context.theme.secondarySurfaceColor,
      onPressed: () async {
        await storageApi.accountStorage.removeAccount(account.uuid);

        if (!context.mounted) return;
        _showLoginAccountDialog();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.restart_alt_rounded, color: context.theme.textColor),
            const SizedBox(width: 5),
            Text(
              '重新登入',
              style: TextStyle(color: context.theme.textColor, fontSize: 15),
            )
          ],
        ),
      ),
    );

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: context.theme.deepBackgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [leading, actions],
      ),
    );
  }

  Widget _buildLoginButton() {
    return EraBasicButton(
      onPressed: () => _showLoginAccountDialog(),
      style: EraBasicButtonStyle(
          backgroundColor: context.theme.deepBackgroundColor,
          hoverColor: context.theme.surfaceColor,
          borderRadius: 15),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_add_alt_rounded,
              color: context.theme.textColor,
            ),
            const SizedBox(width: 10),
            Text('立即登入', style: TextStyle(color: context.theme.textColor))
          ],
        ),
      ),
    );
  }

  Future<void> _showLoginAccountDialog() {
    return showEraDialog(
      context: context,
      barrierDismissible: true,
      dialog: LoginAccountDialog(
        callback: () {
          setState(() {});
        },
      ),
    );
  }
}
