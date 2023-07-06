import 'package:flutter/cupertino.dart';
import 'package:weather_overview/gen/assets.gen.dart';
import 'package:weather_overview/presentation/index.dart';

class HumidityIndicator extends StatelessWidget {
  const HumidityIndicator({
    required this.weatherPM,
    this.size = 64,
    super.key,
  });

  final WeatherPM weatherPM;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Column(
        children: [
          Expanded(child: Assets.icons.humidity.image()),
          SizedBox(
            height: 4,
          ),
          Text('${weatherPM.humidityPercent}%'),
        ],
      ),
    );
  }
}
