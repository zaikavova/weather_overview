import 'package:flutter/cupertino.dart';
import 'package:weather_overview/gen/assets.gen.dart';
import 'package:weather_overview/presentation/index.dart';

class TemperatureIndicator extends StatelessWidget {
  const TemperatureIndicator(
      {super.key, required this.weatherPm, this.size = 64});

  final WeatherPM weatherPm;
  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: size,
        height: size,
        child: Column(
          children: [
            Expanded(child: Assets.icons.temperature.image()),
            Text('${weatherPm.temperatureCelsius} C'),
          ],
        ),
      );
}
