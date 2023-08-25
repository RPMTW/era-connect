import 'package:flutter/material.dart';

class EraBasicButton extends StatefulWidget {
  final Widget child;
  final EraBasicButtonStyle style;
  final VoidCallback onPressed;

  const EraBasicButton(
      {super.key,
      required this.child,
      required this.style,
      required this.onPressed});

  @override
  State<EraBasicButton> createState() => _EraBasicButtonState();
}

class _EraBasicButtonState extends State<EraBasicButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color:
            isHovered ? widget.style.hoverColor : widget.style.backgroundColor,
        borderRadius: BorderRadius.circular(widget.style.borderRadius),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onHover: (value) => setState(() => isHovered = value),
          borderRadius: BorderRadius.circular(widget.style.borderRadius),
          onTap: widget.onPressed,
          child: widget.child,
        ),
      ),
    );
  }
}

class EraBasicButtonStyle {
  final Color backgroundColor;
  final Color hoverColor;
  final double borderRadius;

  const EraBasicButtonStyle(
      {required this.backgroundColor,
      required this.hoverColor,
      required this.borderRadius});
}
