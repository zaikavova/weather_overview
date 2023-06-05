import '../index.dart';

class Location {
  Location({
    required this.city,
    required this.state,
    required this.country,
    required this.coordinates,
  }) : assert(coordinates != null ||
            (city != null && state != null && country != null));

  final String? city;
  final String? state;
  final String? country;
  final GPSLocation? coordinates;
}
