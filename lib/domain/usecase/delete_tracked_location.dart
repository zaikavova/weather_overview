import 'package:weather_overview/domain/index.dart';

class DeleteTrackedLocation {
  DeleteTrackedLocation(this._service);

  final LocationService _service;

  Future<void> call(Location location) => _service.deleteLocation(location);
}
