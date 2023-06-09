import 'dart:convert';

import 'package:weather_overview/assembly/factory.dart';
import 'package:weather_overview/generated/l10n.dart';

class CitiesFromJsonFactory implements Factory<String, List<String>> {
  @override
  List<String> create(String args) {
    final jsonData = (json.decode(args) as Map<String, dynamic>);
    if (jsonData['status'] == 'success') {
      return (jsonData['data'] as List<dynamic>)
          .map((e) => e['city'].toString())
          .toList();
    } else
      throw Exception(S.current.citiesNotAvailable);
  }
}
