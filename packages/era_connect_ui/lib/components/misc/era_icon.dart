import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EraIcon extends StatelessWidget {
  final String name;
  final double? size;

  const EraIcon({super.key, required this.name, this.size});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('icons/$name.svg',
        width: size, height: size, package: 'era_connect_ui');
  }
}
