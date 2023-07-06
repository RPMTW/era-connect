import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
// import 'ffi.dart' if (dart.library.html) 'ffi_web.dart' show api;
import 'pages/main_page.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  const windowOptions = WindowOptions(
    size: Size(1600, 900),
    minimumSize: Size(1280, 820),
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setMinimumSize(const Size(1280, 820));
  });

  runApp(const EraConnectApp());
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
      home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => ThemeChangeNotifier(
                () => EraThemeData.dark(fontFamily: 'GenSenRounded'),
              ),
            )
          ],
          builder: (context, _) {
            return Material(
              child: Column(
                children: [
                  EraTitleBar(
                    logo: SvgPicture.asset(
                      'assets/era_connect_logo.svg',
                      height: 17,
                      width: 16,
                    ),
                  ),
                  const Expanded(child: MainPage()),
                ],
              ),
            );
          }),
    );
  }
}
