import 'package:weather_overview/domain/model/location.dart';

abstract class LocationService {
  Future<List<Location>> getTrackedLocations();

  Future<List<String>> getSupportedCountries();

  Future<List<String>> getSupportedStates(String country);

  Future<List<String>> getSupportedCities(String country, String state);

  Future<void> deleteLocation(Location location);

  Future<Location> addLocation(Location location);
}
