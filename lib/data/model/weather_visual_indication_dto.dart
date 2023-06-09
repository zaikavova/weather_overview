import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_overview/data/model/hive_id_constants.dart';

part 'weather_visual_indication_dto.g.dart';

@HiveType(
    typeId: HiveIdConstants.weatherVisualIndicatorDtoId,
    adapterName: 'WeatherVisualIndicatorDtoAdapter')
enum WeatherVisualIndicatorDto {
  @HiveField(0)
  @JsonValue('01d')
  clearSkyDay,
  @HiveField(1)
  @JsonValue('01n')
  clearSkyNight,
  @HiveField(2)
  @JsonValue('02d')
  fewCloudsDay,
  @HiveField(3)
  @JsonValue('02n')
  fewCloudsNight,
  @HiveField(4)
  @JsonValue('03n')
  scatteredClouds,
  @HiveField(5)
  @JsonValue('04d')
  brokenClouds,
  @HiveField(6)
  @JsonValue('04n')
  brokenCloudsN,
  @HiveField(7)
  @JsonValue('09d')
  showerRain,
  @HiveField(8)
  @JsonValue('10n')
  rainDay,
  @HiveField(9)
  @JsonValue('10d')
  rainNight,
  @HiveField(10)
  @JsonValue('11d')
  thunderstorm,
  @HiveField(11)
  @JsonValue('13d')
  snow,
  @HiveField(12)
  @JsonValue('50d')
  mist,
}
