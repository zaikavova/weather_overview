import 'package:flutter/material.dart';
import 'package:weather_overview/weather_overview_application.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  di.init();

  runApp(const WeatherOverviewApp());
}
