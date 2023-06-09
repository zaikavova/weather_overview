import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/domain/index.dart';
import 'package:weather_overview/presentation/index.dart';

class GPSLocationFromPMFactory implements Factory<GPSLocationPM, GPSLocation> {
  @override
  GPSLocation create(GPSLocationPM args) =>
      GPSLocation(latitude: args.latitude, longitude: args.longitude);
}
