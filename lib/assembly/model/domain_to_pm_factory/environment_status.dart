import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/domain/index.dart';
import 'package:weather_overview/presentation/index.dart';

class EnvironmentStatusPMFactory
    implements Factory<EnvironmentStatus, EnvironmentStatusPM> {
  EnvironmentStatusPMFactory({
    required this.weatherFactory,
    required this.locationFactory,
    required this.airConditionFactory,
  });

  final Factory<Weather, WeatherPM> weatherFactory;
  final Factory<Location, LocationPM> locationFactory;
  final Factory<AirCondition, AirConditionPM> airConditionFactory;

  @override
  EnvironmentStatusPM create(
    EnvironmentStatus environmentStatus,
  ) {
    return EnvironmentStatusPM(
      timestamp: environmentStatus.timestamp,
      weather: weatherFactory.create(environmentStatus.weather),
      location: locationFactory.create(environmentStatus.location),
      airCondition: airConditionFactory.create(environmentStatus.airCondition),
    );
  }
}
