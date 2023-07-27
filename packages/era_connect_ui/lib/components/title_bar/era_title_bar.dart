import 'package:era_connect_ui/theme/lib.dart';
import 'package:era_connect_ui/components/misc/lib.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'era_title_bar_action.dart';

class EraTitleBar extends StatelessWidget {
  const EraTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: Container(
        color: context.theme.deepBackgroundColor,
        padding: const EdgeInsets.only(left: 20, right: 8, top: 7, bottom: 7),
        child: Container(
          color: context.theme.deepBackgroundColor,
          child: Container(
            constraints: const BoxConstraints(minHeight: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    EraLogo(size: 16),
                    SizedBox(width: 10),
                    EraBrandText(fontSize: 28)
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
