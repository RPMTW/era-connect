import 'dart:io';

import 'package:era_connect_i18n/era_connect_i18n.dart';
import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
// import 'ffi.dart' show api;
import 'pages/main_page.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  final windowOptions = WindowOptions(
      size: const Size(1600, 900),
      minimumSize: const Size(1350, 820),
      titleBarStyle: TitleBarStyle.hidden,
      windowButtonVisibility: Platform.isMacOS ? true : false);
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setMinimumSize(const Size(1350, 820));

    runApp(const EraConnectApp());
  });
}

class EraConnectApp extends StatefulWidget {
  const EraConnectApp({Key? key}) : super(key: key);

  @override
  State<EraConnectApp> createState() => _EraConnectAppState();
}

class _EraConnectAppState extends State<EraConnectApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
          home: const _AppHome(),
        );
      },
    );
  }
}

class _AppHome extends StatefulWidget {
  const _AppHome();

  @override
  State<_AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<_AppHome> {
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      load();
    });
  }

  Future<void> load() async {
    if (mounted) {
      final i18n = context.i18n;
      i18n.setLocale(I18nLocale.getFromSystemLocale(
          WidgetsBinding.instance.platformDispatcher));
      await i18n.load(rootBundle);
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Builder(builder: (context) {
        if (!isLoaded) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return const Column(
          children: [
            EraTitleBar(),
            Expanded(child: MainPage()),
          ],
        );
      }),
    );
  }
}
