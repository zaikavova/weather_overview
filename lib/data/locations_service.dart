import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/constants.dart';
import 'package:weather_overview/data/gateway/index.dart';

class LocationsService {
  LocationsService(this._airVisualGateway, this._countriesFactory);

  final AirVisualGateway _airVisualGateway;
  final Factory<String, List<String>> _countriesFactory;

  Future<List<String>> getSupportedCountries() async {
    final value = await _airVisualGateway.getCountries(Constants.APIKey);

    return  _countriesFactory.create(value.bodyString);
  }
}
