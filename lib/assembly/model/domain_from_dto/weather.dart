import 'package:weather_overview/assembly/factory.dart';
import 'package:weather_overview/data/index.dart';
import 'package:weather_overview/domain/index.dart';

class WeatherFromDtoFactory implements Factory<WeatherDto, Weather> {
  WeatherFromDtoFactory(this._factory);

  final Factory<WeatherVisualIndicatorDto, WeatherVisualIndicator> _factory;

  @override
  Weather create(WeatherDto args) => Weather(
        temperatureCelsius: args.temperature,
        atmosphericPressureHPA: args.pressure,
        humidityPercent: args.humidity,
        windSpeed: args.windSpeed,
        windDirection: args.windDirection,
        weatherIcon: _factory.create(args.weatherIconCode),
      );
}
