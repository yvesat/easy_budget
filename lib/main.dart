import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // await SentryFlutter.init(
  //   (options) {
  //     options.dsn = 'https://8ace65323c4342fe9c3d45acd7f5afaf@o4504764703244288.ingest.sentry.io/4504764716482560';
  //     options.tracesSampleRate = 1.0;
  //   },
  // );

  runApp(
    ProviderScope(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        // routerConfig: router,
        theme: FlexThemeData.light(scheme: FlexScheme.money),
        darkTheme: FlexThemeData.dark(scheme: FlexScheme.money),
        themeMode: ThemeMode.system,
      ),
    ),
  );
}
