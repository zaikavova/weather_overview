import 'package:auto_route/auto_route.dart';
import 'package:chopper/chopper.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/constants.dart';
import 'package:weather_overview/data/index.dart';
import 'package:weather_overview/domain/index.dart';
import 'package:weather_overview/presentation/index.dart';
import 'package:weather_overview/routing/index.dart';

//ignore_for_file: avoid-long-functions

GetIt get _instance => GetIt.instance;

T sl<T extends Object>({
  String? instanceName,
  Object? param1,
  Object? param2,
}) =>
    _instance.get<T>(
      instanceName: instanceName,
      param1: param1,
      param2: param2,
    );

void init() {
  _initHive();
  _initServices();
  _initAssembly();
  _initUsecases();

  _instance.registerLazySingleton<RootStackRouter>(() => AppRouter());
  _instance.registerLazySingleton<ChopperClient>(
    () => ChopperClient(),
  );
  _instance
      .registerLazySingleton<EnvironmentStatusBloc>(() => EnvironmentStatusBloc(
            _instance.get<GetAllTrackedEnvironmentStatus>(),
            _instance.get<Factory<EnvironmentStatus, EnvironmentStatusPM>>(),
            _instance.get<AddTrackedLocation>(),
            _instance.get<Factory<LocationPM, Location>>(),
            _instance.get<DeleteTrackedLocation>(),
          ));
  _instance.registerFactory<CitiesFetchBloc>(
    () => CitiesFetchBloc(
      _instance.get<FetchDataAction<String, CitySearchParam>>(),
      _instance.get<Factory<String, String>>(),
    ),
  );

  _instance.registerFactory<CountriesFetchBloc>(
    () => CountriesFetchBloc(
      _instance.get<FetchDataAction<String, VoidParam>>(),
      _instance.get<Factory<String, String>>(),
    ),
  );
  _instance.registerFactory<StatesFetchBloc>(
    () => StatesFetchBloc(
      _instance.get<FetchDataAction<String, StateSearchParam>>(),
      _instance.get<Factory<String, String>>(),
    ),
  );
  _instance.registerFactory<AirVisualGateway>(
    () => AirVisualGateway.create(
      _instance.get<ChopperClient>(),
    ),
  );

  _instance.registerFactory<HiveEnvironmentGateway>(
    () => HiveEnvironmentGateway(
      _instance.get<HiveInterface>(),
    ),
  );
}

void _initHive() {
  final instance = Hive;
  instance.registerAdapter(LocationDtoAdapter());
  instance.registerAdapter(GPSLocationDtoAdapter());
  instance.registerAdapter(EnvironmentStatusDtoAdapter());
  instance.registerAdapter(AirConditionDtoAdapter());
  instance.registerAdapter(MainPollutantDtoAdapter());
  instance.registerAdapter(WeatherDtoAdapter());
  instance.registerAdapter(WeatherVisualIndicatorDtoAdapter());

  _instance.registerSingleton<HiveInterface>(instance);
}

void _initUsecases() {
  _instance.registerFactory<AddTrackedLocation>(
    () => AddTrackedLocation(
      _instance.get<LocationService>(),
    ),
  );

  _instance.registerFactory<DeleteTrackedLocation>(
    () => DeleteTrackedLocation(
      _instance.get<LocationService>(),
    ),
  );
  _instance.registerFactory<FetchDataAction<String, StateSearchParam>>(
    () => GetSupportedStates(
      _instance.get<LocationService>(),
    ),
  );
  _instance.registerFactory<FetchDataAction<String, CitySearchParam>>(
    () => GetSupportedCities(
      _instance.get<LocationService>(),
    ),
  );
  _instance.registerFactory<FetchDataAction<String, VoidParam>>(
    () => GetSupportedCountries(
      _instance.get<LocationService>(),
    ),
  );
  _instance.registerFactory<GetCurrentTime>(
    () => GetDeviceCurrentTime(),
  );
  _instance.registerFactory<GetAllTrackedEnvironmentStatus>(
    () => GetAllTrackedEnvironmentStatus(
      _instance.get<EnvironmentStatusService>(),
      _instance.get<LocationService>(),
      _instance.get<GetCurrentTime>(),
    ),
  );
}

