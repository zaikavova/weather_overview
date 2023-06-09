import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather_overview/generated/l10n.dart';
import 'package:weather_overview/injection_container.dart' as di;
import 'package:weather_overview/presentation/index.dart';
import 'package:weather_overview/routing/index.dart';

class LoadedStatusStateWidget extends StatefulWidget {
  const LoadedStatusStateWidget({super.key, required this.status});

  final List<EnvironmentStatusPM> status;

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

    return CustomScrollView(
      slivers: [
        if (widget.status.isEmpty)
          SliverFillRemaining(
            fillOverscroll: false,
            hasScrollBody: false,
            child: Center(
              child: Text(string.addFirstLocationMessage),
            ),
          ),
        if (widget.status.isNotEmpty)
          SliverList(
            delegate: SliverChildListDelegate([
              ...widget.status
                  .map<Widget>((e) => GestureDetector(
                        child: Card(
                          child: Column(
                            children: [
                              Text(
                                  "${e.location.country} ${e.location.state} ${e.location.city}"),
                              Text(
                                  "Temperature ${e.weather.temperatureCelsius}C, Wind ${e.weather.windSpeed}m/s, Humidity${e.weather.humidityPercent}%"),
                            ],
                          ),
                        ),
                        onTap: () {
                          _router.push(EnvironmentDetailsRoute(statusPM: e));
                        },
                      ))
                  .toList()
            ]),
          )
      ],
    );
  }
}
