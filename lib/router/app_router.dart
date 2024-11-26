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
          fullMatch: true,
          children: [
            AutoRoute(
              path: 'exam',
              page: ExaminationRoute.page,
              title: (context, data) => 'Examination',
              initial: true,
            ),
            AutoRoute(
              path: 'prayers',
              page: PrayersRoute.page,
              title: (context, data) => 'Prayers',
            ),
            AutoRoute(
              path: 'guide',
              page: GuideRoute.page,
              title: (context, data) => 'Guide',
            ),
            AutoRoute(
              path: 'confession',
              page: ConfessionRoute.page,
              title: (context, data) => 'Confession',
            ),
          ],
        ),
        AutoRoute(path: '/settings', page: SettingsRoute.page),
      ];
}
