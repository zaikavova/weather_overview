import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/data/index.dart';
import 'package:weather_overview/domain/index.dart';

class WeatherVisualIndicatorFromDto
    implements Factory<WeatherVisualIndicatorDto, WeatherVisualIndicator> {
  @override
  WeatherVisualIndicator create(WeatherVisualIndicatorDto args) {
    switch (args) {
      case WeatherVisualIndicatorDto.clearSkyDay:
        return WeatherVisualIndicator.clearSkyDay;
      case WeatherVisualIndicatorDto.clearSkyNight:
        return WeatherVisualIndicator.clearSkyNight;
      case WeatherVisualIndicatorDto.fewCloudsDay:
        return WeatherVisualIndicator.fewCloudsDay;
      case WeatherVisualIndicatorDto.fewCloudsNight:
        return WeatherVisualIndicator.fewCloudsNight;
      case WeatherVisualIndicatorDto.scatteredClouds:
        return WeatherVisualIndicator.scatteredClouds;
      case WeatherVisualIndicatorDto.brokenClouds:
        return WeatherVisualIndicator.brokenClouds;
      case WeatherVisualIndicatorDto.brokenCloudsN:
        return WeatherVisualIndicator.brokenClouds;
      case WeatherVisualIndicatorDto.showerRain:
        return WeatherVisualIndicator.showerRain;
      case WeatherVisualIndicatorDto.rainDay:
        return WeatherVisualIndicator.rainDay;
      case WeatherVisualIndicatorDto.rainNight:
        return WeatherVisualIndicator.rainNight;
      case WeatherVisualIndicatorDto.thunderstorm:
        return WeatherVisualIndicator.thunderstorm;
      case WeatherVisualIndicatorDto.snow:
        return WeatherVisualIndicator.snow;
      case WeatherVisualIndicatorDto.mist:
        return WeatherVisualIndicator.mist;
    }
  }
}
