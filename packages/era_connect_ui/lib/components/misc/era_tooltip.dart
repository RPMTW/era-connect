import 'package:era_connect_ui/theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class EraTooltip extends StatelessWidget {
  final String message;
  final Widget child;

  const EraTooltip({super.key, required this.message, required this.child});

  @override
  Widget build(BuildContext context) {
    final bool hasMultipleLines = message.contains('\n');

    return JustTheTooltip(
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        child: Text(
          message,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      offset: -7,
      preferredDirection: AxisDirection.right,
      borderRadius: BorderRadius.circular(hasMultipleLines ? 15 : 50),
      backgroundColor: context.theme.secondarySurfaceColor,
      child: child,
    );
  }
}
