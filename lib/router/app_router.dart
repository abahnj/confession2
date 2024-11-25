import 'package:auto_route/auto_route.dart';
import 'package:confession/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: ShellRoute.page,
          children: [
            AutoRoute(path: '', page: PrayersRoute.page),
            AutoRoute(path: 'guide', page: GuideRoute.page),
            AutoRoute(path: 'exam', page: ExaminationRoute.page),
            AutoRoute(path: 'confession', page: ConfessionRoute.page),
          ],
        ),
      ];
}
