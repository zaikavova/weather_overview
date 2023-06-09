import 'package:weather_overview/domain/index.dart';

abstract class EnvironmentStatusService {
  Future<List<EnvironmentStatus>> getAllTrackedEnvironmentStatus(
    List<Location> locations,
    DateTime currentTime,
  );
}
