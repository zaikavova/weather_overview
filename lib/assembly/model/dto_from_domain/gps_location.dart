import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/data/index.dart';
import 'package:weather_overview/domain/index.dart';

class GPSLocationDtoFactory implements Factory<GPSLocation, GPSLocationDto> {
  @override
  GPSLocationDto create(GPSLocation args) => GPSLocationDto(
        latitude: args.latitude,
        longitude: args.longitude,
      );
}
