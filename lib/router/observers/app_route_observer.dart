import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class AppRouteObserver extends AutoRouterObserver {
  @override
  void didPush(Route<Object?> route, Route<Object?>? previousRoute) {
    log('New route pushed: ${route.data?.path}');
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    log('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    FirebaseCrashlytics.instance.log('route changed to ${route.name}');

    log('Tab route re-visited: ${route.name}');
  }

  @override
  void didPop(Route<Object?> route, Route<Object?>? previousRoute) {
    log('Route popped: ${route.data?.path}');
  }
}
