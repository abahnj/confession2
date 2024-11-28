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
              page: const EmptyShellRoute('Examination'),
              initial: true,
              children: [
                AutoRoute(
                  page: ExaminationRoute.page,
                  title: (context, data) => 'Examination',
                  path: '',
                ),
              ],
            ),
            AutoRoute(
              path: 'confession',
              page: const EmptyShellRoute('Confession'),
              children: [
                AutoRoute(
                  page: ConfessionRoute.page,
                  title: (context, data) => 'Confession',
                  path: '',
                ),
              ],
            ),
            AutoRoute(
              path: 'guide',
              page: const EmptyShellRoute('Guide'),
              children: [
                AutoRoute(
                  page: GuideRoute.page,
                  title: (context, data) => 'Guide',
                  path: '',
                ),
                AutoRoute(
                  path: ':guideId',
                  page: GuideDetailListRoute.page,
                ),
              ],
            ),
            AutoRoute(
              path: 'prayers',
              page: const EmptyShellRoute('Prayers'),
              children: [
                AutoRoute(
                  page: PrayersRoute.page,
                  title: (context, data) => 'Prayers',
                  path: '',
                ),
                AutoRoute(
                  path: 'details',
                  page: PrayerDetailsRoute.page,
                  title: (context, data) => 'Prayer Details',
                ),
              ],
            ),
          ],
        ),
        AutoRoute(path: '/settings', page: SettingsRoute.page),
      ];
}
