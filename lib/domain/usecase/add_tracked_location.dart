import 'package:weather_overview/domain/index.dart';

class AddTrackedLocation {
  AddTrackedLocation(this._locationService);

  final LocationService _locationService;

  Future<Location> call(Location location) =>
      _locationService.addLocation(location);
}
