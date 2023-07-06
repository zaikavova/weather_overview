import 'dart:async';

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
  late Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _bloc = di.sl<EnvironmentStatusBloc>();
    _router = di.sl<RootStackRouter>();
    _bloc.init();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.title),
      ),
      floatingActionButton:
          BlocConsumer<EnvironmentStatusBloc, EnvironmentStatusState>(
        bloc: _bloc,
        listener: (BuildContext context, EnvironmentStatusState state) {
          state.mapOrNull<void>(
            fetchedError: _completeRefresh,
            fetchedIdle: _completeRefresh,
          );
        },
        builder: (BuildContext context, EnvironmentStatusState state) {
          return state.map<Widget>(
            fetchedIdle: (EnvironmentStatusFetchedIdle state) =>
                _buildFloatingButton(),
            fetchedLoading: (EnvironmentStatusFetchedLoading state) =>
                _buildFloatingButton(isLoading: true),
            fetchedError: (EnvironmentStatusFetchedError state) =>
                _buildFloatingButton(),
            initialLoading: (EnvironmentStatusInitialLoading value) =>
                SizedBox(),
            initialError: (EnvironmentStatusInitialError value) => SizedBox(),
          );
        },
      ),
      body: BlocConsumer<EnvironmentStatusBloc, EnvironmentStatusState>(
        bloc: _bloc,
        listener: _onErrorListener,
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
              refresh: _refresh,
            ),
            fetchedLoading: (EnvironmentStatusFetchedLoading state) =>
                LoadedStatusStateWidget(
              status: state.status,
              refresh: _refresh,
            ),
            fetchedError: (EnvironmentStatusFetchedError state) =>
                LoadedStatusStateWidget(
              status: state.status,
              refresh: _refresh,
            ),
          );
        },
      ),
    );
  }

  void _completeRefresh(EnvironmentStatusState state) {
    _refreshCompleter.complete();
    _refreshCompleter = Completer<void>();
  }

  Future<void> _refresh() {
    _bloc.update();
    return _refreshCompleter.future;
  }

  FloatingButton _buildFloatingButton({bool isLoading = false}) =>
      FloatingButton(
        floatingButtonSize: MediaQuery.of(context).size.width / 8,
        isLoading: isLoading,
        onTap: _onAddLocationPressed,
      );

  void _onAddLocationPressed() {
    _addLocation().then((LocationPM? locationPM) {
      if (locationPM != null) {
        _bloc.addLocation(locationPM, _bloc.update);
      }
    });
  }

  Future<LocationPM?> _addLocation() =>
      _router.push<LocationPM?>(AddLocationRoute());

  void _onErrorListener(BuildContext _, EnvironmentStatusState state) {
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