void _initServices() {
  _instance.registerFactory<EnvironmentStatusService>(
    () => ComposingEnvironmentStatusService(
      _instance.get<Factory<EnvironmentStatusDto, EnvironmentStatus>>(),
      _instance.get<HiveEnvironmentGateway>(),
      _instance.get<AirVisualGateway>(),
      _instance.get<Factory<LocationDto, Location>>(),
      _instance.get<EnvironmentStatusDtoFromJsonConverter>(),
    ),
  );
  _instance.registerFactory<LocationService>(
    () => CachingLocationsService(
      airVisualGateway: _instance.get<AirVisualGateway>(),
      countriesFactory: _instance.get<Factory<String, List<String>>>(
        instanceName: Constants.countriesFactoryInstanceName,
      ),
      statesFactory: _instance.get<Factory<String, List<String>>>(
        instanceName: Constants.statesFactoryInstanceName,
      ),
      citiesFactory: _instance.get<Factory<String, List<String>>>(
        instanceName: Constants.citiesFactoryInstanceName,
      ),
      hiveAccessor: _instance.get<HiveInterface>(),
      locationFromDtoFactory: _instance.get<Factory<LocationDto, Location>>(),
      locationDtoFactory: _instance.get<Factory<Location, LocationDto>>(),
    ),
  );
}

void _initAssembly() {
  _instance.registerFactory<Factory<WeatherDto, Weather>>(
    () => WeatherFromDtoFactory(
      _instance
          .get<Factory<WeatherVisualIndicatorDto, WeatherVisualIndicator>>(),
    ),
  );
  _instance.registerFactory<Factory<EnvironmentStatusDto, EnvironmentStatus>>(
    () => EnvironmentStatusFromDtoFactory(
      _instance.get<Factory<WeatherDto, Weather>>(),
      _instance.get<Factory<LocationDto, Location>>(),
      _instance.get<Factory<AirConditionDto, AirCondition>>(),
    ),
  );
  _instance.registerFactory<
      Factory<WeatherVisualIndicatorDto, WeatherVisualIndicator>>(
    () => WeatherVisualIndicatorFromDto(),
  );
  _instance.registerFactory<Factory<MainPollutantDto, MainPollutant>>(
    () => MainPollutantFromDtoFactory(),
  );
  _instance.registerFactory<Factory<AirConditionDto, AirCondition>>(
    () => AirConditionFromDtoFactory(
      _instance.get<Factory<MainPollutantDto, MainPollutant>>(),
    ),
  );
  _instance.registerFactory<Factory<LocationDto, Location>>(
    () => LocationFromDtoFactory(
      _instance.get<Factory<GPSLocationDto, GPSLocation>>(),
    ),
  );
  _instance.registerFactory<Factory<GPSLocationDto, GPSLocation>>(
    () => GpsLocationFromDtoFactory(),
  );
  _instance.registerFactory<Factory<GPSLocation, GPSLocationDto>>(
    () => GPSLocationDtoFactory(),
  );
  _instance.registerFactory<Factory<Location, LocationDto>>(
    () => LocationDtoFactory(
      _instance.get<Factory<GPSLocation, GPSLocationDto>>(),
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
  _instance.registerFactory<Factory<AirCondition, AirConditionPM>>(
    () => AirConditionPMFactory(),
  );
  _instance.registerFactory<Factory<Weather, WeatherPM>>(
    () => WeatherPMFactory(),
  );
  _instance.registerFactory<Factory<EnvironmentStatus, EnvironmentStatusPM>>(
    () => EnvironmentStatusPMFactory(
      weatherFactory: _instance.get<Factory<Weather, WeatherPM>>(),
      locationFactory: _instance.get<Factory<Location, LocationPM>>(),
      airConditionFactory:
          _instance.get<Factory<AirCondition, AirConditionPM>>(),
    ),
  );
  _instance.registerFactory<Factory<Location, LocationPM>>(
    () => LocationPMFactory(
      _instance.get<Factory<GPSLocation, GPSLocationPM>>(),
    ),
  );
  _instance.registerFactory<Factory<GPSLocation, GPSLocationPM>>(
    () => GPSLocationPMFactory(),
  );
  _instance.registerFactory<Factory<String, String>>(
    () => AuxiliaryPlainStringFactory(),
  );
  _instance.registerFactory<Factory<LocationPM, Location>>(
    () => LocationFromPMFactory(
      _instance.get<Factory<GPSLocationPM, GPSLocation>>(),
    ),
  );
  _instance.registerFactory<Factory<GPSLocationPM, GPSLocation>>(
    () => GPSLocationFromPMFactory(),
  );
  _instance.registerFactory<EnvironmentStatusDtoFromJsonConverter>(
    () => EnvironmentStatusDtoFromJsonConverter(),
  );
}
