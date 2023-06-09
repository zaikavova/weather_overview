import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/domain/index.dart';
import 'package:weather_overview/presentation/index.dart';

class StatesFetchBloc extends FetchBloc<String, String, StateSearchParam> {
  StatesFetchBloc(FetchDataAction<String, StateSearchParam> super.fetchCities,
      Factory<String, String> super._factory);
}
