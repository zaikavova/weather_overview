import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/data/index.dart';
import 'package:weather_overview/domain/index.dart';

class AirConditionFromDtoFactory
    implements Factory<AirConditionDto, AirCondition> {
  AirConditionFromDtoFactory(this._factory);

  final Factory<MainPollutantDto, MainPollutant> _factory;

  @override
  AirCondition create(AirConditionDto args) =>
      AirCondition(args.airQuality, _factory.create(args.main));
}
