import 'dart:async';

import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/domain/index.dart';
import 'package:weather_overview/presentation/index.dart';

class WeatherPMFactory implements Factory<Weather, WeatherPM> {
  @override
  FutureOr<WeatherPM> create(Weather weather) {
    return WeatherPM(
      temperatureCelsius: weather.temperatureCelsius,
      atmosphericPressureHPA: weather.atmosphericPressureHPA,
      humidityPercent: weather.humidityPercent,
      windSpeed: weather.windSpeed,
      windDirection: weather.windDirection,
      weatherIcon: weather.weatherIcon,
    );
  }
}
