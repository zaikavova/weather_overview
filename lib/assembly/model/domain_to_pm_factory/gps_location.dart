import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/domain/index.dart';
import 'package:weather_overview/presentation/index.dart';

class GPSLocationPMFactory implements Factory<GPSLocation, GPSLocationPM> {
  @override
  GPSLocationPM create(GPSLocation location) {
    return GPSLocationPM(
      longitude: location.longitude,
      latitude: location.latitude,
    );
  }
}
