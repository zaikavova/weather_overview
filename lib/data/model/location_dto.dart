import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/data/index.dart';

part 'location_dto.freezed.dart';

part 'location_dto.g.dart';

@freezed
class LocationDto with _$LocationDto {
  @HiveType(
    typeId: HiveIdConstants.locationDtoId,
    adapterName: 'LocationDtoAdapter',
  )
  factory LocationDto({
    @HiveField(0) required String city,
    @HiveField(1) required String state,
    @HiveField(2) required String country,
    @HiveField(3) @GpsLocationDtoFromJsonConverter() GPSLocationDto? location,
  }) = _LocationDto;

  factory LocationDto.fromJson(Map<String, Object?> json) =>
      _$LocationDtoFromJson(json);

  @override
  bool operator ==(Object other) {
    final otherLocation = other as LocationDto;
    return this.city == otherLocation.city &&
            this.location == otherLocation.location &&
            this.country == otherLocation.country ||
        this.location == otherLocation.location;
  }
}
