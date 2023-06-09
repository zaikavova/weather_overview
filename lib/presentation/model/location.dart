import 'package:weather_overview/presentation/index.dart';

class LocationPM {
  LocationPM({
    this.city,
    this.state,
    this.country,
    this.coordinates,
  });

  final String? city;
  final String? state;
  final String? country;
  final GPSLocationPM? coordinates;
}
