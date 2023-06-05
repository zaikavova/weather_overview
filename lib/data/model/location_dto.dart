import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_dto.freezed.dart';
part 'location_dto.g.dart';

@freezed
class LocationDto with _$LocationDto {
  factory LocationDto({
    required String city,
    required String state,
    required String country,
    required String location,
  }) = _LocationDto;

  factory LocationDto.fromJson(Map<String, Object?> json) =>
      _$LocationDtoFromJson(json);
}
