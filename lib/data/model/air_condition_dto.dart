import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_overview/domain/index.dart';

part 'air_condition_dto.freezed.dart';
part 'air_condition_dto.g.dart';

@freezed
class AirConditionDto with _$AirConditionDto {
  factory AirConditionDto({
    @JsonKey(name: 'ts') required String timestamp,
    @JsonKey(name: 'aqiusaqius') required int airQuality,
    @JsonKey(name: 'mainus') required MainPollutant main,

  }) =
      _AirConditionDto;

 factory  AirConditionDto.fromJson(Map<String, Object?> json) =>
      _$AirConditionDtoFromJson(json);
}