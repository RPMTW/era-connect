import 'package:flutter/material.dart';
import 'package:era_connect_ui/era_connect_ui.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        EraMenuBar(),
        Expanded(child: Placeholder()),
      ],
    );
  }
}
