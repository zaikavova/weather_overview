import 'package:weather_overview/presentation/index.dart';

class LocationPM {
  LocationPM({
    required this.city,
    required this.state,
    required this.country,
    required this.coordinates,
  });

  final String? city;
  final String? state;
  final String? country;
  final GPSLocationPM? coordinates;
}
