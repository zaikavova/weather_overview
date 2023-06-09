import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/domain/index.dart';
import 'package:weather_overview/presentation/index.dart';

class AirConditionPMFactory implements Factory<AirCondition, AirConditionPM> {
  @override
  AirConditionPM create(AirCondition airCondition) {
    return AirConditionPM(
      airCondition.airQualityIndex,
      airCondition.mainPollutant,
    );
  }
}
