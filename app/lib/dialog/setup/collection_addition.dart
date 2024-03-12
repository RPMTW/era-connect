import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';

class CollectionAdditionStep extends StatelessWidget {
  const CollectionAdditionStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '為您的收藏加入內容',
          style: TextStyle(
            color: context.theme.textColor,
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          '在您的收藏中加入內容使遊戲更加豐富有趣',
          style:
              TextStyle(color: context.theme.tertiaryTextColor, fontSize: 15),
        ),
        const SizedBox(height: 25),
        const Expanded(
          child: DialogContentBox(
            title: '加入更多內容',
            content: SizedBox.shrink(),
          ),
        )
      ],
    );
  }
}
