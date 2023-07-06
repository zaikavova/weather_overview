import 'package:weather_overview/domain/index.dart';
import 'package:weather_overview/generated/l10n.dart';

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

  String get localizedWindDirectionString {
    // Normalize azimuth to the range of 0 to 360 degrees
    final azimuth = windDirection;

    // Define the direction names and their corresponding ranges
    final directions = {
      S.current.directionNameN: [347.25, 11.25],
      S.current.directionNameNNE: [11.26, 33.75],
      S.current.directionNameNE: [33.76, 56.25],
      S.current.directionNameENE: [56.26, 78.75],
      S.current.directionNameE: [78.76, 101.25],
      S.current.directionNameESE: [101.26, 123.75],
      S.current.directionNameSE: [123.76, 146.25],
      S.current.directionNameSSE: [146.26, 168.75],
      S.current.directionNameS: [168.76, 191.25],
      S.current.directionNameSSW: [191.26, 213.75],
      S.current.directionNameSW: [213.76, 236.25],
      S.current.directionNameWSW: [236.26, 258.75],
      S.current.directionNameW: [258.76, 281.25],
      S.current.directionNameWNW: [281.26, 303.75],
      S.current.directionNameNW: [303.76, 326.25],
      S.current.directionNameNNW: [326.26, 348.75],
    };

    // Iterate over the directions and check if the azimuth falls within a range
    for (final entry in directions.entries) {
      final name = entry.key;
      final range = entry.value;
      if (azimuth >= range[0] && azimuth <= range[1]) {
        return name;
      }
    }

    // If the azimuth doesn't fall within any range, return 'N' as default
    return S.current.directionNameN;
  }
}
