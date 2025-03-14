import 'dart:developer';

import 'package:confession/exam/presentation/ui/commandments_page.dart';
import 'package:confession/exam/presentation/ui/examination_page/examination_page.dart';
import 'package:confession/confession/presentation/ui/confession_page.dart';
import 'package:confession/guide/presentation/ui/details_page/guide_detail_list.dart';
import 'package:confession/guide/presentation/ui/details_page/guide_details_page.dart';
import 'package:confession/guide/presentation/ui/guide_page.dart';
import 'package:confession/l10n/l10n.dart';
import 'package:confession/prayers/presentation/ui/details_page/prayer_details_page.dart';
import 'package:confession/prayers/presentation/ui/prayers_page.dart';
import 'package:confession/settings/settings_page.dart';
import 'package:confession/shell/shell_page.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final navigationKey = GlobalKey<NavigatorState>();

// This class handles the app's navigation structure
class AppRouter {
  AppRouter();

  late final GoRouter router = GoRouter(
    navigatorKey: navigationKey,
    initialLocation: '/exam',
    debugLogDiagnostics: true,
    observers: [AppRouteObserver()],
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return ShellPageWrapper(child: child);
        },
        routes: [
          // Examination routes
          GoRoute(
            path: '/exam',
            name: 'examination',
            pageBuilder: (context, state) => NoTransitionPage(
              child: CommandmentsPage(),
              name: 'Examination',
            ),
            routes: [
              GoRoute(
                path: ':commandmentId',
                name: 'examination_detail',
                pageBuilder: (context, state) {
                  final commandmentId = state.pathParameters['commandmentId'] ?? '';
                  return NoTransitionPage(
                    child: ExaminationPage(
                      commandmentId: int.tryParse(commandmentId) ?? 0,
                    ),
                    name: 'Examination Detail',
                  );
                },
              ),
            ],
          ),
          
          // Confession routes
          GoRoute(
            path: '/confession',
            name: 'confession',
            pageBuilder: (context, state) => NoTransitionPage(
              child: ConfessionPage(),
              name: 'Confession',
            ),
          ),
          
          // Guide routes
          GoRoute(
            path: '/guide',
            name: 'guide',
            pageBuilder: (context, state) => NoTransitionPage(
              child: GuidePage(),
              name: 'Guide',
            ),
            routes: [
              GoRoute(
                path: ':guideId',
                name: 'guide_detail_list',
                pageBuilder: (context, state) {
                  final guideId = state.pathParameters['guideId'] ?? '';
                  return NoTransitionPage(
                    child: GuideDetailList(
                      guideId: int.tryParse(guideId) ?? 0,
                    ),
                    name: 'Guide Detail List',
                  );
                },
                routes: [
                  GoRoute(
                    path: 'details',
                    name: 'guide_details',
                    pageBuilder: (context, state) {
                      final guideId = state.pathParameters['guideId'] ?? '';
                      return NoTransitionPage(
                        child: GuideDetailsPage(
                          guideId: int.tryParse(guideId) ?? 0,
                        ),
                        name: 'Guide Details',
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          
          // Prayers routes
          GoRoute(
            path: '/prayers',
            name: 'prayers',
            pageBuilder: (context, state) => NoTransitionPage(
              child: PrayersPage(),
              name: 'Prayers',
            ),
            routes: [
              GoRoute(
                path: 'details',
                name: 'prayer_details',
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: PrayerDetailsPage(),
                    name: 'Prayer Details',
                  );
                },
              ),
            ],
          ),
        ],
      ),
      
      // Settings route (outside shell)
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
    ],
  );
}

// Route observer that logs navigation events
class AppRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('New route pushed: ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('Route popped: ${route.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    log('Route replaced: ${newRoute?.settings.name}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    FirebaseCrashlytics.instance.log('Route removed: ${route.settings.name}');
    log('Route removed: ${route.settings.name}');
  }
}