import 'package:json_annotation/json_annotation.dart';
import 'package:weather_overview/assembly/model/dto_from_json/gps_location_dto_from_json_converter.dart';
import 'package:weather_overview/data/index.dart';
import 'package:weather_overview/domain/exception/index.dart';
import 'package:weather_overview/generated/l10n.dart';

class EnvironmentStatusDtoFromJsonConverter
    implements JsonConverter<EnvironmentStatusDto, Map<String, dynamic>> {
  const EnvironmentStatusDtoFromJsonConverter();

  @override
  EnvironmentStatusDto fromJson(Map<String, dynamic> json) {
    if (json['status'] as String != 'success') {
      throw GeneralException(S.current.generalException);
    }
    final jsonData = (json['data'] as Map<String, dynamic>);
    final current = (jsonData['current'] as Map<String, dynamic>);
    final weather =
        WeatherDto.fromJson(current['weather'] as Map<String, dynamic>);
    final jsonLocation = jsonData['location'] as Map<String, dynamic>;
    final location = LocationDto(
      city: jsonData['city'] as String,
      state: jsonData['state'] as String,
      country: jsonData['country'] as String,
      location: GpsLocationDtoFromJsonConverter().fromJson(jsonLocation),
    );
    final airCondition =
        AirConditionDto.fromJson(current['pollution'] as Map<String, dynamic>);

    return EnvironmentStatusDto(
        weather: weather, location: location, airCondition: airCondition);
  }

  @override
  Map<String, dynamic> toJson(EnvironmentStatusDto object) => {
        'data': {
          'city': object.location.city,
          'state': object.location.state,
          'country': object.location.country,
          'location': object.location.toJson(),
          'current': {
            'weather': object.weather.toJson(),
            'pollution': object.airCondition.toJson(),
          }
        },
      };
}
