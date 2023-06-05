import 'package:weather_overview/domain/index.dart';

class AirCondition {
  AirCondition(this.airQualityIndex, this.mainPollutant)
      : assert(airQualityIndex >= SpecificationsConstants.AQIUSMinValue &&
            airQualityIndex <= SpecificationsConstants.AQIUSMaxValue);

  final int airQualityIndex; //0-300
  final MainPollutant mainPollutant;
}


