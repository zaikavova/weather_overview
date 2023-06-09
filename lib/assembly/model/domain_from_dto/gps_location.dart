import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/data/index.dart';
import 'package:weather_overview/domain/index.dart';

class GpsLocationFromDtoFactory
    implements Factory<GPSLocationDto, GPSLocation> {
  @override
  GPSLocation create(GPSLocationDto args) => GPSLocation(
        longitude: args.longitude,
        latitude: args.latitude,
      );
}
