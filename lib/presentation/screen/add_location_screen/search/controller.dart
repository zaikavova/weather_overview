import 'package:flutter/cupertino.dart';

import 'search_request.dart';

class SearchController<T extends SearchRequest> extends ChangeNotifier {
  SearchController([T? value]) : _value = value;

  T? _value;

  T? get value => _value;

  set value(T? value) {
    if (_value != value) {
      _value = value;
      notifyListeners();
    }
  }

  void clear() => _value;
}
