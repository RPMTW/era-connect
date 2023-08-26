import 'package:era_connect_ui/theme/lib.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EraIcon extends StatelessWidget {
  final Function(BuildContext context, double? size) builder;
  final double? size;

  const EraIcon._({required this.builder, this.size});

  @override
  Widget build(BuildContext context) {
    final iconSize = size ?? IconTheme.of(context).size;

    return builder(context, iconSize);
  }

  factory EraIcon.assets(String name, {double? size}) {
    return EraIcon._(
      builder: (context, size) {
        return SvgPicture.asset('icons/$name.svg',
            width: size, height: size, package: 'era_connect_ui');
      },
      size: size,
    );
  }

  factory EraIcon.material(IconData data, {double? size, Color? color}) {
    return EraIcon._(
      builder: (context, size) {
        return Icon(data, size: size, color: color ?? context.theme.textColor);
      },
      size: size,
    );
  }
}
