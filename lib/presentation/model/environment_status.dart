import 'package:weather_overview/presentation/index.dart';

class EnvironmentStatusPM {
  EnvironmentStatusPM({
    required this.timestamp,
    required this.weather,
    required this.location,
    required this.airCondition,
  });

  final DateTime timestamp;
  final WeatherPM weather;
  final LocationPM location;
  final AirConditionPM airCondition;
}
