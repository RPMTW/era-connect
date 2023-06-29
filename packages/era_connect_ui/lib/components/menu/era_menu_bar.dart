import 'package:era_connect_ui/theme/theme_provider.dart';
import 'package:flutter/material.dart';

import 'era_menu_account.dart';

class EraMenuBar extends StatefulWidget {
  const EraMenuBar({super.key});

  @override
  State<EraMenuBar> createState() => _EraMenuBarState();
}

class _EraMenuBarState extends State<EraMenuBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.deepBackgroundColor,
      constraints:
          BoxConstraints(minWidth: MediaQuery.of(context).size.width * 0.2),
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EraMenuAccount(),
                SizedBox(height: 20),
                Placeholder(fallbackHeight: 100, fallbackWidth: 200),
                SizedBox(height: 20),
                Placeholder(fallbackHeight: 100, fallbackWidth: 200),
              ],
            ),
            Column(
              children: [
                Placeholder(fallbackHeight: 70, fallbackWidth: 200),
                SizedBox(height: 20),
                Placeholder(fallbackHeight: 70, fallbackWidth: 200),
              ],
            )
          ],
        ),
      ),
    );
  }
}
