import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';
import 'ffi.dart' if (dart.library.html) 'ffi_web.dart' show api;
import 'pages/main_page.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  const windowOptions = WindowOptions(
    size: Size(1600, 900),
    minimumSize: Size(1280, 720),
    // titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const EraConnectApp());

  testRust();
}

void testRust() async {
  final stream = api.test();

  stream.listen((event) {
    print(event.speed);
  });
}

class EraConnectApp extends StatelessWidget {
  const EraConnectApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Era Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'GenSenRounded',
          fontFamilyFallback: const ['GenSenRounded'],
          brightness: Brightness.dark,
          useMaterial3: true),
      builder: (context, child) {
        ErrorWidget.builder = (FlutterErrorDetails details) {
          return const Center(
            child: Text('Error'),
          );
        };

        return child!;
      },
      home: ThemeProvider(
          getDefaultTheme: () => EraThemeData.dark(fontFamily: 'GenSenRounded'),
          builder: (context, theme) {
            return const Material(
              child: MainPage(),
            );
          }),
    );
  }
}
