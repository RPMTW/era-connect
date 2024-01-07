import 'package:era_connect/api/lib.dart';
import 'package:era_connect/dialog/login_account_dialog.dart';
import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';

class LoginAccountStep extends StatefulWidget {
  const LoginAccountStep({super.key});

  @override
  State<LoginAccountStep> createState() => _LoginAccountStepState();
}

class _LoginAccountStepState extends State<LoginAccountStep> {
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
                icon: EraIcon.assets('person'),
                content: _buildSingleAccount(context),
              ),
              TabItem(
                title: '登入多個帳號',
                icon: EraIcon.assets('group'),
                content: const DialogContentBox(
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
            EraIcon.material(Icons.restart_alt_rounded),
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
      key: const Key('account_tile'),
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
      key: const Key('login_account_button'),
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
            EraIcon.material(Icons.person_add_alt_rounded),
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
