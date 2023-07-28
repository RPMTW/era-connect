import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';

class EraDivider extends StatelessWidget {
  const EraDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Divider(
        color: context.theme.surfaceColor,
        thickness: 3.5,
      ),
    );
  }
}
