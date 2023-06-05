import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_overview/presentation/index.dart';

part 'state.freezed.dart';

@freezed
class EnvironmentStatusState with _$EnvironmentStatusState {
  const factory EnvironmentStatusState.initialLoading() =
      EnvironmentStatusInitialLoading;

  const factory EnvironmentStatusState.initialError(String errorMessage) =
      EnvironmentStatusInitialError;

  const factory EnvironmentStatusState.fetchedIdle(
    List<EnvironmentStatusPM> statuses,
  ) = EnvironmentStatusFetchedIdle;

  const factory EnvironmentStatusState.fetchedLoading(
    List<EnvironmentStatusPM> statuses,
  ) = EnvironmentStatusFetchedLoading;

  const factory EnvironmentStatusState.fetchedError(
    List<EnvironmentStatusPM> statuses,
    String errorMessage,
  ) = EnvironmentStatusFetchedError;
}
