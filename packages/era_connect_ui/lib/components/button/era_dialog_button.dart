import 'package:era_connect_ui/theme/lib.dart';
import 'package:flutter/material.dart';

class EraDialogButton extends StatefulWidget {
  final Widget? icon;
  final String? text;
  final Color backgroundColor;
  final Color hoverColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final VoidCallback onPressed;

  const EraDialogButton._(this.icon, this.text, this.backgroundColor,
      this.hoverColor, this.padding, this.borderRadius, this.onPressed)
      : assert(icon != null || text != null);

  @override
  State<EraDialogButton> createState() => _EraDialogButtonState();

  static Widget textPrimary(
      {required String text, required VoidCallback onPressed}) {
    return Builder(builder: (context) {
      return EraDialogButton._(
        null,
        text,
        context.theme.surfaceColor,
        context.theme.accentColor,
        const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
        10,
        onPressed,
      );
    });
  }

  static Widget textSecondary(
      {required String text, required VoidCallback onPressed}) {
    return Builder(builder: (context) {
      return EraDialogButton._(
        null,
        text,
        context.theme.backgroundColor,
        context.theme.surfaceColor,
        const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        10,
        onPressed,
      );
    });
  }

  static Widget iconPrimary(
      {required Widget icon, required VoidCallback onPressed}) {
    return Builder(builder: (context) {
      return EraDialogButton._(
        icon,
        null,
        context.theme.surfaceColor,
        context.theme.accentColor,
        const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
        50,
        onPressed,
      );
    });
  }

  static Widget iconSecondary(
      {required Widget icon,
      required VoidCallback onPressed,
      bool isWide = false}) {
    return Builder(builder: (context) {
      return EraDialogButton._(
        icon,
        null,
        context.theme.backgroundColor,
        context.theme.surfaceColor,
        EdgeInsets.symmetric(horizontal: isWide ? 50 : 30, vertical: 12),
        50,
        onPressed,
      );
    });
  }
}

class _EraDialogButtonState extends State<EraDialogButton> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isHovered ? widget.hoverColor : widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onHover: (value) => setState(() => isHovered = value),
          borderRadius: BorderRadius.circular(widget.borderRadius),
          onTap: widget.onPressed,
          child: Padding(
            padding: widget.padding,
            child: Builder(builder: (context) {
              final text = widget.text;
              final icon = widget.icon;

              if (text != null) {
                return Text(
                  text,
                  style:
                      TextStyle(color: context.theme.textColor, fontSize: 18),
                );
              } else if (icon != null) {
                return icon;
              } else {
                return const SizedBox.shrink();
              }
            }),
          ),
        ),
      ),
    );
  }
}
