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
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(
                      height: 16,
                    ),
                    Hero(
                      tag: statusPM.weather,
                      child: WeatherIndicatorIconWidget(
                        size: MediaQuery.of(context).size.width * 0.7,
                        indicator: statusPM.weather.weatherIcon,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        alignment: WrapAlignment.spaceAround,
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          WindDirectionIndicator(weatherPM: statusPM.weather),
                          WindSpeedIndicator(weatherPM: statusPM.weather),
                          TemperatureIndicator(weatherPm: statusPM.weather),
                          HumidityIndicator(weatherPM: statusPM.weather),
                          AtmospherePressureIndicator(
                            weatherPm: statusPM.weather,
                          ),
                          AirQualityIndicator(
                              airConditionPM: statusPM.airCondition),
                          MainPollutantIndicator(
                            airConditionPM: statusPM.airCondition,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
