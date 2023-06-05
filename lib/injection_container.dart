import 'package:auto_route/auto_route.dart';
import 'package:chopper/chopper.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_overview/data/locations_service.dart';
import 'package:weather_overview/presentation/index.dart';

import 'assembly/index.dart';
import 'constants.dart';
import 'data/index.dart';
import 'routing/index.dart';

GetIt get _instance => GetIt.instance;

T sl<T extends Object>({
  String? instanceName,
  Object? param1,
  Object? param2,
}) =>
    _instance.call<T>(
      instanceName: instanceName,
      param1: param1,
      param2: param2,
    );

void init() {
  _instance.registerLazySingleton<RootStackRouter>(() => AppRouter());
  _instance.registerLazySingleton<ChopperClient>(() => ChopperClient());
  _instance.registerLazySingleton<EnvironmentStatusBloc>(() => EnvironmentStatusBloc());
  _instance.registerFactory<AirVisualGateway>(
    () => AirVisualGateway.create(
      sl<ChopperClient>(),
    ),
  );
  _instance.registerFactory<Factory<String, List<String>>>(
    () => CountriesFromJsonFactory(),
    instanceName: Constants.countriesFactoryInstanceName,
  );
  _instance.registerFactory<Factory<String, List<String>>>(
    () => StatesFromJsonFactory(),
    instanceName: Constants.statesFactoryInstanceName,
  );
  _instance.registerFactory<Factory<String, List<String>>>(
    () => CitiesFromJsonFactory(),
    instanceName: Constants.citiesFactoryInstanceName,
  );
  _instance.registerFactory<LocationsService>(
    () => LocationsService(
      sl<AirVisualGateway>(),
      sl<Factory<String, List<String>>>(
        instanceName: Constants.countriesFactoryInstanceName,
      ),
    ),
  );
}
