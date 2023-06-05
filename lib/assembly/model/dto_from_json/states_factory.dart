import 'dart:async';
import 'dart:convert';

import 'package:weather_overview/assembly/factory.dart';

class StatesFromJsonFactory
    implements Factory<String, List<String>> {
  @override
  FutureOr<List<String>> create(String args) =>
      ((json.decode(args)as Map<String,dynamic>)['data'] as List<dynamic>)
          .map((e) => e['state'].toString())
          .toList();
}
