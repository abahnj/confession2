import 'package:confession/data/datasources/local/database_source.dart';
import 'package:confession/database/app_database.dart';
import 'package:confession/database/daos/prayers_dao.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDatabaseSource extends Mock implements DatabaseSource {}

void main() {
  late AppDatabase database;
  late PrayersDao dao;
  late _MockDatabaseSource mockDatabaseSource;

  setUp(() async {
    mockDatabaseSource = _MockDatabaseSource();
    database = AppDatabase(
      databaseSource: mockDatabaseSource,
      executor: NativeDatabase.memory(),
    );
    dao = PrayersDao(database);
  });

  tearDown(() async {
    await database.close();
  });

  group('PrayersDao - Prayer Operations', () {
    test('getAllPrayers returns empty list when database is empty', () async {
      final results = await dao.getAllPrayers();
      expect(results, isEmpty);
    });

    test('getAllPrayers returns all inserted prayers', () async {
      // Arrange
      final testPrayers = [
        PrayersTableCompanion.insert(
          prayerName: 'Prayer 1',
          prayerText: 'Text 1',
          groupName: 'Group A',
        ),
        PrayersTableCompanion.insert(
          prayerName: 'Prayer 2',
          prayerText: 'Text 2',
          groupName: 'Group B',
        ),
      ];

      await Future.wait(
        testPrayers.map(
          (prayer) => database.into(database.prayersTable).insert(prayer),
        ),
      );

      // Act
      final results = await dao.getAllPrayers();

      // Assert
      expect(results.length, 2);
      expect(
        results.map((p) => p.prayerName).toList(),
        ['Prayer 1', 'Prayer 2'],
      );
      expect(
        results.map((p) => p.groupName).toList(),
        ['Group A', 'Group B'],
      );
    });

    test('getPrayerForId returns correct prayer', () async {
      // Arrange
      final prayer = PrayersTableCompanion.insert(
        prayerName: 'Test Prayer',
        prayerText: 'Prayer Text',
        groupName: 'Test Group',
      );
      final id = await database.into(database.prayersTable).insert(prayer);

      // Act
      final result = await dao.getPrayerForId(id);

      // Assert
      expect(result.id, id);
      expect(result.prayerName, 'Test Prayer');
      expect(result.prayerText, 'Prayer Text');
      expect(result.groupName, 'Test Group');
    });

    test('getPrayerForId throws StateError for non-existent id', () async {
      expect(
        () => dao.getPrayerForId(999),
        throwsStateError,
      );
    });
  });

  group('PrayersDao - Inspiration Operations', () {
    test('getInspirationForId returns correct inspiration', () async {
      // Arrange
      final inspiration = InspirationsTableCompanion.insert(
        author: 'Test Author',
        quote: 'Test Quote',
      );
      final id =
          await database.into(database.inspirationsTable).insert(inspiration);

      // Act
      final result = await dao.getInspirationForId(id);

      // Assert
      expect(result.id, id);
      expect(result.author, 'Test Author');
      expect(result.quote, 'Test Quote');
    });

    test('getInspirationForId throws StateError for non-existent id', () async {
      expect(
        () => dao.getInspirationForId(999),
        throwsStateError,
      );
    });
  });

  group('PrayersDao - Edge Cases', () {
    test('handles prayers with special characters correctly', () async {
      // Arrange
      final prayer = PrayersTableCompanion.insert(
        prayerName: 'Prayer with 特殊文字',
        prayerText: '''
Multiple
          lines with "quotes"
          and 'apostrophes'
          and špécial čhars''',
        groupName: 'Special Group 🙏',
      );

      final id = await database.into(database.prayersTable).insert(prayer);

      // Act
      final result = await dao.getPrayerForId(id);

      // Assert
      expect(result.prayerName, 'Prayer with 特殊文字');
      expect(result.prayerText, contains('špécial čhars'));
      expect(result.groupName, 'Special Group 🙏');
    });

    test('handles empty prayer text and group name', () async {
      // Arrange
      final prayer = PrayersTableCompanion.insert(
        prayerName: 'Empty Prayer',
        prayerText: '',
        groupName: '',
      );

      final id = await database.into(database.prayersTable).insert(prayer);

      // Act
      final result = await dao.getPrayerForId(id);

      // Assert
      expect(result.prayerText, isEmpty);
      expect(result.groupName, isEmpty);
    });

    test('handles inspiration with very long quote', () async {
      // Arrange
      final longQuote = 'A' * 1000; // 1000 character quote
      final inspiration = InspirationsTableCompanion.insert(
        author: 'Long Quote Author',
        quote: longQuote,
      );

      final id =
          await database.into(database.inspirationsTable).insert(inspiration);

      // Act
      final result = await dao.getInspirationForId(id);

      // Assert
      expect(result.quote.length, 1000);
      expect(result.quote, longQuote);
    });
  });
}
