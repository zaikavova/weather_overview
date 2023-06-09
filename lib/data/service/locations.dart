import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/constants.dart';
import 'package:weather_overview/data/index.dart';
import 'package:weather_overview/domain/index.dart';

class CachingLocationsService implements LocationService {
  CachingLocationsService({
    required this.airVisualGateway,
    required this.countriesFactory,
    required this.statesFactory,
    required this.citiesFactory,
    required this.hiveAccessor,
    required this.locationFromDtoFactory,
    required this.locationDtoFactory,
  }) {
    hiveAccessor.initFlutter().then((value) => _initCompleter.complete());
  }

  final Completer<void> _initCompleter = Completer();
  final HiveInterface hiveAccessor;
  final AirVisualGateway airVisualGateway;
  final Factory<String, List<String>> countriesFactory;
  final Factory<String, List<String>> statesFactory;
  final Factory<String, List<String>> citiesFactory;
  final Factory<LocationDto, Location> locationFromDtoFactory;
  final Factory<Location, LocationDto> locationDtoFactory;

  @override
  Future<List<String>> getSupportedCountries() =>
      _initProtect<List<String>>(() async {
        List<String> cachedCountries;
        final Box<String> box = await hiveAccessor
            .openBox<String>(HiveBoxAccessKeysHolder.countriesBoxName);
        cachedCountries = box.values.toList();
        if (cachedCountries.isEmpty) {
          final value =
              await airVisualGateway.getCountries(key: Constants.APIKey);

          final fetchedCountries = countriesFactory.create(value.bodyString);
          box.addAll(fetchedCountries);
          box.close();
          return fetchedCountries;
        } else {
          box.close();
          return cachedCountries;
        }
      });

  @override
  Future<List<String>> getSupportedStates(String country) async =>
      _initProtect<List<String>>(() async {
        List<String> cachedStates;
        final box = await hiveAccessor
            .openBox<String>(HiveBoxAccessKeysHolder.statesBoxName(country));
        cachedStates = box.values.toList();

        if (cachedStates.isEmpty) {
          final fetchedStates = await airVisualGateway.getStates(
            country: country,
            key: Constants.APIKey,
          );
          final result = statesFactory.create(fetchedStates.bodyString);
          box.addAll(result);
          box.close();
          return result;
        } else {
          box.close();
          return cachedStates;
        }
      });

  @override
  Future<List<String>> getSupportedCities(String country, String state) {
    return _initProtect<List<String>>(
      () async {
        final box = await hiveAccessor.openBox<String>(
          HiveBoxAccessKeysHolder.citiesBoxName(
            country: country,
            state: state,
          ),
        );
        List<String>? cachedCities;
        cachedCities = box.values.toList();

        if (cachedCities.isEmpty) {
          final fetchedCities = await airVisualGateway.getCities(
            country: country,
            state: state,
            key: Constants.APIKey,
          );
          final result = citiesFactory.create(fetchedCities.bodyString);
          box.addAll(result);
          box.close();
          return result;
        } else {
          return cachedCities;
        }
      },
    );
  }

  @override
  Future<List<Location>> getTrackedLocations() {
    return _initProtect<List<Location>>(
      () => hiveAccessor
          .openBox<LocationDto>(HiveBoxAccessKeysHolder.locationDtoBoxName)
          .then((box) async {
        final values = box.values.map(locationFromDtoFactory.create).toList();
        await box.close();
        return values;
      }),
    );
  }

  @override
  Future<Location> addLocation(Location location) async {
    await _initProtect<void>(
      () async => hiveAccessor
          .openBox<LocationDto>(HiveBoxAccessKeysHolder.locationDtoBoxName)
          .then((box) async {
        await box.add(locationDtoFactory.create(location));
        return await box.close();
      }),
    );

    return location;
  }

  @override
  Future<void> deleteLocation(Location location) {
    return _initProtect<void>(
      () async => hiveAccessor
          .openBox<LocationDto>(HiveBoxAccessKeysHolder.locationDtoBoxName)
          .then((box) async {
       final index =  box.values.toList().indexOf(locationDtoFactory.create(location));
        box.deleteAt(index);
        return await box.close();
      }),
    );
  }

  Future<T> _initProtect<T>(Future<T> Function() action) async {
    if (_initCompleter.isCompleted) {
      return action();
    } else {
      return _initCompleter.future.then((value) {
        return action();
      });
    }
  }
}
