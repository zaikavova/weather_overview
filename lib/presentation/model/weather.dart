import 'package:weather_overview/domain/model/image.dart';

class WeatherPM {
  WeatherPM({
    required this.temperatureCelsius,
    required this.atmosphericPressureHPA,
    required this.humidityPercent,
    required this.windSpeed,
    required this.windDirection,
    required this.weatherIcon,
  });

  final int temperatureCelsius;
  final int atmosphericPressureHPA;
  final int humidityPercent;
  final double windSpeed;
  final double windDirection;
  final WeatherVisualIndicator weatherIcon;
}
