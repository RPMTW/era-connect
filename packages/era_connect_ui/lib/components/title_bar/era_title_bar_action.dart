import 'package:era_connect_ui/components/lib.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class EraTitleBarAction {
  static final _style = IconButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0),
    ),
  );

  static Widget minimize() {
    return IconButton(
      icon: const EraIcon(name: 'drag_handle', size: 20),
      style: _style,
      onPressed: () {
        windowManager.minimize();
      },
    );
  }

  static Widget maximize() {
    return IconButton(
        icon: const EraIcon(name: 'thumbnail_bar', size: 20),
        style: _style,
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
      icon: const EraIcon(name: 'close', size: 20),
      hoverColor: const Color(0xffff0000),
      style: _style,
      onPressed: () {
        windowManager.close();
      },
    );
  }
}
