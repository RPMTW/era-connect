import 'package:era_connect_ui/theme/lib.dart';
import 'package:flutter/material.dart';

class EraTextField extends StatelessWidget {
  final String? hintText;
  final String? initialValue;
  final ValueChanged<String?>? onChanged;

  const EraTextField(
      {super.key, this.hintText, this.initialValue, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: initialValue),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: context.theme.tertiaryTextColor,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        fillColor: context.theme.backgroundColor,
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        constraints: const BoxConstraints(
          maxHeight: 55,
        ),
      ),
      style: TextStyle(
        color: context.theme.textColor,
        fontSize: 15,
      ),
      onChanged: (value) {
        onChanged?.call(value);
      },
    );
  }
}
