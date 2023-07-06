import 'package:flutter/material.dart';
import 'package:weather_overview/presentation/index.dart';

class EnvironmentStatusListItem extends StatelessWidget {
  const EnvironmentStatusListItem({
    super.key,
    required this.onToDetails,
    required this.statusPM,
    required this.onRemove,
  });

  final VoidCallback onToDetails;
  final VoidCallback onRemove;
  final EnvironmentStatusPM statusPM;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: 8,
        end: 8,
      ),
      child: GestureDetector(
        onLongPress: onRemove,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '${statusPM.location.city ?? ''}, ${statusPM.location.state}, ${statusPM.location.country}',
                  style: theme.textTheme.bodyLarge,
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Hero(
                      tag: statusPM.weather,
                      child: WeatherIndicatorIconWidget(
                        size: 64,
                        indicator: statusPM.weather.weatherIcon,
                      ),
                    ),
                    WindDirectionIndicator(
                      weatherPM: statusPM.weather,
                    ),
                    WindSpeedIndicator(
                      weatherPM: statusPM.weather,
                    ),
                    TemperatureIndicator(
                      weatherPm: statusPM.weather,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        onTap: onToDetails,
      ),
    );
  }
}
