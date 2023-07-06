abstract class RegisteredException implements Exception {
  RegisteredException(this.message, {this.rawMessage});

  final String message;
  final String? rawMessage;

  @override
  String toString() => message;
}
