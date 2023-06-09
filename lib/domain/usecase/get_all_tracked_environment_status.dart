import 'dart:async';

import 'package:weather_overview/domain/index.dart';

class GetAllTrackedEnvironmentStatus {
  GetAllTrackedEnvironmentStatus(
    this._service,
    this._locationService,
    this._getCurrentTime,
  );

  final EnvironmentStatusService _service;
  final LocationService _locationService;
  final GetCurrentTime _getCurrentTime;

  FutureOr<List<EnvironmentStatus>> call() async {
    final timestamp = await _getCurrentTime.call();

    return _locationService.getTrackedLocations().then(
          (List<Location> locations) =>
              _service.getAllTrackedEnvironmentStatus(locations, timestamp),
        );
  }
}
