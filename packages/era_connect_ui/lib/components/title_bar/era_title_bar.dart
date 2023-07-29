import 'dart:io';

import 'package:era_connect_ui/theme/lib.dart';
import 'package:era_connect_ui/components/misc/lib.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'era_title_bar_action.dart';

class EraTitleBar extends StatefulWidget {
  const EraTitleBar({super.key});

  @override
  State<EraTitleBar> createState() => _EraTitleBarState();
}

class _EraTitleBarState extends State<EraTitleBar> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _showOverlay(context);
      }
    });
  }

  /// Show the title bar overlay on top of the app and insert the drag to resize area.
  void _showOverlay(BuildContext context) {
    OverlayEntry titleBar = OverlayEntry(
      builder: (context) => const Positioned(top: 0, child: _TitleBar()),
    );

    OverlayEntry resizeArea = OverlayEntry(
      builder: (context) => DragToResizeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );

    Overlay.of(context).insert(titleBar);
    Overlay.of(context).insert(resizeArea);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: context.theme.deepBackgroundColor,
        width: MediaQuery.of(context).size.width,
        height: 50);
  }
}

class _TitleBar extends StatelessWidget {
  const _TitleBar();

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: Material(
        child: Container(
          color: context.theme.deepBackgroundColor,
          width: MediaQuery.of(context).size.width,
          height: 50,
          padding: const EdgeInsets.only(left: 20, right: 8, top: 5, bottom: 5),
          child: Builder(builder: (context) {
            if (Platform.isMacOS) {
              return Center(child: _buildTitle(MainAxisAlignment.center));
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_buildTitle(MainAxisAlignment.start), _buildActions()],
            );
          }),
        ),
      ),
    );
  }

  Row _buildTitle(MainAxisAlignment mainAxisAlignment) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: const [
        EraLogo(size: 16),
        SizedBox(width: 10),
        EraBrandText(fontSize: 28)
      ],
    );
  }

  Wrap _buildActions() {
    return Wrap(spacing: 5, children: [
      EraTitleBarAction.minimize(),
      EraTitleBarAction.maximize(),
      EraTitleBarAction.close()
    ]);
  }
}
