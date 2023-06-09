import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/domain/index.dart';
import 'package:weather_overview/presentation/index.dart';

class LocationPMFactory implements Factory<Location, LocationPM> {
  LocationPMFactory(this.coordinatesFactory);

  final Factory<GPSLocation, GPSLocationPM> coordinatesFactory;

  @override
  LocationPM create(Location location) {
    final coordinatesCopy = location.location;

    return LocationPM(
      city: location.city,
      state: location.state,
      country: location.country,
      coordinates: coordinatesCopy != null
          ? coordinatesFactory.create(coordinatesCopy)
          : null,
    );
  }
}
