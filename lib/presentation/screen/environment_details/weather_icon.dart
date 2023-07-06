import 'package:flutter/cupertino.dart';
import 'package:weather_overview/domain/index.dart';
import 'package:weather_overview/gen/assets.gen.dart';

class WeatherIndicatorIconWidget extends StatelessWidget {
  const WeatherIndicatorIconWidget(
      {super.key, required this.indicator, this.size = 64});

  final WeatherVisualIndicator indicator;
  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: size,
        width: size,
        child: _getImage(),
      );

  Image _getImage() {
    switch (indicator) {
      case WeatherVisualIndicator.clearSkyDay:
        return Assets.icons.a01d.image();
      case WeatherVisualIndicator.clearSkyNight:
        return Assets.icons.a01n.image();
      case WeatherVisualIndicator.fewCloudsDay:
        return Assets.icons.a02d.image();
      case WeatherVisualIndicator.fewCloudsNight:
        return Assets.icons.a02n.image();
      case WeatherVisualIndicator.scatteredClouds:
        return Assets.icons.a03d.image();
      case WeatherVisualIndicator.scatteredCloudsNight:
        //TODO(Volodymyr): Watch AirVisualApi for update of docs
        return Assets.icons.a03d.image();
      case WeatherVisualIndicator.brokenClouds:
        return Assets.icons.a04d.image();
      case WeatherVisualIndicator.showerRain:
        return Assets.icons.a09d.image();
      case WeatherVisualIndicator.rainDay:
        return Assets.icons.a10n.image();
      case WeatherVisualIndicator.rainNight:
        return Assets.icons.a10d.image();
      case WeatherVisualIndicator.thunderstorm:
        return Assets.icons.a11d.image();
      case WeatherVisualIndicator.snow:
        return Assets.icons.a13d.image();
      case WeatherVisualIndicator.mist:
        return Assets.icons.a50d.image();
    }
  }
}
