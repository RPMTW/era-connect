import 'package:era_connect_ui/components/lib.dart';
import 'package:flutter/widgets.dart';

class EraLogo extends StatelessWidget {
  final double? size;
  const EraLogo({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return EraIcon.assets('era_connect_logo', size: size);
  }
}
