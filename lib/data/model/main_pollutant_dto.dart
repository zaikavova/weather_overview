import 'package:json_annotation/json_annotation.dart';

enum MainPollutantDto {
  @JsonValue('p2')
  Particles25, //  pm2.5
  @JsonValue('p1')
  Particles100, // pm10
  @JsonValue('03')
  Ozone, // Ozone O3
  @JsonValue('n2')
  NitrogenDioxide, //  Nitrogen dioxide NO2
  @JsonValue('s2')
  SulfurDioxide, //  Sulfur dioxide SO2
  @JsonValue('c0')
  CarbonMonoxide, // Carbon monoxide
}