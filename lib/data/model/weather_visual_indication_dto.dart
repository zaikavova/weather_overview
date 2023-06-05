import 'package:json_annotation/json_annotation.dart';

enum WeatherVisualIndicatorDto {
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
  @JsonValue('04n')
  brokenClouds,
  @JsonValue('09d')
  showerRain,
  @JsonValue('10n')
  rainDay,
  @JsonValue('10d')
  rainNight,
  @JsonValue('11d')
  thunderstorm,
}