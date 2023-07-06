import 'package:flutter/material.dart';
import 'package:weather_overview/gen/assets.gen.dart';
import 'package:weather_overview/generated/l10n.dart';
import 'package:weather_overview/presentation/index.dart';

class WindSpeedIndicator extends StatelessWidget {
  const WindSpeedIndicator(
      {super.key, required this.weatherPM, this.size = 64});

  final WeatherPM weatherPM;
  final double size;

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);
    return SizedBox(
      width: size,
      height: size,
      child: Column(
        children: [
          Expanded(child: Assets.icons.windSpeed.image()),
          SizedBox(
            height: 4,
          ),
          Text('${weatherPM.windSpeed} ${strings.metersPerSecond}'),
        ],
      ),
    );
  }
}
