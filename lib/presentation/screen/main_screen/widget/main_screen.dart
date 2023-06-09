import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_overview/generated/l10n.dart';
import 'package:weather_overview/injection_container.dart' as di;
import 'package:weather_overview/presentation/index.dart';
import 'package:weather_overview/routing/index.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final EnvironmentStatusBloc _bloc;
  late final RootStackRouter _router;

  @override
  void initState() {
    super.initState();
    _bloc = di.sl<EnvironmentStatusBloc>();
    _router = di.sl<RootStackRouter>();
    _bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final strings = S.of(context);
    final floatingButtonSize = MediaQuery.of(context).size.width / 8;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.title),
      ),
      floatingActionButton:
          BlocBuilder<EnvironmentStatusBloc, EnvironmentStatusState>(
        bloc: _bloc,
        builder: (BuildContext context, EnvironmentStatusState state) {
          if (state.mapOrNull<bool>(
                fetchedIdle: (EnvironmentStatusFetchedIdle state) => true,
                fetchedLoading: (EnvironmentStatusFetchedLoading state) => true,
                fetchedError: (EnvironmentStatusFetchedError state) => true,
              ) ??
              false) {
            return FloatingButton(
              floatingButtonSize: floatingButtonSize,
              theme: theme,
              onTap: _onAddLocationPressed,
            );
          } else
            return SizedBox();
        },
      ),
      body: BlocConsumer<EnvironmentStatusBloc, EnvironmentStatusState>(
        bloc: _bloc,
        listener: onErrorListener,
        builder: (BuildContext context, EnvironmentStatusState state) {
          return state.map<Widget>(
            initialLoading: (_) => InitialLoadingStateWidget(),
            initialError: (EnvironmentStatusInitialError state) =>
                InitialErrorStateWidget(
              onRetryPressed: _bloc.init,
              errorMessage: state.errorMessage,
            ),
            fetchedIdle: (EnvironmentStatusFetchedIdle state) =>
                LoadedStatusStateWidget(
              status: state.status,
            ),
            fetchedLoading: (EnvironmentStatusFetchedLoading state) =>
                LoadedStatusStateWidget(
              status: state.status,
            ),
            fetchedError: (EnvironmentStatusFetchedError state) =>
                LoadedStatusStateWidget(
              status: state.status,
            ),
          );
        },
      ),
    );
  }

  void _onAddLocationPressed() {
    addLocation().then((LocationPM? locationPM) {
      if (locationPM != null) {
        _bloc.addLocation(locationPM, _bloc.update);
      }
    });
  }

  Future<LocationPM?> addLocation() =>
      _router.push<LocationPM?>(AddLocationRoute());

  void onErrorListener(BuildContext _, EnvironmentStatusState state) {
    final error = state.mapOrNull(fetchedError: (state) => state.errorMessage);
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
        ),
      );
    }
  }
}
