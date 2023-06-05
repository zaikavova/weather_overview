import 'package:weather_overview/domain/index.dart';

class AirConditionPM {
  AirConditionPM(this.airQualityIndex, this.mainPollutant);

  final int airQualityIndex;
  final MainPollutant mainPollutant;
}
