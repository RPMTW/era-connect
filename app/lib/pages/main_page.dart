import 'package:flutter/material.dart';
import 'package:era_connect_ui/era_connect_ui.dart'
    show EraMenuBar, EraMenuItemData;
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildMainMenuBar(),
        const Expanded(child: Placeholder()),
      ],
    );
  }

  Widget _buildMainMenuBar() {
    return EraMenuBar(
      items: [
        EraMenuItemData(
          icon: SvgPicture.asset(
            'assets/icons/assistant_navigation_outline.svg',
          ),
          selectedIcon: const Icon(Icons.assistant_navigation),
          title: '首頁',
          subtitle: '快速載入你的常用項目',
        ),
        EraMenuItemData(
          icon: SvgPicture.asset('assets/icons/error_med_outline.svg'),
          selectedIcon: SvgPicture.asset('assets/icons/error_med_round.svg'),
          title: '探索',
          subtitle: '探索你的下一個世界',
        ),
        EraMenuItemData(
          icon: SvgPicture.asset('assets/icons/amp_stories_outline.svg'),
          selectedIcon: SvgPicture.asset('assets/icons/amp_stories_round.svg'),
          title: '媒體庫',
          subtitle: '管理所有收藏',
        ),
        EraMenuItemData(
          icon: SvgPicture.asset('assets/icons/curtains_outline.svg'),
          selectedIcon: SvgPicture.asset('assets/icons/curtains_round.svg'),
          title: '多人遊戲',
          subtitle: '與其他玩家展開冒險',
        )
      ],
    );
  }
}
