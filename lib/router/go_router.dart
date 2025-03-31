import 'package:confession/confession/presentation/ui/confession_page.dart';
import 'package:confession/exam/presentation/ui/commandments_page.dart';
import 'package:confession/exam/presentation/ui/examination_page/examination_page.dart';
import 'package:confession/guide/domain/entities/guide.dart';
import 'package:confession/guide/presentation/ui/details_page/guide_detail_list.dart';
import 'package:confession/guide/presentation/ui/details_page/guide_details_page.dart';
import 'package:confession/guide/presentation/ui/guide_page.dart';
import 'package:confession/prayers/domain/entities/prayer.dart';
import 'package:confession/prayers/presentation/ui/responsive_prayers_page.dart';
import 'package:confession/router/nav_paths.dart';
import 'package:confession/router/observers/app_route_observer.dart';
import 'package:confession/settings/settings_page.dart';
import 'package:confession/shell/shell_page_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final navigationKey = GlobalKey<NavigatorState>();
final _shellNavigatorExamKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellExam');
final _shellNavigatorConfessionKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellConfession');
final _shellNavigatorGuideKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellGuide');
final _shellNavigatorPrayersKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellPrayers');

// This class handles the app's navigation structure
class AppRouter {
  AppRouter();

  late final GoRouter router = GoRouter(
    navigatorKey: navigationKey,
    initialLocation: NavPath.examination.path,
    debugLogDiagnostics: true,
    observers: [AppRouteObserver()],
    routes: [
      // Stateful shell route with nested branches for each tab
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ShellPageWrapper(navigationShell: navigationShell);
        },
        branches: [
          // Examination branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorExamKey,
            routes: [
              GoRoute(
                path: NavPath.examination.path, 
                name: NavPath.examination.path,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: const CommandmentsPage(),
                  name: NavPath.examination.name,
                ),
                routes: [
                  GoRoute(
                    path: ':commandmentId',
                    name: NavPath.examinationDetail.path,
                    builder: (context, state) {
                      final commandmentId =
                          state.pathParameters['commandmentId'] ?? '';
                      return ExaminationPage(
                        commandmentId: int.tryParse(commandmentId) ?? 0,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          // Confession branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorConfessionKey,
            routes: [
              GoRoute(
                path: NavPath.confession.path,
                name: NavPath.confession.path,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: const ConfessionPage(),
                  name: NavPath.confession.name,
                ),
              ),
            ],
          ),

          // Guide branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorGuideKey,
            routes: [
              GoRoute(
                path: NavPath.guide.path,
                name: NavPath.guide.path,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: const GuidePage(),
                  name: NavPath.guide.name,
                ),
                routes: [
                  GoRoute(
                    path: ':guideId',
                    name: NavPath.guideDetailList.path,
                    builder: (context, state) {
                      final guideId = state.pathParameters['guideId'] ?? '';
                      return GuideDetailListPage(
                        guideId: int.tryParse(guideId) ?? 0,
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'details',
                        name: NavPath.guideDetails.path,
                        builder: (context, state) {
                          final guide = state.extra! as Guide;
                          return GuideDetailsPage(
                            guide: guide,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // Prayers branch - using responsive layout
          StatefulShellBranch(
            navigatorKey: _shellNavigatorPrayersKey,
            routes: [
              GoRoute(
                path: NavPath.prayers.path,
                name: NavPath.prayers.path,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: const ResponsivePrayersPage(),
                  name: NavPath.prayers.name,
                ),
                routes: [
                  GoRoute(
                    path: ':prayerId',
                    name: NavPath.prayerDetails.path,
                    builder: (context, state) {
                      final prayerId = int.tryParse(state.pathParameters['prayerId'] ?? '') ?? 0;
                      // If we have the prayer object in extra, use it
                      // otherwise, the controller will load it from the ID
                      final prayer = state.extra as Prayer?;
                      return ResponsivePrayersPage(
                        selectedPrayerId: prayerId,
                        selectedPrayer: prayer,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      // Settings route (outside shell)
      GoRoute(
        path: NavPath.settings.path,
        name: NavPath.settings.path,
        pageBuilder: (context, state) => NoTransitionPage(
          child: const SettingsPage(),
          name: NavPath.settings.name,
        ),
      ),
    ],
  );
}
