import 'package:era_connect_i18n/era_connect_i18n.dart';
import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/widgets.dart';

class ImportProfilesStep extends StatelessWidget {
  const ImportProfilesStep({super.key});

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
