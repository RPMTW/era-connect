import 'package:era_connect_ui/theme/lib.dart';
import 'package:flutter/material.dart';

Future<T?> showEraDialog<T>(
    {required BuildContext context,
    required Widget dialog,
    bool barrierDismissible = false}) {
  return showDialog<T>(
    context: context,
    barrierColor: context.theme.dialogBarrierColor,
    barrierDismissible: barrierDismissible,
    builder: (context) => dialog,
  );
}
