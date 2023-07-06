import 'package:flutter/material.dart';
import 'package:weather_overview/gen/assets.gen.dart';
import 'package:weather_overview/presentation/index.dart';

class AtmospherePressureIndicator extends StatelessWidget {
  const AtmospherePressureIndicator({
    required this.weatherPm,
     this.size = 64,
    super.key,
  });

  final WeatherPM weatherPm;
  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: size,
        height: size,
        child: Column(
          children: [
            Expanded(child: Assets.icons.atmospherePressure.image()),
            Text('${weatherPm.atmosphericPressureHPA} HPA'),
          ],
        ),
      );
}
