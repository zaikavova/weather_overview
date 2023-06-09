import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather_overview/generated/l10n.dart';
import 'package:weather_overview/presentation/index.dart';

@RoutePage()
class EnvironmentDetailsScreen extends StatelessWidget {
  const EnvironmentDetailsScreen({required this.statusPM});

  final EnvironmentStatusPM statusPM;

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(statusPM.location.city ?? strings.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  children: [
                    Text(strings.temperature),
                    Spacer(),
                    Text(statusPM.weather.temperatureCelsius.toString())
                  ],
                ),
                Row(
                  children: [
                    Text(strings.humidity),
                    Spacer(),
                    Text(statusPM.weather.humidityPercent.toString())
                  ],
                ),
                Row(
                  children: [
                    Text(strings.windSpeed),
                    Spacer(),
                    Text(statusPM.weather.windSpeed.toString())
                  ],
                ),
                Row(
                  children: [
                    Text(strings.windDirection),
                    Spacer(),
                    Text(statusPM.weather.windDirection.toString())
                  ],
                ),
                Row(
                  children: [
                    Text(strings.atmospherePressure),
                    Spacer(),
                    Text(statusPM.weather.atmosphericPressureHPA.toString())
                  ],
                ),
                Row(
                  children: [
                    Text(strings.airQualityIndex),
                    Spacer(),
                    Text(statusPM.airCondition.airQualityIndex.toString())
                  ],
                ),
                WeatherIndicatorIconWidget(
                  indicator: statusPM.weather.weatherIcon,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
