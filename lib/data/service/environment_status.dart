import 'dart:async';
import 'dart:convert';

import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/constants.dart';
import 'package:weather_overview/data/index.dart';
import 'package:weather_overview/domain/index.dart';

class ComposingEnvironmentStatusService implements EnvironmentStatusService {
  ComposingEnvironmentStatusService(
    this._environmentFactory,
    this._hiveGateway,
    this._airVisualGateway,
    this._locationFromDtoFactory,
    this._environmentStatusDtoFromJsonConverter,
  );

  final Factory<EnvironmentStatusDto, EnvironmentStatus> _environmentFactory;
  final Factory<LocationDto, Location> _locationFromDtoFactory;
  final EnvironmentStatusDtoFromJsonConverter
      _environmentStatusDtoFromJsonConverter;
  final HiveEnvironmentGateway _hiveGateway;
  final AirVisualGateway _airVisualGateway;

  @override
  Future<List<EnvironmentStatus>> getAllTrackedEnvironmentStatus(
    List<Location> locations,
    DateTime currentTime,
  ) async {
    final statusList = await _hiveGateway.getAllStatus(currentTime);

    final locationsToFetch = [...locations];

    final storedLocation = statusList
        .map<Location>((e) => _locationFromDtoFactory.create(e.location));
    storedLocation.forEach((element) {
      locationsToFetch.removeWhere((item) => item == element);
    });

    final List<EnvironmentStatusDto> environmentStatus = await Future.wait(
      locationsToFetch
          .map<Future<EnvironmentStatusDto>>((Location location) async {
        final locationCopy = location.location;
        final EnvironmentStatusDto result;
        if (locationCopy != null) {
          result = _environmentStatusDtoFromJsonConverter.fromJson(
            json.decode(
              (await _airVisualGateway.getEnvironmentStatesByLongLat(
                longitude: locationCopy.longitude,
                latitude: locationCopy.latitude,
                key: Constants.APIKey,
              ))
                  .bodyString,
            ) as Map<String, dynamic>,
          );
        } else {
          result = _environmentStatusDtoFromJsonConverter.fromJson(json.decode(
            (await _airVisualGateway.getEnvironmentStatesByPlaceName(
              city: location.city ?? '',
              state: location.state ?? '',
              country: location.country ?? '',
              key: Constants.APIKey,
            ))
                .bodyString,
          ) as Map<String, dynamic>);
        }
        return result;
      }),
    );
    _hiveGateway.addStatus(environmentStatus);
    return [...statusList, ...environmentStatus]
        .map<EnvironmentStatus>(_environmentFactory.create)
        .toList();
  }
}
