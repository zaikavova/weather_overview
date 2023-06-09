import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_overview/assembly/index.dart';
import 'package:weather_overview/domain/index.dart';
import 'package:weather_overview/presentation/index.dart';

class EnvironmentStatusBloc
    extends Bloc<_EnvironmentStatusEvent, EnvironmentStatusState> {
  EnvironmentStatusBloc(
    this._getTrackedStatus,
    this._environmentPmFactory,
    this._addTrackedLocation,
    this._locationFactory,
    this._deleteTrackedLocation,
  ) : super(EnvironmentStatusState.initialLoading()) {
    on<_InitEnvironmentStatusEvent>(_init);
    on<_UpdateEnvironmentStatusEvent>(_update);
    on<_AddTrackedLocationEvent>(_addLocation);
    on<_DeleteTrackedLocationEvent>(_deleteLocation);
  }

  final GetAllTrackedEnvironmentStatus _getTrackedStatus;
  final AddTrackedLocation _addTrackedLocation;
  final DeleteTrackedLocation _deleteTrackedLocation;
  final Factory<EnvironmentStatus, EnvironmentStatusPM> _environmentPmFactory;
  final Factory<LocationPM, Location> _locationFactory;

  void init() => add(_InitEnvironmentStatusEvent());

  void update() => add(_UpdateEnvironmentStatusEvent());

  Future<void> _init(
    _InitEnvironmentStatusEvent event,
    Emitter<EnvironmentStatusState> emitter,
  ) async {
    emitter(EnvironmentStatusState.initialLoading());
    try {
      final statusUpdate = await _getTrackedStatus.call();

      emitter(
        EnvironmentStatusState.fetchedIdle(
          statusUpdate.map(_environmentPmFactory.create).toList(),
        ),
      );
    } catch (e) {
      emitter(
        EnvironmentStatusState.initialError(
          e.toString(),
        ),
      );
      rethrow;
    }
  }

  Future<void> _update(
    _UpdateEnvironmentStatusEvent event,
    Emitter<EnvironmentStatusState> emitter,
  ) async {
    List<EnvironmentStatusPM> status = _getCurrentStatus(emitter);
    try {
      final statusUpdate = await _getTrackedStatus();
      emitter(
        EnvironmentStatusState.fetchedIdle(
          statusUpdate.map(_environmentPmFactory.create).toList(),
        ),
      );
    } catch (e) {
      emitter(
        EnvironmentStatusState.fetchedError(
          status,
          e.toString(),
        ),
      );
      rethrow;
    }
  }

  List<EnvironmentStatusPM> _getCurrentStatus(
      Emitter<EnvironmentStatusState> emitter) {
    final status = state.mapOrNull<List<EnvironmentStatusPM>?>(
      fetchedIdle: (state) => state.status,
      fetchedLoading: (state) => state.status,
      fetchedError: (state) => state.status,
    );
    if (status != null) {
      emitter(EnvironmentStatusState.fetchedLoading(status));
    } else {
      throw (Exception('Wrong bloc condition, init block first'));
    }
    return status;
  }

  void addLocation(LocationPM locationPM, [VoidCallback? onSuccess]) =>
      add(_AddTrackedLocationEvent(locationPM, onSuccess));

  Future<void> _addLocation(
    _AddTrackedLocationEvent event,
    Emitter<EnvironmentStatusState> emitter,
  ) async {
    final status = _getCurrentStatus(emitter);
    emitter(EnvironmentStatusState.fetchedLoading(status));
    try {
      await _addTrackedLocation(_locationFactory.create(event._locationPM));
      event._onSuccess?.call();
      emitter(EnvironmentStatusState.fetchedIdle(status));
    } catch (e) {
      emitter(EnvironmentStatusState.fetchedError(status, e.toString()));
      rethrow;
    }
  }

  void deleteLocation(LocationPM locationPM, [VoidCallback? onSuccess]) =>
      add(_DeleteTrackedLocationEvent(locationPM, onSuccess));

  Future<void> _deleteLocation(
    _DeleteTrackedLocationEvent event,
    Emitter<EnvironmentStatusState> emitter,
  ) async {
    final status = _getCurrentStatus(emitter);
    emitter(EnvironmentStatusState.fetchedLoading(status));
    try {
      await _deleteTrackedLocation(_locationFactory.create(event._locationPM));
      event._onSuccess?.call();
      emitter(EnvironmentStatusState.fetchedIdle(status));
    } catch (e) {
      emitter(EnvironmentStatusState.fetchedError(status, e.toString()));
      rethrow;
    }
  }
}

abstract class _EnvironmentStatusEvent {}

class _InitEnvironmentStatusEvent implements _EnvironmentStatusEvent {}

class _UpdateEnvironmentStatusEvent implements _EnvironmentStatusEvent {}

class _AddTrackedLocationEvent implements _EnvironmentStatusEvent {
  _AddTrackedLocationEvent(this._locationPM, [this._onSuccess]);

  final LocationPM _locationPM;
  final VoidCallback? _onSuccess;
}

class _DeleteTrackedLocationEvent implements _EnvironmentStatusEvent {
  _DeleteTrackedLocationEvent(this._locationPM, this._onSuccess);

  final LocationPM _locationPM;
  final VoidCallback? _onSuccess;
}
