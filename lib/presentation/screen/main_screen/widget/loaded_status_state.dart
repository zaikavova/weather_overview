import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather_overview/generated/l10n.dart';
import 'package:weather_overview/injection_container.dart' as di;
import 'package:weather_overview/presentation/index.dart';
import 'package:weather_overview/routing/index.dart';

class LoadedStatusStateWidget extends StatefulWidget {
  const LoadedStatusStateWidget({
    super.key,
    required this.status,
    required this.refresh,
  });

  final List<EnvironmentStatusPM> status;
  final Future<void> Function() refresh;

  @override
  State<LoadedStatusStateWidget> createState() =>
      _LoadedStatusStateWidgetState();
}

class _LoadedStatusStateWidgetState extends State<LoadedStatusStateWidget> {
  late final RootStackRouter _router;

  @override
  void initState() {
    super.initState();
    _router = di.sl<RootStackRouter>();
  }

  @override
  Widget build(BuildContext context) {
    final string = S.of(context);

    return RefreshIndicator(
      onRefresh: widget.refresh,
      child: CustomScrollView(
        slivers: [
          if (widget.status.isEmpty)
            SliverFillRemaining(
              fillOverscroll: false,
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    string.addFirstLocationMessage,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          if (widget.status.isNotEmpty)
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 8,
                ),
                ...widget.status
                    .map<Widget>(
                      (e) => EnvironmentStatusListItem(
                        key: ValueKey<WeatherPM>(e.weather),
                        onToDetails: () {
                          _router.push(EnvironmentDetailsRoute(statusPM: e));
                        },
                        statusPM: e,
                        onRemove: () {
                          print('test remove');
                        },
                      ),
                    )
                    .toList()
              ]),
            )
        ],
      ),
    );
  }
}
