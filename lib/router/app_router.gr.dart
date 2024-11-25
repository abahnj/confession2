// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:confession/confession/confession_page.dart' as _i1;
import 'package:confession/exam/exam_page.dart' as _i2;
import 'package:confession/guide/guide_page.dart' as _i3;
import 'package:confession/prayers/prayers_page.dart' as _i4;
import 'package:confession/settings/settings_page.dart' as _i5;
import 'package:confession/shell/shell_page.dart' as _i6;
import 'package:flutter/material.dart' as _i8;

/// generated route for
/// [_i1.ConfessionPage]
class ConfessionRoute extends _i7.PageRouteInfo<void> {
  const ConfessionRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ConfessionRoute.name,
          initialChildren: children,
        );

  static const String name = 'ConfessionRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.ConfessionPage();
    },
  );
}

/// generated route for
/// [_i2.ExaminationPage]
class ExaminationRoute extends _i7.PageRouteInfo<void> {
  const ExaminationRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ExaminationRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExaminationRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.ExaminationPage();
    },
  );
}

/// generated route for
/// [_i3.GuidePage]
class GuideRoute extends _i7.PageRouteInfo<void> {
  const GuideRoute({List<_i7.PageRouteInfo>? children})
      : super(
          GuideRoute.name,
          initialChildren: children,
        );

  static const String name = 'GuideRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.GuidePage();
    },
  );
}

/// generated route for
/// [_i4.PrayersPage]
class PrayersRoute extends _i7.PageRouteInfo<void> {
  const PrayersRoute({List<_i7.PageRouteInfo>? children})
      : super(
          PrayersRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrayersRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.PrayersPage();
    },
  );
}

/// generated route for
/// [_i5.SettingsPage]
class SettingsRoute extends _i7.PageRouteInfo<void> {
  const SettingsRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.SettingsPage();
    },
  );
}

/// generated route for
/// [_i6.ShellPage]
class ShellRoute extends _i7.PageRouteInfo<ShellRouteArgs> {
  ShellRoute({
    _i8.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          ShellRoute.name,
          args: ShellRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ShellRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<ShellRouteArgs>(orElse: () => const ShellRouteArgs());
      return _i6.ShellPage(key: args.key);
    },
  );
}

class ShellRouteArgs {
  const ShellRouteArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'ShellRouteArgs{key: $key}';
  }
}
