import 'package:flutter/material.dart';

class EraMenuAccount extends StatelessWidget {
  const EraMenuAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 50),
        child: const Text('某帳號'),
      ),
    );
  }
}
