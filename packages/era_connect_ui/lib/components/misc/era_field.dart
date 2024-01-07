import 'package:era_connect_ui/theme/lib.dart';
import 'package:flutter/material.dart';

import 'era_icon.dart';
import 'era_tooltip.dart';

class EraField extends StatelessWidget {
  final String title;
  final String? tooltip;
  final Widget child;

  const EraField(
      {super.key, required this.title, this.tooltip, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, color: context.theme.textColor),
            ),
            const SizedBox(width: 5),
            if (tooltip != null)
              EraTooltip(
                message: tooltip!,
                child: EraIcon.material(Icons.info_rounded,
                    size: 18, color: context.theme.tertiaryTextColor),
              )
          ],
        ),
        const SizedBox(height: 10),
        child
      ],
    );
  }
}
