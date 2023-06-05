import 'dart:async';

import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/domain/index.dart';
import 'package:weather_overview/presentation/index.dart';

class LocationPMFactory implements Factory<Location, LocationPM> {
  LocationPMFactory(this.coordinatesFactory);

  final Factory<GPSLocation, GPSLocationPM> coordinatesFactory;

  @override
  Future<LocationPM> create(Location location) async {
    final coordinatesCopy = location.coordinates;

    return LocationPM(
      city: location.city,
      state: location.state,
      country: location.country,
      coordinates: coordinatesCopy != null
          ? await coordinatesFactory.create(coordinatesCopy)
          : null,
    );
  }
}
