import '../index.dart';

class Location {
  Location({
    required this.city,
    required this.state,
    required this.country,
    required this.location,
  }) : assert(location != null ||
            (city != null && state != null && country != null));

  final String? city;
  final String? state;
  final String? country;
  final GPSLocation? location;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != this.runtimeType) {
      return false;
    }

    final otherLocation = other as Location;

    return this.city == otherLocation.city &&
            this.state == otherLocation.state &&
            this.country == otherLocation.country ||
        this.location == otherLocation.location;
  }
}
