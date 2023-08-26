import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CollectionGameMode extends StatelessWidget {
  const CollectionGameMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '遊戲方式',
          style: TextStyle(
            color: context.theme.textColor,
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          '選擇您想建立的收藏遊戲模式',
          style:
              TextStyle(color: context.theme.tertiaryTextColor, fontSize: 15),
        ),
        const SizedBox(height: 25),
        Expanded(
          child: DialogRectangleTab(
            title: '遊戲方式',
            tabs: [
              TabItem(
                title: '原汁原味',
                icon: EraIcon.assets('clear_day'),
                content: const DialogContentBox(
                  title: '介紹',
                  content: SizedBox.shrink(),
                ),
              ),
              TabItem(
                title: '搶先體驗',
                icon: EraIcon.material(Icons.local_fire_department_outlined),
                content: const DialogContentBox(
                  title: '介紹',
                  content: SizedBox.shrink(),
                ),
              ),
              TabItem(
                title: '創意模組',
                icon: EraIcon.material(Icons.draw_outlined),
                content: const DialogContentBox(
                  title: '介紹',
                  content: SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
