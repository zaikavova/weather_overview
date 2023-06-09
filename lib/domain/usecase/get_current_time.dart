abstract class GetCurrentTime {
  Future<DateTime> call();
}

class GetDeviceCurrentTime implements GetCurrentTime {
  @override
  Future<DateTime> call() => Future.sync(() => DateTime.now());
}
