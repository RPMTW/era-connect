import 'package:era_connect_ui/components/lib.dart';
import 'package:era_connect_ui/theme/lib.dart';
import 'package:flutter/material.dart';

class EraSideBar extends StatelessWidget {
  final Widget topItems;
  final List<Widget> menuItems;
  final List<Widget> collectionItems;
  final List<Widget> bottomItems;

  const EraSideBar(
      {super.key,
      required this.topItems,
      required this.menuItems,
      required this.collectionItems,
      required this.bottomItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.deepBackgroundColor,
      constraints: const BoxConstraints(maxWidth: 90),
      padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildItems(),
      ),
    );
  }

  List<Widget> _buildItems() {
    return [
      Column(
        children: [
          const SizedBox(height: 10),
          topItems,
          const SizedBox(height: 15),
          const EraDivider(),
          const SizedBox(height: 15),
          Wrap(
            runSpacing: 10,
            children: menuItems,
          ),
          const SizedBox(height: 15),
          const EraDivider(),
          const SizedBox(height: 15),
          Wrap(
            runSpacing: 10,
            children: collectionItems,
          ),
        ],
      ),
      Wrap(
        runSpacing: 15,
        children: bottomItems,
      )
    ];
  }
}
