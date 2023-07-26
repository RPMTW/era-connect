import 'package:era_connect_i18n/era_connect_i18n.dart';
import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        EraSideBar(
          topItems: SideBarCircleButton.icon(
            onPressed: () {},
            icon: Icons.mark_chat_unread_rounded,
            tooltip: context.i18n['main_page.side_bar.universe_chat'],
          ),
          menuItems: [
            SideBarCircleButton.icon(
              onPressed: () {},
              icon: Icons.home_rounded,
              tooltip: context.i18n['main_page.side_bar.home'],
            ),
            SideBarCircleButton.icon(
              onPressed: () {},
              icon: Icons.grid_view_rounded,
              tooltip: context.i18n['main_page.side_bar.library'],
              isSelected: true,
            ),
            SideBarCircleButton.icon(
              onPressed: () {},
              icon: Icons.wifi_tethering_rounded,
              tooltip: context.i18n['main_page.side_bar.multiplayer'],
            ),
          ],
          collectionItems: [
            SideBarCircleButton.squircle(
              onPressed: () {},
              icon: Icons.add_rounded,
              tooltip: context.i18n['main_page.side_bar.create_collection'],
            ),
            SideBarCircleButton.squircle(
              onPressed: () {},
              icon: Icons.explore_rounded,
              tooltip: context.i18n['main_page.side_bar.explore'],
            ),
          ],
          bottomItems: [
            SideBarCircleButton.icon(
              onPressed: () {},
              icon: Icons.download_rounded,
              tooltip: context.i18n['main_page.side_bar.manage_downloads'],
            ),
            const EraDivider(),
            SideBarCircleButton.icon(
              onPressed: () {},
              icon: Icons.no_accounts_rounded,
              tooltip: context.i18n['main_page.side_bar.manage_accounts'],
            ),
          ],
        ),
        const Expanded(child: Placeholder()),
      ],
    );
  }
}
