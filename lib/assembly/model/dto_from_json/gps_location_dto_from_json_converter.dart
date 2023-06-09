import 'package:json_annotation/json_annotation.dart';
import 'package:weather_overview/data/index.dart';

class GpsLocationDtoFromJsonConverter
    implements JsonConverter<GPSLocationDto, Map<String, dynamic>> {
  const GpsLocationDtoFromJsonConverter();

  @override
  GPSLocationDto fromJson(Map<String, dynamic> json) {
    final coordinatesList = json['coordinates'] as List<dynamic>;

    return GPSLocationDto(
      longitude: coordinatesList.first as double,
      latitude: coordinatesList.last as double,
    );
  }

  @override
  Map<String, dynamic> toJson(GPSLocationDto object) => {
        'coordinates': [
          object.longitude,
          object.latitude,
        ]
      };
}
