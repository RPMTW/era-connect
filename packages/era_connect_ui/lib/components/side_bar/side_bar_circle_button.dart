import 'package:era_connect_ui/components/lib.dart';
import 'package:era_connect_ui/theme/lib.dart';
import 'package:flutter/material.dart';

class SideBarCircleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final EraIcon icon;
  final OutlinedBorder shape;
  final String tooltip;
  final bool isSelected;

  const SideBarCircleButton._(
      {required this.onPressed,
      required this.icon,
      required this.shape,
      required this.tooltip,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return EraTooltip(
      message: tooltip,
      child: IconButton(
          onPressed: onPressed,
          icon: IconTheme(data: const IconThemeData(size: 25), child: icon),
          style: IconButton.styleFrom(
            shape: shape,
            backgroundColor: isSelected
                ? context.theme.accentColor
                : context.theme.surfaceColor,
            padding: const EdgeInsets.all(15),
          )),
    );
  }

  factory SideBarCircleButton.icon(
      {required VoidCallback onPressed,
      required EraIcon icon,
      required String tooltip,
      bool isSelected = false}) {
    return SideBarCircleButton._(
        onPressed: onPressed,
        icon: icon,
        shape: const CircleBorder(),
        tooltip: tooltip,
        isSelected: isSelected);
  }

  factory SideBarCircleButton.roundedSquare(
      {required VoidCallback onPressed,
      required EraIcon icon,
      required String tooltip}) {
    return SideBarCircleButton._(
        onPressed: onPressed,
        icon: icon,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        tooltip: tooltip,
        isSelected: false);
  }
}
