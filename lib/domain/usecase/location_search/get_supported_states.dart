import 'package:weather_overview/domain/index.dart';

class GetSupportedStates
    implements FetchDataAction<String, StateSearchParam> {
  GetSupportedStates(this._service);

  final LocationService _service;

  @override
  Future<List<String>> call(StateSearchParam param) =>
      _service.getSupportedStates(param.country);
}
