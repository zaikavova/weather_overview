import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather_overview/routing/index.dart';

import 'generated/l10n.dart';
import 'injection_container.dart' as di;

class WeatherOverviewApp extends StatefulWidget {
  const WeatherOverviewApp({super.key});

  @override
  State<WeatherOverviewApp> createState() => _WeatherOverviewAppState();
}

class _WeatherOverviewAppState extends State<WeatherOverviewApp> {
  late final RootStackRouter router;

  @override
  void initState() {
    super.initState();
    router = di.sl<RootStackRouter>();
    router.push(MainRoute());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      supportedLocales: [
        Locale.fromSubtags(languageCode: 'en'),
        Locale.fromSubtags(languageCode: 'uk', countryCode: 'UA'),
      ],
      theme: ThemeData(fontFamily: 'Quicksand'),
      routerDelegate: router.delegate(),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
