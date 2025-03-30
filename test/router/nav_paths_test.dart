import 'package:confession/router/nav_paths.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NavPath', () {
    test('has correct path values', () {
      // Verify that all NavPath enums have the expected path value
      expect(NavPath.examination.path, equals('/exam'));
      expect(NavPath.examinationDetail.path, equals('/exam/:commandmentId'));
      expect(NavPath.confession.path, equals('/confession'));
      expect(NavPath.guide.path, equals('/guide'));
      expect(NavPath.guideDetailList.path, equals('/guide/:guideId'));
      expect(NavPath.guideDetails.path, equals('/guide/:guideId/details'));
      expect(NavPath.prayers.path, equals('/prayers'));
      expect(NavPath.prayerDetails.path, equals('/prayers/details'));
      expect(NavPath.settings.path, equals('/settings'));
    });

    test('has correct name values', () {
      // Verify that all NavPath enums have the expected name value
      expect(NavPath.examination.name, equals('Examination'));
      expect(NavPath.examinationDetail.name, equals('Examination Detail'));
      expect(NavPath.confession.name, equals('Confession'));
      expect(NavPath.guide.name, equals('Guide'));
      expect(NavPath.guideDetailList.name, equals('Guide Detail List'));
      expect(NavPath.guideDetails.name, equals('Guide Details'));
      expect(NavPath.prayers.name, equals('Prayers'));
      expect(NavPath.prayerDetails.name, equals('Prayer Details'));
      expect(NavPath.settings.name, equals('Settings'));
    });

    test('examinationDetailPath generates correct path with id', () {
      expect(NavPath.examinationDetailPath(1), equals('/exam/1'));
      expect(NavPath.examinationDetailPath(42), equals('/exam/42'));
    });

    test('guideDetailListPath generates correct path with id', () {
      expect(NavPath.guideDetailListPath(1), equals('/guide/1'));
      expect(NavPath.guideDetailListPath(42), equals('/guide/42'));
    });

    test('guideDetailsPath generates correct path with id', () {
      expect(NavPath.guideDetailsPath(1), equals('/guide/1/details'));
      expect(NavPath.guideDetailsPath(42), equals('/guide/42/details'));
    });
  });
}
