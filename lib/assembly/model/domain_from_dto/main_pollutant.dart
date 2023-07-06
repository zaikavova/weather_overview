import 'package:weather_overview/assembly/index.dart';

import '../../../data/index.dart';
import '../../../domain/index.dart';

class MainPollutantFromDtoFactory
    implements Factory<MainPollutantDto, MainPollutant> {
  @override
  MainPollutant create(MainPollutantDto args) {
    switch (args) {
      case MainPollutantDto.particles25:
        return MainPollutant.particles25;
      case MainPollutantDto.particles100:
        return MainPollutant.particles100;
      case MainPollutantDto.ozone:
        return MainPollutant.ozone;
      case MainPollutantDto.nitrogenDioxide:
        return MainPollutant.nitrogenDioxide;
      case MainPollutantDto.sulfurDioxide:
        return MainPollutant.sulfurDioxide;
      case MainPollutantDto.carbonMonoxide:
        return MainPollutant.carbonMonoxide;
    }
  }
}
