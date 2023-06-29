import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';
import 'ffi.dart' if (dart.library.html) 'ffi_web.dart' show api;
import 'pages/main_page.dart';

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
      home: ThemeProvider(
          getDefaultTheme: () => EraThemeData.dark(),
          builder: (context, theme) {
            return const Material(
              child: MainPage(),
            );
          }),
    );
  }
}
