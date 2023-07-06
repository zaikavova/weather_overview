import 'package:flutter/material.dart';
import 'package:weather_overview/domain/index.dart';
import 'package:weather_overview/gen/assets.gen.dart';
import 'package:weather_overview/generated/l10n.dart';
import 'package:weather_overview/presentation/index.dart';

class MainPollutantIndicator extends StatelessWidget {
  const MainPollutantIndicator(
      {super.key, required this.airConditionPM, this.size = 64});

  final AirConditionPM airConditionPM;
  final double size;

  @override
  Widget build(BuildContext context) {
    late final Widget icon;
    final ThemeData theme = Theme.of(context);
    final Color iconColor = theme.colorScheme.onSurface;
    switch (airConditionPM.mainPollutant) {
      case MainPollutant.particles25:
        icon = Assets.icons.pm25.image(color: iconColor);
        break;
      case MainPollutant.particles100:
        icon = Assets.icons.pm100.image(color: iconColor);
        break;
      case MainPollutant.ozone:
        icon = Assets.icons.ozone.image(color: iconColor);
        break;
      case MainPollutant.nitrogenDioxide:
        icon = Assets.icons.nitrus.image(color: iconColor);
        break;
      case MainPollutant.sulfurDioxide:
        icon = Assets.icons.sulfurDioxide.image(color: iconColor);
        break;
      case MainPollutant.carbonMonoxide:
        icon = Assets.icons.carbonMonooxide.image(color: iconColor);
        break;
    }
    return SizedBox(
      height: size,
      width: size,
      child: Column(
        children: [
          Expanded(child: icon),
          Text(S.of(context).mainPollutant),
        ],
      ),
    );
  }
}
