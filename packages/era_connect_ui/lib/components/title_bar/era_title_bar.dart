import 'package:era_connect_ui/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'era_title_bar_action.dart';

class EraTitleBar extends StatelessWidget {
  final Widget logo;

  const EraTitleBar({super.key, required this.logo});

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: Container(
        color: context.theme.primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Container(
          color: context.theme.primaryColor,
          child: Container(
            constraints: const BoxConstraints(minHeight: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    logo,
                    const SizedBox(width: 10),
                    const Text('Era Connect',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ))
                  ],
                ),
                Wrap(spacing: 8, children: [
                  EraTitleBarAction.minimize(),
                  EraTitleBarAction.maximize(),
                  EraTitleBarAction.close()
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
