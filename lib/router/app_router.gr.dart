// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:confession/confession/confession_page.dart' as _i2;
import 'package:confession/exam/presentation/ui/commandments_page.dart' as _i1;
import 'package:confession/exam/presentation/ui/examination_page/examination_page.dart'
    as _i3;
import 'package:confession/exam/presentation/ui/prayers_page.dart' as _i8;
import 'package:confession/guide/domain/entities/guide.dart' as _i13;
import 'package:confession/guide/presentation/ui/details_page/guide_detail_list.dart'
    as _i4;
import 'package:confession/guide/presentation/ui/details_page/guide_details_page.dart'
    as _i5;
import 'package:confession/guide/presentation/ui/guide_page.dart' as _i6;
import 'package:confession/prayers/domain/entities/prayer.dart' as _i14;
import 'package:confession/prayers/presentation/ui/details_page/prayer_details_page.dart'
    as _i7;
import 'package:confession/settings/settings_page.dart' as _i9;
import 'package:confession/shell/shell_page.dart' as _i10;
import 'package:flutter/material.dart' as _i12;

/// generated route for
/// [_i1.CommandmentsPage]
class CommandmentsRoute extends _i11.PageRouteInfo<void> {
  const CommandmentsRoute({List<_i11.PageRouteInfo>? children})
      : super(
          CommandmentsRoute.name,
          initialChildren: children,
        );

  static const String name = 'CommandmentsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i1.CommandmentsPage();
    },
  );
}

/// generated route for
/// [_i2.ConfessionPage]
class ConfessionRoute extends _i11.PageRouteInfo<void> {
  const ConfessionRoute({List<_i11.PageRouteInfo>? children})
      : super(
          ConfessionRoute.name,
          initialChildren: children,
        );

  static const String name = 'ConfessionRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i2.ConfessionPage();
    },
  );
}

/// generated route for
/// [_i3.ExaminationPage]
class ExaminationRoute extends _i11.PageRouteInfo<ExaminationRouteArgs> {
  ExaminationRoute({
    required int commandmentId,
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          ExaminationRoute.name,
          args: ExaminationRouteArgs(
            commandmentId: commandmentId,
            key: key,
          ),
          rawPathParams: {'commandmentId': commandmentId},
          initialChildren: children,
        );

  static const String name = 'ExaminationRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ExaminationRouteArgs>(
          orElse: () => ExaminationRouteArgs(
              commandmentId: pathParams.getInt('commandmentId')));
      return _i3.ExaminationPage(
        commandmentId: args.commandmentId,
        key: args.key,
      );
    },
  );
}

class ExaminationRouteArgs {
  const ExaminationRouteArgs({
    required this.commandmentId,
    this.key,
  });

  final int commandmentId;

  final _i12.Key? key;

  @override
  String toString() {
    return 'ExaminationRouteArgs{commandmentId: $commandmentId, key: $key}';
  }
}

/// generated route for
/// [_i4.GuideDetailListPage]
class GuideDetailListRoute
    extends _i11.PageRouteInfo<GuideDetailListRouteArgs> {
  GuideDetailListRoute({
    required int guideId,
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          GuideDetailListRoute.name,
          args: GuideDetailListRouteArgs(
            guideId: guideId,
            key: key,
          ),
          rawPathParams: {'guideId': guideId},
          initialChildren: children,
        );

  static const String name = 'GuideDetailListRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<GuideDetailListRouteArgs>(
          orElse: () =>
              GuideDetailListRouteArgs(guideId: pathParams.getInt('guideId')));
      return _i4.GuideDetailListPage(
        guideId: args.guideId,
        key: args.key,
      );
    },
  );
}

class GuideDetailListRouteArgs {
  const GuideDetailListRouteArgs({
    required this.guideId,
    this.key,
  });

  final int guideId;

  final _i12.Key? key;

  @override
  String toString() {
    return 'GuideDetailListRouteArgs{guideId: $guideId, key: $key}';
  }
}

/// generated route for
/// [_i5.GuideDetailsPage]
class GuideDetailsRoute extends _i11.PageRouteInfo<GuideDetailsRouteArgs> {
  GuideDetailsRoute({
    required _i13.Guide guide,
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          GuideDetailsRoute.name,
          args: GuideDetailsRouteArgs(
            guide: guide,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'GuideDetailsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GuideDetailsRouteArgs>();
      return _i5.GuideDetailsPage(
        guide: args.guide,
        key: args.key,
      );
    },
  );
}

class GuideDetailsRouteArgs {
  const GuideDetailsRouteArgs({
    required this.guide,
    this.key,
  });

  final _i13.Guide guide;

  final _i12.Key? key;

  @override
  String toString() {
    return 'GuideDetailsRouteArgs{guide: $guide, key: $key}';
  }
}

/// generated route for
/// [_i6.GuidePage]
class GuideRoute extends _i11.PageRouteInfo<void> {
  const GuideRoute({List<_i11.PageRouteInfo>? children})
      : super(
          GuideRoute.name,
          initialChildren: children,
        );

  static const String name = 'GuideRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i6.GuidePage();
    },
  );
}

/// generated route for
/// [_i7.PrayerDetailsPage]
class PrayerDetailsRoute extends _i11.PageRouteInfo<PrayerDetailsRouteArgs> {
  PrayerDetailsRoute({
    required _i14.Prayer prayer,
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          PrayerDetailsRoute.name,
          args: PrayerDetailsRouteArgs(
            prayer: prayer,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'PrayerDetailsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PrayerDetailsRouteArgs>();
      return _i7.PrayerDetailsPage(
        prayer: args.prayer,
        key: args.key,
      );
    },
  );
}

class PrayerDetailsRouteArgs {
  const PrayerDetailsRouteArgs({
    required this.prayer,
    this.key,
  });

  final _i14.Prayer prayer;

  final _i12.Key? key;

  @override
  String toString() {
    return 'PrayerDetailsRouteArgs{prayer: $prayer, key: $key}';
  }
}

/// generated route for
/// [_i8.PrayersPage]
class PrayersRoute extends _i11.PageRouteInfo<void> {
  const PrayersRoute({List<_i11.PageRouteInfo>? children})
      : super(
          PrayersRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrayersRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i8.PrayersPage();
    },
  );
}

/// generated route for
/// [_i9.SettingsPage]
class SettingsRoute extends _i11.PageRouteInfo<void> {
  const SettingsRoute({List<_i11.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i9.SettingsPage();
    },
  );
}

/// generated route for
/// [_i10.ShellPage]
class ShellRoute extends _i11.PageRouteInfo<ShellRouteArgs> {
  ShellRoute({
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          ShellRoute.name,
          args: ShellRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ShellRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<ShellRouteArgs>(orElse: () => const ShellRouteArgs());
      return _i10.ShellPage(key: args.key);
    },
  );
}

class ShellRouteArgs {
  const ShellRouteArgs({this.key});

  final _i12.Key? key;

  @override
  String toString() {
    return 'ShellRouteArgs{key: $key}';
  }
}
