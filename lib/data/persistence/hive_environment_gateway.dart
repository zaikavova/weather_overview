import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_overview/constants.dart';
import 'package:weather_overview/data/index.dart';

class HiveEnvironmentGateway {
  HiveEnvironmentGateway(this._hiveAccessor) {
    _hiveAccessor.initFlutter().then((value) => _initCompleter.complete());
  }

  final Completer<void> _initCompleter = Completer();
  final HiveInterface _hiveAccessor;

  Future<List<EnvironmentStatusDto>> getAllStatus(DateTime timestamp) async {
    if (!_initCompleter.isCompleted) {
      await _initCompleter.future;
    }

    return _hiveAccessor
        .openBox<EnvironmentStatusDto>(
      HiveBoxAccessKeysHolder.environmentStatusBoxName,
    )
        .then((box) async {
      final result = box.values
          .where(
            (EnvironmentStatusDto element) =>
                DateTime.parse(element.weather.timeStamp).isAfter(
              timestamp.subtract(
                Constants.statusValidityDuration,
              ),
            ),
          )
          .toList();
      await box.close();
      return {...result}.toList();
    });
  }

  Future<void> removeStatus(EnvironmentStatusDto environmentStatus) async {
    if (!_initCompleter.isCompleted) {
      await _initCompleter.future;
    }
    final box = await _hiveAccessor.openBox<EnvironmentStatusDto>(
      HiveBoxAccessKeysHolder.environmentStatusBoxName,
    );
    final index = box.values.toList().indexOf(environmentStatus);
    box
      ..deleteAt(index)
      ..close();
  }

  Future<void> addStatus(List<EnvironmentStatusDto> status) async {
    if (!_initCompleter.isCompleted) {
      await _initCompleter.future;
    }

    final box = await _hiveAccessor.openBox<EnvironmentStatusDto>(
      HiveBoxAccessKeysHolder.environmentStatusBoxName,
    );
    final values = box.values.toList();
    for (EnvironmentStatusDto statusElement in status) {
      final index = values.indexOf(statusElement);
      if (index == -1) {
        box.add(statusElement);
      } else {
        box.putAt(index, statusElement);
      }
    }
    if (box.isOpen) {
      await box.close();
    }
  }
}
