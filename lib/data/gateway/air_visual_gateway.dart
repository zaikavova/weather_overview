import 'package:chopper/chopper.dart';
import 'package:weather_overview/constants.dart';

part 'air_visual_gateway.chopper.dart';

@ChopperApi(baseUrl: Constants.airVisualApiUrl)
abstract class AirVisualGateway extends ChopperService {
  static AirVisualGateway create(ChopperClient client) =>
      _$AirVisualGateway(client);

  @Get(path: Constants.getCountriesRoute)
  Future<Response<String>> getCountries({
    @Query('key') required String key,
  });

  @Get(path: Constants.getStatesRoute)
  Future<Response<String>> getStates({
    @Query('country') required String country,
    @Query('key') required String key,
  });

  @Get(path: Constants.getCitiesRoute)
  Future<Response<String>> getCities({
    @Query('state') required String state,
    @Query('country') required String country,
    @Query('key') required String key,
  });

  @Get(path: Constants.getEnvironmentStatusByName)
  Future<Response<String>> getEnvironmentStatesByPlaceName({
    @Query('state') required String state,
    @Query('country') required String country,
    @Query('city') required String city,
    @Query('key') required String key,
  });

  @Get(path: Constants.getEnvironmentStatusByGps)
  Future<Response<String>> getEnvironmentStatesByLongLat({
    @Query('lon') required double longitude,
    @Query('lat') required double latitude,
    @Query('key') required String key,
  });
}
