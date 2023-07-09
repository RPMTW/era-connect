import 'package:flutter/material.dart';
import 'package:era_connect_ui/era_connect_ui.dart'
    show EraMenuBar, EraMenuItemData;
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:era_connect_i18n/era_connect_i18n.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildMainMenuBar(context),
        const Expanded(child: Placeholder()),
      ],
    );
  }

  Widget _buildMainMenuBar(BuildContext context) {
    return EraMenuBar(
      items: [
        EraMenuItemData(
          icon: SvgPicture.asset(
            'assets/icons/assistant_navigation_outline.svg',
          ),
          selectedIcon: const Icon(Icons.assistant_navigation),
          title: context.i18n['main_page.menu_bar.home.title'],
          subtitle: context.i18n['main_page.menu_bar.home.subtitle'],
        ),
        EraMenuItemData(
          icon: SvgPicture.asset('assets/icons/error_med_outline.svg'),
          selectedIcon: SvgPicture.asset('assets/icons/error_med_round.svg'),
          title: context.i18n['main_page.menu_bar.explore.title'],
          subtitle: context.i18n['main_page.menu_bar.explore.subtitle'],
        ),
        EraMenuItemData(
          icon: SvgPicture.asset('assets/icons/amp_stories_outline.svg'),
          selectedIcon: SvgPicture.asset('assets/icons/amp_stories_round.svg'),
          title: context.i18n['main_page.menu_bar.library.title'],
          subtitle: context.i18n['main_page.menu_bar.library.subtitle'],
        ),
        EraMenuItemData(
          icon: SvgPicture.asset('assets/icons/curtains_outline.svg'),
          selectedIcon: SvgPicture.asset('assets/icons/curtains_round.svg'),
          title: context.i18n['main_page.menu_bar.multiplayer.title'],
          subtitle: context.i18n['main_page.menu_bar.multiplayer.subtitle'],
        )
      ],
    );
  }
}
