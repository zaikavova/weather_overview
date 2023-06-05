import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_dto.freezed.dart';
part 'weather_dto.g.dart';

@freezed
class WeatherDto with _$WeatherDto {
  factory WeatherDto({@JsonKey(name: 'ts') required String timeStamp,
    @JsonKey(name: 'tp') required int temperature,
    @JsonKey(name: 'pr') required int pressure,
    @JsonKey(name: 'hu') required int humidity,
    @JsonKey(name: 'ws') required double windSpeed,
    @JsonKey(name: 'wd') required double windDirection,
    @JsonKey(name: 'ic') required String weatherIconCode,}) = _WeatherDto;

  factory WeatherDto.fromJson(Map<String, Object?> json) =>
      _$WeatherDtoFromJson(json);

}
