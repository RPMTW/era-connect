import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:window_manager/window_manager.dart';

class EraTitleBarAction {
  static Widget minimize() {
    return IconButton(
      icon:
          SvgPicture.asset('icons/drag_handle.svg', package: 'era_connect_ui'),
      onPressed: () {
        windowManager.minimize();
      },
    );
  }

  static Widget maximize() {
    return IconButton(
        icon: SvgPicture.asset('icons/thumbnail_bar.svg',
            package: 'era_connect_ui'),
        onPressed: () async {
          final isMaximized = await windowManager.isMaximized();

          if (isMaximized) {
            await windowManager.unmaximize();
          } else {
            await windowManager.maximize();
          }
        });
  }

  static Widget close() {
    return IconButton(
      icon: SvgPicture.asset('icons/close.svg', package: 'era_connect_ui'),
      hoverColor: const Color(0xffff0000),
      onPressed: () {
        windowManager.close();
      },
    );
  }
}
