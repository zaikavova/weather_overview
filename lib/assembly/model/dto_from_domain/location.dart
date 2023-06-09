import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/data/index.dart';
import 'package:weather_overview/domain/index.dart';

class LocationDtoFactory implements Factory<Location, LocationDto> {
  LocationDtoFactory(this._factory);

  final Factory<GPSLocation, GPSLocationDto> _factory;

  @override
  LocationDto create(Location args) {
    final argsCopy = args.location;

    return LocationDto(
      city: args.city ?? '',
      state: args.state ?? '',
      country: args.country ?? '',
      location: argsCopy != null ? _factory.create(argsCopy) : null,
    );
  }
}
