import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/data/index.dart';
import 'package:weather_overview/domain/index.dart';

class LocationFromDtoFactory implements Factory<LocationDto, Location> {
  LocationFromDtoFactory(this._gpsLocationFactory);

  final Factory<GPSLocationDto, GPSLocation> _gpsLocationFactory;

  @override
  Location create(LocationDto args) {
    final argsCopy = args.location;

    return Location(
      city: args.city,
      state: args.state,
      country: args.country,
      location:
          argsCopy != null ? _gpsLocationFactory.create(argsCopy) : null,
    );
  }
}
