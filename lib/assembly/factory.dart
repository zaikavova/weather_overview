import 'dart:async';

abstract class Factory<In, Out> {
  FutureOr<Out> create(In args);
}
