import 'package:weather_overview/domain/index.dart';

class GetSupportedCities implements FetchDataAction<String, CitySearchParam> {
  GetSupportedCities(this._service);

  final LocationService _service;

  @override
  Future<List<String>> call(CitySearchParam param) =>
      _service.getSupportedCities(param.country, param.state);
}
