import 'package:era_connect_ui/components/lib.dart';
import 'package:era_connect_ui/theme/lib.dart';
import 'package:flutter/material.dart';

class EraSideBar extends StatelessWidget {
  const EraSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.deepBackgroundColor,
      constraints: const BoxConstraints(maxWidth: 90),
      padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTopItems(),
          _buildBottomItems(),
        ],
      ),
    );
  }

  Wrap _buildBottomItems() {
    return Wrap(
      runSpacing: 15,
      children: [
        SideBarCircleButton.icon(
          onPressed: () {},
          icon: Icons.download_rounded,
        ),
        const EraDivider(),
        SideBarCircleButton.icon(
          onPressed: () {},
          icon: Icons.no_accounts_rounded,
        ),
      ],
    );
  }

  Column _buildTopItems() {
    return Column(
      children: [
        SideBarCircleButton.icon(
          onPressed: () {},
          icon: Icons.mark_chat_unread_rounded,
        ),
        const SizedBox(height: 15),
        const EraDivider(),
        const SizedBox(height: 15),
        Wrap(
          runSpacing: 10,
          children: [
            SideBarCircleButton.icon(
              onPressed: () {},
              icon: Icons.home_rounded,
            ),
            SideBarCircleButton.icon(
              onPressed: () {},
              icon: Icons.grid_view_rounded,
              isSelected: true,
            ),
            SideBarCircleButton.icon(
              onPressed: () {},
              icon: Icons.wifi_tethering_rounded,
            ),
          ],
        ),
        const SizedBox(height: 15),
        const EraDivider(),
        const SizedBox(height: 15),
        Wrap(
          runSpacing: 10,
          children: [
            SideBarCircleButton.squircle(
              onPressed: () {},
              icon: Icons.add_rounded,
            ),
            SideBarCircleButton.squircle(
              onPressed: () {},
              icon: Icons.explore_rounded,
            ),
          ],
        ),
      ],
    );
  }
}
