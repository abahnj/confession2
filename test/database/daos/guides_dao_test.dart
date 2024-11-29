import 'package:confession/data/datasources/local/database_source.dart';
import 'package:confession/database/app_database.dart';
import 'package:confession/database/daos/guides_dao.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDatabaseSource extends Mock implements DatabaseSource {}

void main() {
  late AppDatabase database;
  late GuidesDao dao;
  late _MockDatabaseSource mockDatabaseSource;

  setUp(() async {
    await AppDatabase.resetInstance();
    mockDatabaseSource = _MockDatabaseSource();
    database = AppDatabase.instance(
      databaseSource: mockDatabaseSource,
      executor: NativeDatabase.memory(),
    );
    dao = GuidesDao(database);
  });

  tearDown(() async {
    await database.close();
    await AppDatabase.resetInstance();
  });

  group('GuidesDao - Basic Operations', () {
    test('getAllGuides returns empty list when database is empty', () async {
      final results = await dao.getAllGuides();
      expect(results, isEmpty);
    });

    test('getAllGuides returns all inserted guides', () async {
      // Arrange
      final testGuides = [
        GuidesTableCompanion.insert(
          guideTitle: 'Guide 1',
          guideText: 'Text 1',
          headerId: 1,
        ),
        GuidesTableCompanion.insert(
          guideTitle: 'Guide 2',
          guideText: 'Text 2',
          headerId: 1,
        ),
      ];

      // Act
      await Future.wait(
        testGuides
            .map((guide) => database.into(database.guidesTable).insert(guide)),
      );
      final results = await dao.getAllGuides();

      // Assert
      expect(results.length, 2);
      expect(
        results.map((g) => g.guideTitle).toList(),
        ['Guide 1', 'Guide 2'],
      );
    });

    test('getAllGuides preserves order of insertion', () async {
      // Arrange
      final testGuides = List.generate(
        5,
        (index) => GuidesTableCompanion.insert(
          guideTitle: 'Guide ${index + 1}',
          guideText: 'Text ${index + 1}',
          headerId: 1,
        ),
      );

      // Act
      await Future.wait(
        testGuides
            .map((guide) => database.into(database.guidesTable).insert(guide)),
      );
      final results = await dao.getAllGuides();

      // Assert
      expect(results.length, 5);
      for (var i = 0; i < results.length; i++) {
        expect(results[i].guideTitle, 'Guide ${i + 1}');
        expect(results[i].guideText, 'Text ${i + 1}');
      }
    });
  });

  group('GuidesDao - getGuidesForId', () {
    test('getGuidesForId returns empty list when no matching guides exist',
        () async {
      final results = await dao.getGuidesForId(1);
      expect(results, isEmpty);
    });

    test('getGuidesForId returns only guides with matching headerId', () async {
      // Arrange
      final testGuides = [
        GuidesTableCompanion.insert(
          guideTitle: 'Guide 1',
          guideText: 'Text 1',
          headerId: 1,
        ),
        GuidesTableCompanion.insert(
          guideTitle: 'Guide 2',
          guideText: 'Text 2',
          headerId: 2,
        ),
        GuidesTableCompanion.insert(
          guideTitle: 'Guide 3',
          guideText: 'Text 3',
          headerId: 1,
        ),
      ];

      await Future.wait(
        testGuides
            .map((guide) => database.into(database.guidesTable).insert(guide)),
      );

      // Act
      final resultsForHeader1 = await dao.getGuidesForId(1);
      final resultsForHeader2 = await dao.getGuidesForId(2);

      // Assert
      expect(resultsForHeader1.length, 2);
      expect(resultsForHeader2.length, 1);
      expect(
        resultsForHeader1.every((guide) => guide.headerId == 1),
        true,
      );
      expect(resultsForHeader2.first.headerId, 2);
    });

    test('getGuidesForId returns empty list for non-existent headerId',
        () async {
      // Arrange
      final guide = GuidesTableCompanion.insert(
        guideTitle: 'Guide 1',
        guideText: 'Text 1',
        headerId: 1,
      );
      await database.into(database.guidesTable).insert(guide);

      // Act
      final results = await dao.getGuidesForId(999);

      // Assert
      expect(results, isEmpty);
    });
  });

  group('GuidesDao - Edge Cases and Data Integrity', () {
    test('handles guides with same title but different headerIds correctly',
        () async {
      // Arrange
      final testGuides = [
        GuidesTableCompanion.insert(
          guideTitle: 'Same Title',
          guideText: 'Text 1',
          headerId: 1,
        ),
        GuidesTableCompanion.insert(
          guideTitle: 'Same Title',
          guideText: 'Text 2',
          headerId: 2,
        ),
      ];

      await Future.wait(
        testGuides
            .map((guide) => database.into(database.guidesTable).insert(guide)),
      );

      // Act
      final allGuides = await dao.getAllGuides();
      final guidesForHeader1 = await dao.getGuidesForId(1);
      final guidesForHeader2 = await dao.getGuidesForId(2);

      // Assert
      expect(allGuides.length, 2);
      expect(guidesForHeader1.length, 1);
      expect(guidesForHeader2.length, 1);
      expect(guidesForHeader1.first.guideText, 'Text 1');
      expect(guidesForHeader2.first.guideText, 'Text 2');
    });

    test('handles large number of guides efficiently', () async {
      // Arrange
      const largeNumber = 1000;
      final testGuides = List.generate(
        largeNumber,
        (index) => GuidesTableCompanion.insert(
          guideTitle: 'Guide $index',
          guideText: 'Text $index',
          headerId: index % 10, // Distribute across 10 headers
        ),
      );

      // Act
      await Future.wait(
        testGuides
            .map((guide) => database.into(database.guidesTable).insert(guide)),
      );

      final allGuides = await dao.getAllGuides();
      final guidesForHeader0 = await dao.getGuidesForId(0);

      // Assert
      expect(allGuides.length, largeNumber);
      expect(guidesForHeader0.length, largeNumber ~/ 10);
    });

    test('maintains data integrity with special characters in text', () async {
      // Arrange
      final specialCharGuide = GuidesTableCompanion.insert(
        guideTitle: 'Guide with 特殊文字 and émojis 🎉',
        guideText: '''
Multiple
          lines with "quotes"
          and 'apostrophes'
          and špécial čhars''',
        headerId: 1,
      );

      // Act
      await database.into(database.guidesTable).insert(specialCharGuide);
      final result = (await dao.getGuidesForId(1)).first;

      // Assert
      expect(result.guideTitle, 'Guide with 特殊文字 and émojis 🎉');
      expect(result.guideText, contains('špécial čhars'));
    });
  });

  group('GuidesDao - Performance Tests', () {
    test('batch operations complete within reasonable time', () async {
      final stopwatch = Stopwatch()..start();

      // Insert 100 guides
      await Future.wait(
        List.generate(
          100,
          (index) => database.into(database.guidesTable).insert(
                GuidesTableCompanion.insert(
                  guideTitle: 'Guide $index',
                  guideText: 'Text $index',
                  headerId: index % 10,
                ),
              ),
        ),
      );

      stopwatch.stop();
      final insertTime = stopwatch.elapsedMilliseconds;

      stopwatch
        ..reset()
        ..start();

      // Fetch all guides
      await dao.getAllGuides();

      stopwatch.stop();
      final fetchAllTime = stopwatch.elapsedMilliseconds;

      stopwatch
        ..reset()
        ..start();

      // Fetch guides for specific header
      await dao.getGuidesForId(1);

      stopwatch.stop();
      final fetchFilteredTime = stopwatch.elapsedMilliseconds;

      // Log performance metrics
      printOnFailure(
        'Performance Metrics:\n'
        'Insert 100 guides: ${insertTime}ms\n'
        'Fetch all guides: ${fetchAllTime}ms\n'
        'Fetch filtered guides: ${fetchFilteredTime}ms',
      );

      // Assert reasonable performance
      expect(insertTime, lessThan(1000)); // Less than 1 second
      expect(fetchAllTime, lessThan(500)); // Less than 500ms
      expect(fetchFilteredTime, lessThan(100)); // Less than 100ms
    });
  });
}
