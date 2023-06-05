import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_overview/presentation/index.dart';

class EnvironmentStatusBloc
    extends Bloc<_EnvironmentStatusEvent, EnvironmentStatusState> {
  EnvironmentStatusBloc() : super(EnvironmentStatusState.initialLoading()) {
    on<_InitEnvironmentStatusEvent>(_init);
    on<_AddLocationEvent>(_addLocation);
  }

  void init() => add(_InitEnvironmentStatusEvent());

  void _init(
    _InitEnvironmentStatusEvent event,
    Emitter<EnvironmentStatusState> emitter,
  ) {
    emitter(EnvironmentStatusState.initialLoading());
  }

  void _addLocation(
    _AddLocationEvent event,
    Emitter<EnvironmentStatusState> emitter,
  ) {
    final loadingState = state.mapOrNull<EnvironmentStatusState?>(
      fetchedIdle: (state) =>
          EnvironmentStatusState.fetchedLoading(state.statuses),
      fetchedLoading: (state) =>
          EnvironmentStatusState.fetchedLoading(state.statuses),
      fetchedError: (state) =>
          EnvironmentStatusState.fetchedLoading(state.statuses),
    );
    if (loadingState != null) {
      emitter(loadingState);
    } else {
      throw (Exception('Wrong bloc condition, init block first'));
    }

    //do other code
  }

  void addLocation(LocationPM location) => add(_AddLocationEvent(location));
}

abstract class _EnvironmentStatusEvent {}

class _InitEnvironmentStatusEvent implements _EnvironmentStatusEvent {}

class _AddLocationEvent implements _EnvironmentStatusEvent {
  _AddLocationEvent(this.locationPM);

  final LocationPM locationPM;
}
