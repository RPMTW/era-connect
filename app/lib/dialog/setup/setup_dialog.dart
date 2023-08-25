import 'package:era_connect/api/lib.dart';
import 'package:era_connect_i18n/era_connect_i18n.dart';
import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';

import 'import_profiles.dart';
import 'login_account.dart';

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
          contentPages: const [ImportProfilesStep()],
        ),
        StepData(
            stepDescription: '登入帳號',
            title: context.i18n['dialog.setup.welcome'],
            description: context.i18n['dialog.setup.01.description'],
            contentPages: const [LoginAccountStep()]),
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

