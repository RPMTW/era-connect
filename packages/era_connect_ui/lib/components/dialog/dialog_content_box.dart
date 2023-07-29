import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/widgets.dart';

class DialogContentBox extends StatelessWidget {
  final String title;
  final Widget content;
  const DialogContentBox(
      {super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            constraints: const BoxConstraints.expand(height: 50),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              color: context.theme.surfaceColor,
            ),
            child: Text(title,
                style: TextStyle(fontSize: 16, color: context.theme.textColor)),
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(20),
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(15)),
              color: context.theme.backgroundColor,
            ),
            child: content,
          ),
        )
      ],
    );
  }
}
