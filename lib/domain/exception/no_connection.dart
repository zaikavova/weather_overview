import 'index.dart';

class NoConnectionException extends RegisteredException {
  NoConnectionException(super.message, {super.rawMessage});
}
