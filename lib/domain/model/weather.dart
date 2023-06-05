import 'index.dart';

class Weather {
  Weather({
    required this.temperatureCelsius,
    required this.atmosphericPressureHPA,
    required this.humidityPercent,
    required this.windSpeed,
    required this.windDirection,
    required this.weatherIcon,
  })  : assert(humidityPercent >= 0 && humidityPercent <= 100,
            'Humidity out of range 0-100'),
        assert(windDirection >= 0 && windDirection <= 360,
            'Wind direction is out of range 0-360');


  final int temperatureCelsius;
  final int atmosphericPressureHPA;
  final int humidityPercent;
  final double windSpeed;
  final int windDirection;
  final WeatherVisualIndicator weatherIcon;
}
