import 'package:era_connect_i18n/era_connect_i18n.dart';
import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        showEraDialog(
          context: context,
          barrierDismissible: true,
          dialog: const InteractiveDialog(
            title: '歡迎使用',
            description:
                '歡迎你來到 Era Connect！\n開始使用啟動器之前，讓我們協助你進行快速設定，就可以盡情地暢玩遊戲啦。',
            logoBoxText: '01',
            child: Placeholder(),
          ),
        );
      }
    });
  }

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
            SideBarCircleButton.roundedSquare(
              onPressed: () {},
              icon: Icons.add_rounded,
              tooltip: context.i18n['main_page.side_bar.create_collection'],
            ),
            SideBarCircleButton.roundedSquare(
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
