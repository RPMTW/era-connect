import 'package:flutter/widgets.dart';

class EraBrandText extends StatelessWidget {
  final double fontSize;
  final double? height;
  const EraBrandText({super.key, required this.fontSize, this.height});

  @override
  Widget build(BuildContext context) {
    return Text('Era Connect',
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            height: height,
            fontFamily: 'Geo',
            letterSpacing: -1.25));
  }
}
