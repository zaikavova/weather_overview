import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/domain/index.dart';
import 'package:weather_overview/presentation/index.dart';

class CitiesFetchBloc extends FetchBloc<String, String, CitySearchParam> {
  CitiesFetchBloc(FetchDataAction<String, CitySearchParam> super.fetchCities,
      Factory<String, String> super._factory, super._getStringsRegistry);
}
