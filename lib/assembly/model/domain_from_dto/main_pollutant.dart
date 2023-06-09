import 'package:weather_overview/assembly/index.dart';

import '../../../data/index.dart';
import '../../../domain/index.dart';

class MainPollutantFromDtoFactory
    implements Factory<MainPollutantDto, MainPollutant> {
  @override
  MainPollutant create(MainPollutantDto args) {
    switch (args) {
      case MainPollutantDto.Particles25:
        return MainPollutant.Particles25;
      case MainPollutantDto.Particles100:
        return MainPollutant.Particles100;
      case MainPollutantDto.Ozone:
        return MainPollutant.Ozone;
      case MainPollutantDto.NitrogenDioxide:
        return MainPollutant.NitrogenDioxide;
      case MainPollutantDto.SulfurDioxide:
        return MainPollutant.SulfurDioxide;
      case MainPollutantDto.CarbonMonoxide:
        return MainPollutant.CarbonMonoxide;
    }
  }
}
