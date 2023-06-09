import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_overview/data/index.dart';

part 'air_condition_dto.freezed.dart';

part 'air_condition_dto.g.dart';

@freezed
class AirConditionDto with _$AirConditionDto {
  @HiveType(
    typeId: HiveIdConstants.airConditionDtoId,
    adapterName: 'AirConditionDtoAdapter',
  )
  factory AirConditionDto({
    @HiveField(0) @JsonKey(name: 'ts') required String timestamp,
    @HiveField(1) @JsonKey(name: 'aqius') required int airQuality,
    @HiveField(2) @JsonKey(name: 'mainus') required MainPollutantDto main,
  }) = _AirConditionDto;

  factory AirConditionDto.fromJson(Map<String, Object?> json) =>
      _$AirConditionDtoFromJson(json);
}
