import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/domain/index.dart';
import 'package:weather_overview/presentation/index.dart';

class LocationFromPMFactory implements Factory<LocationPM, Location> {
  LocationFromPMFactory(this._factory);

  final Factory<GPSLocationPM, GPSLocation> _factory;

  @override
  Location create(LocationPM args) {
    final coordinatesCopy = args.coordinates;

    return Location(
        city: args.city,
        state: args.state,
        country: args.country,
        location:
            coordinatesCopy != null ? _factory.create(coordinatesCopy) : null);
  }
}
