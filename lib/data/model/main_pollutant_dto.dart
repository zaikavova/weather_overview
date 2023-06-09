import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_overview/data/model/hive_id_constants.dart';

part 'main_pollutant_dto.g.dart';

@HiveType(
    typeId: HiveIdConstants.mainPollutantDtoId,
    adapterName: 'MainPollutantDtoAdapter')
enum MainPollutantDto {
  @HiveField(0)
  @JsonValue('p2')
  Particles25, //  pm2.5
  @HiveField(1)
  @JsonValue('p1')
  Particles100, // pm10
  @HiveField(2)
  @JsonValue('03')
  Ozone, // Ozone O3
  @HiveField(3)
  @JsonValue('n2')
  NitrogenDioxide, //  Nitrogen dioxide NO2
  @HiveField(4)
  @JsonValue('s2')
  SulfurDioxide, //  Sulfur dioxide SO2
  @HiveField(5)
  @JsonValue('c0')
  CarbonMonoxide, // Carbon monoxide
}
