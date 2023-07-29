import 'package:era_connect/components/step_dialog.dart';
import 'package:era_connect_i18n/era_connect_i18n.dart';
import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';

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
          logoBoxText: '01',
          skippable: true,
          contents: [Builder(builder: (context) => _step1(context))],
        ),
        StepData(
            stepDescription: '登入帳號',
            title: context.i18n['dialog.setup.welcome'],
            description: 'Test Description',
            logoBoxText: '02',
            contents: [const Text('Test 2')]),
        StepData(
            stepDescription: '建立第一個收藏',
            title: context.i18n['dialog.setup.welcome'],
            description: 'Test Description',
            logoBoxText: '03',
            contents: [
              const Text('Test 3 PAGE 1'),
              const Text('Test 3 PAGE 2'),
              const Text('Test 3 PAGE 3')
            ]),
        StepData(
            stepDescription: '為您的收藏加入內容',
            title: context.i18n['dialog.setup.welcome'],
            description: 'Test Description',
            logoBoxText: '04',
            contents: [const Text('Test 4')]),
        StepData(
            stepDescription: '大功告成！',
            title: '大功告成！',
            description: 'Test Description',
            logoBoxText: '05',
            contents: [const SizedBox.shrink()])
      ],
    );
  }

  Widget _step1(BuildContext context) {
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
