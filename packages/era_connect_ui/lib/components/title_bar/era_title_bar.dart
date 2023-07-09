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
        padding: const EdgeInsets.only(left: 20, right: 8, top: 7, bottom: 7),
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
                            fontSize: 29,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Geo',
                            letterSpacing: -1))
                  ],
                ),
                Wrap(spacing: 5, children: [
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
