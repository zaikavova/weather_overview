import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_overview/data/model/hive_id_constants.dart';

part 'gps_location_dto.freezed.dart';

part 'gps_location_dto.g.dart';

@freezed
class GPSLocationDto with _$GPSLocationDto {
  @HiveType(typeId: HiveIdConstants.gpsLocationDtoId, adapterName: 'GPSLocationDtoAdapter')
  factory GPSLocationDto({
    @HiveField(0) required double latitude,
    @HiveField(1) required double longitude,
  }) = _GPSLocationDto;


  factory GPSLocationDto.fromJson(Map<String, Object?> json) =>
      _$GPSLocationDtoFromJson(json);
}
