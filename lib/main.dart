import 'package:easy_budget/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_budget/l10n/l10n.dart';

import 'src/controller/routes_controller.dart';

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
        routerConfig: router,
        theme: FlexThemeData.light(scheme: FlexScheme.green),
        darkTheme: FlexThemeData.dark(scheme: FlexScheme.green),
        themeMode: ThemeMode.system,
        supportedLocales: L10n.all,
        locale: const Locale('pt'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    ),
  );
}
