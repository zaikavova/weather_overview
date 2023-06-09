import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/data/index.dart';

import 'index.dart';

part 'environment_status_dto.freezed.dart';

part 'environment_status_dto.g.dart';

@freezed
@EnvironmentStatusDtoFromJsonConverter()
class EnvironmentStatusDto with _$EnvironmentStatusDto {
  @HiveType(
    typeId: HiveIdConstants.environmentStatusId,
    adapterName: 'EnvironmentStatusDtoAdapter',
  )
  factory EnvironmentStatusDto({
    @HiveField(1) required WeatherDto weather,
    @HiveField(2) required LocationDto location,
    @HiveField(3) required AirConditionDto airCondition,
  }) = _EnvironmentStatusDto;

  factory EnvironmentStatusDto.fromJson(Map<String, Object?> json) =>
      EnvironmentStatusDtoFromJsonConverter().fromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      EnvironmentStatusDtoFromJsonConverter().toJson(this);
}
