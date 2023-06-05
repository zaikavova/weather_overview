import 'package:auto_route/auto_route.dart';
import 'package:weather_overview/presentation/index.dart';

part 'router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen,Route',
  generateForDir: ['lib/presentation'],
)
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MainRoute.page,
        ),
        AutoRoute(
          page: MainRoute.page,
        ),
        AutoRoute(
          page: LocationDetailsRoute.page,
        ),
      ];
}
