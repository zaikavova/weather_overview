import 'package:weather_overview/domain/index.dart';

class EnvironmentStatus {
  EnvironmentStatus(
      this.timestamp, this.weather, this.location, this.airCondition,);

  final DateTime timestamp;
  final Weather weather;
  final Location location;
  final AirCondition airCondition;

  bool operator == (Object other)
  {
    if(other.runtimeType == EnvironmentStatus)
      {
        return location == (other as EnvironmentStatus).location;
      }
    else
    return false;
  }

}
