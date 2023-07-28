import 'package:era_connect_ui/theme/lib.dart';
import 'package:flutter/material.dart';

class EraTextButton extends StatefulWidget {
  final String text;
  final Color backgroundColor;
  final Color hoverColor;
  final double horizontalPadding;
  final VoidCallback onPressed;

  const EraTextButton._(this.text, this.backgroundColor, this.hoverColor,
      this.horizontalPadding, this.onPressed);

  @override
  State<EraTextButton> createState() => _EraTextButtonState();

  static Widget primary(
      {required String text, required VoidCallback onPressed}) {
    return Builder(builder: (context) {
      return EraTextButton._(
        text,
        context.theme.surfaceColor,
        context.theme.accentColor,
        60,
        onPressed,
      );
    });
  }

  static Widget secondary(
      {required String text, required VoidCallback onPressed}) {
    return Builder(builder: (context) {
      return EraTextButton._(
        text,
        context.theme.backgroundColor,
        context.theme.surfaceColor,
        40,
        onPressed,
      );
    });
  }
}

class _EraTextButtonState extends State<EraTextButton> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isHovered ? widget.hoverColor : widget.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onHover: (value) => setState(() => isHovered = value),
          borderRadius: BorderRadius.circular(10),
          onTap: widget.onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: widget.horizontalPadding, vertical: 20),
            child: Text(
              widget.text,
              style: TextStyle(
                color: context.theme.textColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
