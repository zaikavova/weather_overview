class Constants {
  Constants._();
  static const int maxTrackedLocations = 5;

  // Normally you don't want to have your key here because of RE is possible.
  // Not relevant now because of free api access
  static const String APIKey = 'de7fa971-0fd7-4a3c-8ea0-930ec79df380';
  static const String airVisualApiUrl = 'http://api.airvisual.com/v2/';
  static const String getCountriesRoute = 'countries';
  static const String getStatesRoute = 'states';
  static const String getCitiesRoute = 'cities';
  static const String getEnvironmentStatusByGps = 'nearest_city';
  static const String getEnvironmentStatusByName = 'city';
  static const String countriesFactoryInstanceName = 'CountriesFromJsonFactory';
  static const String statesFactoryInstanceName = 'StatesFromJsonFactory';
  static const String citiesFactoryInstanceName = 'CitiesFromJsonFactory';
  static const Duration statusValidityDuration = Duration(hours: 1);
}
