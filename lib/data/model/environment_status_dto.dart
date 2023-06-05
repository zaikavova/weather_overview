import 'package:freezed_annotation/freezed_annotation.dart';

import 'index.dart';

part 'environment_status_dto.freezed.dart';
part 'environment_status_dto.g.dart';

@freezed
class EnvironmentStatusDto with _$EnvironmentStatusDto {
  factory EnvironmentStatusDto({
    required String timestamp,
    required WeatherDto weather,
    required LocationDto location,
    required AirConditionDto airCondition,
  }) = _EnvironmentStatusDto;

  factory EnvironmentStatusDto.fromJson(Map<String, Object?> json) =>
      _$EnvironmentStatusDtoFromJson(json);
}
