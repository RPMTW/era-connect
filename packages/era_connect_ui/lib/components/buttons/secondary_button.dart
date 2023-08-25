import 'package:era_connect_ui/theme/lib.dart';
import 'package:flutter/widgets.dart';

import 'era_basic_button.dart';

class EraSecondaryButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double borderRadius;
  final Color hoverColor;

  const EraSecondaryButton({
    super.key,
    required this.child,
    required this.borderRadius,
    required this.onPressed,
    required this.hoverColor,
  });

  @override
  Widget build(BuildContext context) {
    return EraBasicButton(
      style: EraBasicButtonStyle(
          backgroundColor: context.theme.backgroundColor,
          hoverColor: hoverColor,
          borderRadius: borderRadius),
      onPressed: onPressed,
      child: child,
    );
  }

  static Widget text({required String text, required VoidCallback onPressed}) {
    return Builder(
      builder: (context) {
        return EraSecondaryButton(
          borderRadius: 10,
          hoverColor: context.theme.surfaceColor,
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Text(
              text,
              style: TextStyle(color: context.theme.textColor, fontSize: 18),
            ),
          ),
        );
      },
    );
  }

  static Widget icon(
      {required Widget icon,
      required VoidCallback onPressed,
      bool isWide = false}) {
    return Builder(
      builder: (context) {
        return EraSecondaryButton(
          borderRadius: 50,
          hoverColor: context.theme.secondarySurfaceColor,
          onPressed: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isWide ? 50 : 30, vertical: 12),
            child: icon,
          ),
        );
      },
    );
  }
}
