import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/domain/index.dart';
import 'package:weather_overview/presentation/index.dart';

class CountriesFetchBloc extends FetchBloc<String, String, VoidParam> {
  CountriesFetchBloc(
    FetchDataAction<String, VoidParam> super.fetchCities,
    Factory<String, String> super._factory,
    super._getStringsRegistry,
  );
}
