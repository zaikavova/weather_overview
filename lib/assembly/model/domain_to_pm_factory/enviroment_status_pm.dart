import 'dart:async';

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
  Future<EnvironmentStatusPM> create(
    EnvironmentStatus environmentStatus,
  ) async {
    return EnvironmentStatusPM(
      timestamp: environmentStatus.timestamp,
      weather: await weatherFactory.create(environmentStatus.weather),
      location: await locationFactory.create(environmentStatus.location),
      airCondition:
          await airConditionFactory.create(environmentStatus.airCondition),
    );
  }
}
