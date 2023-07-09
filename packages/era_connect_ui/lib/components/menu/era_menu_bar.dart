import 'package:era_connect_ui/components/menu/era_menu_item.dart';
import 'package:era_connect_ui/theme/theme_provider.dart';
import 'package:flutter/material.dart';

import 'era_menu_account.dart';

class EraMenuBar extends StatefulWidget {
  final List<EraMenuItemData> items;

  const EraMenuBar({super.key, required this.items})
      : assert(items.length != 0);

  @override
  State<EraMenuBar> createState() => _EraMenuBarState();
}

class _EraMenuBarState extends State<EraMenuBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.deepBackgroundColor,
      constraints: const BoxConstraints(maxWidth: 308),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const EraMenuAccount(),
                const SizedBox(height: 16),
                ...widget.items.map((data) {
                  final index = widget.items.indexOf(data);

                  return EraMenuItem(
                    data: data,
                    selected: index == _selectedIndex,
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  );
                }).toList(),
                const SizedBox(height: 18),
                const Placeholder(fallbackHeight: 50, fallbackWidth: 250),
              ],
            ),
            const Column(
              children: [
                Placeholder(fallbackHeight: 70, fallbackWidth: 250),
                SizedBox(height: 20),
                Placeholder(fallbackHeight: 70, fallbackWidth: 250),
              ],
            )
          ],
        ),
      ),
    );
  }
}
