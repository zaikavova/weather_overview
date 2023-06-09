import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/data/index.dart';
import 'package:weather_overview/domain/index.dart';

class EnvironmentStatusFromDtoFactory
    implements Factory<EnvironmentStatusDto, EnvironmentStatus> {
  EnvironmentStatusFromDtoFactory(
    this._weatherFactory,
    this._locationFactory,
    this._airConditionFactory,
  );

  final Factory<WeatherDto, Weather> _weatherFactory;
  final Factory<LocationDto, Location> _locationFactory;
  final Factory<AirConditionDto, AirCondition> _airConditionFactory;

  @override
  EnvironmentStatus create(EnvironmentStatusDto args) {
    return EnvironmentStatus(
      DateTime.parse(args.weather.timeStamp),
      _weatherFactory.create(args.weather),
      _locationFactory.create(args.location),
      _airConditionFactory.create(args.airCondition),
    );
  }
}
