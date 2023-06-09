import 'package:weather_overview/domain/index.dart';

class GetSupportedCountries
    implements FetchDataAction<String, VoidParam> {
  GetSupportedCountries(this._service);

  final LocationService _service;

  @override
  Future<List<String>> call(VoidParam _) => _service.getSupportedCountries();
}
