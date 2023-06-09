import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_overview/data/index.dart';

part 'weather_dto.freezed.dart';

part 'weather_dto.g.dart';

@freezed
class WeatherDto with _$WeatherDto {
  @HiveType(
      typeId: HiveIdConstants.weatherDtoId, adapterName: 'WeatherDtoAdapter')
  factory WeatherDto({
    @HiveField(0) @JsonKey(name: 'ts') required String timeStamp,
    @HiveField(1) @JsonKey(name: 'tp') required int temperature,
    @HiveField(2) @JsonKey(name: 'pr') required int pressure,
    @HiveField(3) @JsonKey(name: 'hu') required int humidity,
    @HiveField(4) @JsonKey(name: 'ws') required double windSpeed,
    @HiveField(5) @JsonKey(name: 'wd') required double windDirection,
    @HiveField(6)
    @JsonKey(name: 'ic')
    required WeatherVisualIndicatorDto weatherIconCode,
  }) = _WeatherDto;

  factory WeatherDto.fromJson(Map<String, Object?> json) =>
      _$WeatherDtoFromJson(json);
}
