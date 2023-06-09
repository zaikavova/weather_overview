import 'package:json_annotation/json_annotation.dart';

enum WeatherVisualIndicator {
  @JsonValue('01d')
  clearSkyDay,
  @JsonValue('01n')
  clearSkyNight,
  @JsonValue('02d')
  fewCloudsDay,
  @JsonValue('02n')
  fewCloudsNight,
  @JsonValue('03n')
  scatteredClouds,
  @JsonValue('04d')
  brokenClouds,
  @JsonValue('09d')
  showerRain,
  @JsonValue('10n')
  rainDay,
  @JsonValue('10d')
  rainNight,
  @JsonValue('11d')
  thunderstorm,
  @JsonValue('13d')
  snow,
  @JsonValue('50d')
  mist,
}
