class HiveBoxAccessKeysHolder {
  HiveBoxAccessKeysHolder._();

  static const String locationDtoBoxName = 'locationDtoBox';
  static const String environmentStatusBoxName = 'environmentStatusBox';
  static const String airConditionDtoBoxName = 'airConditionDtoBox';
  static const String weatherDtoBoxName = 'weatherDtoBox';
  static const String weatherVisualIndicatorDtoBoxName =
      'weatherVisualIndicatorDtoBox';
  static const String mainPollutantDtoBoxName = 'mainPollutantDtoBox';
  static const String countriesBoxName = 'CountriesBox';

  static String statesBoxName(String country) => '${country}StatesBox';

  static String citiesBoxName({
    required String country,
    required String state,
  }) =>
      '${country}${state}CitiesBox';
}
