import 'package:era_connect_i18n/era_connect_i18n.dart';
import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';

class SetupDialog extends StatelessWidget {
  const SetupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return InteractiveDialog(
      title: context.i18n['dialog.setup.01.title'],
      description: context.i18n['dialog.setup.01.description'],
      logoBoxText: '01',
      body: Padding(
        padding:
            const EdgeInsets.only(top: 45, bottom: 35, left: 45, right: 45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                  style: TextStyle(
                      color: context.theme.tertiaryTextColor, fontSize: 15),
                ),
                const SizedBox(height: 25),
                DialogRectangleTab(
                  title: '選擇方式',
                  tabs: [
                    TabItem(
                      title: context
                          .i18n['dialog.setup.01.content.tabs.empty.title'],
                      icon: 'deployed_code',
                      content: const Text('這是從頭開始的頁面',
                          style: TextStyle(fontSize: 30)),
                    ),
                    TabItem(
                        title: context
                            .i18n['dialog.setup.01.content.tabs.import.title'],
                        icon: 'deployed_code_update',
                        content: const Text('這是匯入設定的頁面',
                            style: TextStyle(fontSize: 50))),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                EraTextButton.secondary(text: '略過', onPressed: () {}),
                const SizedBox(width: 10),
                EraTextButton.primary(text: '繼續', onPressed: () {}),
              ],
            )
          ],
        ),
      ),
    );
  }
}
