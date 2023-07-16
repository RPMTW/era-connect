import 'package:era_connect_i18n/era_connect_i18n.dart';
import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'ffi.dart' show PrepareGameArgs, api;
import 'pages/main_page.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  const windowOptions = WindowOptions(
      size: Size(1600, 900),
      minimumSize: Size(1280, 820),
      titleBarStyle: TitleBarStyle.hidden,
      windowButtonVisibility: false);
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setMinimumSize(const Size(1280, 820));
  });

  runApp(const EraConnectApp());

  testRust();
}

void testRust() async {
  final stream = api.test();

  stream.listen((event) {
    print(event.progress?.speed);
    if (event.prepareNameArgs != null) {
      var launchArgs = event.prepareNameArgs!.launchArgs;
      var jvmArgs = event.prepareNameArgs!.jvmArgs;
      var gameArgs = event.prepareNameArgs!.gameArgs;
      var c = PrepareGameArgs(
          launchArgs: launchArgs, jvmArgs: jvmArgs, gameArgs: gameArgs);
      final t = api.launchQuilt(quiltPrepare: c);
      t.listen((ttt) {
        print(ttt.progress?.speed);
      });
    }
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
      home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => ThemeChangeNotifier(
                () => EraThemeData.dark(fontFamily: 'GenSenRounded'),
              ),
            ),
            ChangeNotifierProvider(
              create: (_) => I18nManager(
                  path: 'assets/i18n',
                  defaultLocale: I18nLocale.traditionalChineseTW),
            )
          ],
          builder: (context, _) {
            return Material(
              child: FutureBuilder(
                  future: context.i18n.load(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return Column(
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
                    );
                  }),
            );
          }),
    );
  }
}
