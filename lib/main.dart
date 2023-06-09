import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_overview/logging_bloc_observer.dart';
import 'package:weather_overview/weather_overview_application.dart';

import 'injection_container.dart' as di;

Future<void> main() async {
  di.init();
  Bloc.observer = LoggingBlocObserver();
  runApp(const WeatherOverviewApp());
}
