import 'package:flutter/material.dart';
import 'ffi.dart' if (dart.library.html) 'ffi_web.dart' show api;

void main() {
  runApp(const EraConnectApp());
}

class EraConnectApp extends StatelessWidget {
  const EraConnectApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Era Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
      home: Material(
        child: Center(
            child: Text(api.helloWorld(),
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(color: Colors.white))),
      ),
    );
  }
}
