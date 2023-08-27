import 'package:era_connect_ui/theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EraIcon extends StatelessWidget {
  final Function(BuildContext context, double? size, Color color) builder;
  final double? size;
  final Color? color;

  const EraIcon._(
      {required this.builder, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    final iconSize = size ?? IconTheme.of(context).size;
    final iconColor = color ?? context.theme.textColor;

    return builder(context, iconSize, iconColor);
  }

  factory EraIcon.assets(String name, {double? size, Color? color}) {
    return EraIcon._(
      builder: (context, size, color) {
        return SvgPicture.asset(
          'icons/$name.svg',
          width: size,
          height: size,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          package: 'era_connect_ui',
        );
      },
      size: size,
      color: color,
    );
  }

  factory EraIcon.material(IconData data, {double? size, Color? color}) {
    return EraIcon._(
      builder: (context, size, color) {
        return Icon(data, size: size, color: color);
      },
      size: size,
      color: color,
    );
  }
}
