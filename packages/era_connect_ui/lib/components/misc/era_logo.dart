import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EraLogo extends StatelessWidget {
  final double? size;
  const EraLogo({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'icons/era_connect_logo.svg',
      package: 'era_connect_ui',
      height: size,
      width: size,
    );
  }
}
