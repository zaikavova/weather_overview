import 'package:chopper/chopper.dart';
import 'package:weather_overview/constants.dart';

part 'air_visual_gateway.chopper.dart';

@ChopperApi(baseUrl: Constants.airVisualApiUrl)
abstract class AirVisualGateway extends ChopperService {
  static AirVisualGateway create(ChopperClient client) =>
      _$AirVisualGateway(client);

  @Get(path: Constants.getCountriesRoute)
  Future<Response<String>> getCountries(
    @Query('key') String key,
  );

  @Get(path: Constants.getStatesRoute)
  Future<Response<String>> getStates(
    @Query('country') String country,
    @Query('key') String key,
  );

  @Get(path: Constants.getCitiesRoute)
  Future<Response<String>> getCities(
    @Query('state') String state,
    @Query('country') String country,
    @Query('key') String key,
  );
}
