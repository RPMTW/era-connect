import 'package:era_connect_ui/theme/lib.dart';
import 'package:flutter/widgets.dart';

import 'era_basic_button.dart';

class EraPrimaryButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double borderRadius;

  const EraPrimaryButton({
    super.key,
    required this.child,
    required this.borderRadius,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return EraBasicButton(
      style: EraBasicButtonStyle(
          backgroundColor: context.theme.surfaceColor,
          hoverColor: context.theme.accentColor,
          borderRadius: borderRadius),
      onPressed: onPressed,
      child: child,
    );
  }

  factory EraPrimaryButton.text(
      {required String text, required VoidCallback onPressed}) {
    final child = Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
          child: Text(
            text,
            style: TextStyle(color: context.theme.textColor, fontSize: 18),
          ),
        );
      },
    );

    return EraPrimaryButton(
      borderRadius: 10,
      onPressed: onPressed,
      child: child,
    );
  }

  factory EraPrimaryButton.icon(
      {required Widget icon, required VoidCallback onPressed}) {
    return EraPrimaryButton(
      borderRadius: 50,
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
        child: icon,
      ),
    );
  }
}
