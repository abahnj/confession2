import 'package:confession/data/datasources/local/database_source.dart';
import 'package:confession/database/app_database.dart';
import 'package:confession/database/daos/examinations_dao.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDatabaseSource extends Mock implements DatabaseSource {}

void main() {
  late AppDatabase database;
  late ExaminationsDao dao;
  late _MockDatabaseSource mockDatabaseSource;

  // Helper to create a fresh database
  setUp(() async {
    mockDatabaseSource = _MockDatabaseSource();
    database = AppDatabase(
      databaseSource: mockDatabaseSource,
      executor: NativeDatabase.memory(),
    );
    dao = ExaminationsDao(database);
  });

  tearDown(() async {
    // Close and reset the instance
    await database.close();
  });

  group('ExaminationsDao - Basic CRUD Operations', () {
    final baseExamination = ExaminationsTableCompanion.insert(
      commandmentId: 1,
      adult: true,
      single: true,
      married: false,
      religious: false,
      priest: false,
      teen: false,
      child: false,
      activeText: 'Test active text',
      description: 'Test description',
      female: false,
      male: true,
      count: const Value(0),
    );

    test('updateExamination should successfully update existing record', () async {
      // Arrange
      final inserted = await database.into(database.examinationsTable).insert(baseExamination);
      final updatedExamination = ExaminationsTableData(
        id: inserted,
        commandmentId: 1,
        adult: true,
        single: true,
        married: false,
        religious: false,
        priest: false,
        teen: false,
        child: false,
        activeText: 'Updated text',
        description: 'Updated description',
        female: false,
        male: true,
        count: 1,
      ).toCompanion(false);

      // Act
      final result = await dao.updateExamination(updatedExamination);

      // Assert
      expect(result, 1);
      final updated = await dao.watchExaminations([]).first;
      expect(updated.first.activeText, 'Updated text');
      expect(updated.first.count, 1);
    });
  });

  group('ExaminationsDao - Individual Filters', () {
    final testData = <ExaminationsTableCompanion>[
      ExaminationsTableCompanion.insert(
        commandmentId: 1,
        adult: true,
        single: false,
        married: true,
        religious: false,
        priest: false,
        teen: false,
        child: false,
        activeText: 'Adult married',
        description: 'Description 1',
        female: true,
        male: false,
        count: const Value(1),
      ),
      ExaminationsTableCompanion.insert(
        commandmentId: 2,
        adult: false,
        single: true,
        married: false,
        religious: true,
        priest: true,
        teen: true,
        child: false,
        activeText: 'Teen single priest',
        description: 'Description 2',
        female: false,
        male: true,
        count: const Value(0),
      ),
      ExaminationsTableCompanion.insert(
        commandmentId: 3,
        adult: false,
        single: false,
        married: false,
        religious: false,
        priest: false,
        teen: false,
        child: true,
        activeText: 'Child',
        description: 'Description 3',
        female: true,
        male: false,
        count: const Value(2),
      ),
    ];

    setUp(() async {
      await Future.wait(
        testData.map(
          (exam) => database.into(database.examinationsTable).insert(exam),
        ),
      );
    });

    test('getAdultFilter returns only adult records', () async {
      final results = await dao.watchExaminations([dao.getAdultFilter()]).first;
      expect(results.length, 1);
      expect(results.first.activeText, 'Adult married');
    });

    test('getTeenFilter returns only teen records', () async {
      final results = await dao.watchExaminations([dao.getTeenFilter()]).first;
      expect(results.length, 1);
      expect(results.first.activeText, 'Teen single priest');
    });

    test('getChildFilter returns only child records', () async {
      final results = await dao.watchExaminations([dao.getChildFilter()]).first;
      expect(results.length, 1);
      expect(results.first.activeText, 'Child');
    });

    test('getMaleFilter returns only male records', () async {
      final results = await dao.watchExaminations([dao.getMaleFilter()]).first;
      expect(results.length, 1);
      expect(results.first.activeText, 'Teen single priest');
    });

    test('getPriestFilter returns only priest records', () async {
      final results = await dao.watchExaminations([dao.getPriestFilter()]).first;
      expect(results.length, 1);
      expect(results.first.activeText, 'Teen single priest');
    });

    test('getFemaleFilter returns only female records', () async {
      final results = await dao.watchExaminations([dao.getFemaleFilter()]).first;
      expect(results.length, 2);
      expect(results.map((e) => e.female).every((isFemale) => isFemale), true);
    });

    test('getActiveFilter returns records with count > 0', () async {
      final results = await dao.watchExaminations([dao.isActiveExamination()]).first;
      expect(results.length, 2);
      expect(results.every((exam) => exam.count > 0), true);
    });

    test('getCommandmentFilter returns records for specific commandment', () async {
      final results = await dao.watchExaminations([dao.getCommandmentFilter(2)]).first;
      expect(results.length, 1);
      expect(results.first.commandmentId, 2);
    });
  });

  group('ExaminationsDao - Examination Reset', () {
    test('resetExaminationsCount sets all counts to 0', () async {
      // Arrange
      final examinationsTable = [
        ExaminationsTableCompanion.insert(
          commandmentId: 1,
          adult: true,
          single: true,
          married: false,
          religious: false,
          priest: false,
          teen: false,
          child: false,
          activeText: 'Test 1',
          description: 'Description 1',
          female: false,
          male: true,
          count: const Value(5),
        ),
        ExaminationsTableCompanion.insert(
          commandmentId: 2,
          adult: true,
          single: true,
          married: false,
          religious: false,
          priest: false,
          teen: false,
          child: false,
          activeText: 'Test 2',
          description: 'Description 2',
          female: true,
          male: false,
          count: const Value(3),
        ),
      ];

      await Future.wait(
        examinationsTable.map((e) => database.into(database.examinationsTable).insert(e)),
      );

      // Act
      await dao.resetExaminationsCount();

      // Assert
      final results =
          await (database.select(database.examinationsTable)..where((tbl) => tbl.count.isBiggerThanValue(0))).get();
      expect(results, isEmpty);
    });

    test('resetExaminationsCount only affects non-zero counts', () async {
      // Arrange
      final examinationsTable = [
        ExaminationsTableCompanion.insert(
          commandmentId: 1,
          adult: true,
          single: true,
          married: false,
          religious: false,
          priest: false,
          teen: false,
          child: false,
          activeText: 'Test 1',
          description: 'Description 1',
          female: false,
          male: true,
          count: const Value(5),
        ),
        ExaminationsTableCompanion.insert(
          commandmentId: 2,
          adult: true,
          single: true,
          married: false,
          religious: false,
          priest: false,
          teen: false,
          child: false,
          activeText: 'Test 2',
          description: 'Description 2',
          female: true,
          male: false,
          count: const Value(0),
        ),
      ];

      await Future.wait(
        examinationsTable.map((e) => database.into(database.examinationsTable).insert(e)),
      );

      // Act
      final affectedRows = await dao.resetExaminationsCount();

      // Assert
      expect(affectedRows, 1);
    });

    test('resetExaminationsCount only affects count value', () async {
      await database.into(database.examinationsTable).insert(
            ExaminationsTableCompanion.insert(
              commandmentId: 1,
              adult: true,
              single: true,
              married: false,
              religious: false,
              priest: false,
              teen: false,
              child: false,
              activeText: 'Test 1',
              description: 'Description 1',
              female: false,
              male: true,
              count: const Value(5),
            ),
          );

      // Act
      await dao.resetExaminationsCount();

      // Assert
      final result = await database.select(database.examinationsTable).getSingle();

      expect(
        result,
        const ExaminationsTableData(
          id: 1,
          commandmentId: 1,
          adult: true,
          single: true,
          married: false,
          religious: false,
          priest: false,
          teen: false,
          child: false,
          activeText: 'Test 1',
          description: 'Description 1',
          female: false,
          male: true,
          count: 0,
        ),
      );
    });
  });

  group('ExaminationsDao - Complex Filter Combinations', () {
    final testExaminations = [
      ExaminationsTableCompanion.insert(
        commandmentId: 1,
        adult: true,
        single: true,
        married: false,
        religious: true,
        priest: false,
        teen: false,
        child: false,
        activeText: 'Religious single adult',
        description: 'Description',
        female: true,
        male: false,
        count: const Value(1),
      ),
      ExaminationsTableCompanion.insert(
        commandmentId: 1,
        adult: true,
        single: false,
        married: true,
        religious: true,
        priest: false,
        teen: false,
        child: false,
        activeText: 'Religious married adult',
        description: 'Description',
        female: false,
        male: true,
        count: const Value(2),
      ),
    ];

    setUp(() async {
      await Future.wait(
        testExaminations.map(
          (exam) => database.into(database.examinationsTable).insert(exam),
        ),
      );
    });

    test('combines multiple filters with AND logic', () async {
      final results = await dao.watchExaminations([
        dao.getAdultFilter(),
        dao.getReligiousFilter(),
        dao.getMaleFilter(),
      ]).first;

      expect(results.length, 1);
      expect(results.first.adult, true);
      expect(results.first.religious, true);
      expect(results.first.male, true);
    });

    test('empty filter list returns all records', () async {
      final results = await dao.watchExaminations([]).first;
      expect(results.length, testExaminations.length);
    });
  });

  group('ExaminationsDao - Watch Functionality', () {
    test('watchExaminations emits updated list when records change', () async {
      final examination = ExaminationsTableCompanion.insert(
        commandmentId: 1,
        adult: true,
        single: true,
        married: false,
        religious: false,
        priest: false,
        teen: false,
        child: false,
        activeText: 'Initial',
        description: 'Description',
        female: false,
        male: true,
        count: const Value(0),
      );

      final stream = dao.watchExaminations([dao.getAdultFilter()]);

      final expectation = expectLater(
        stream,
        emitsInOrder([
          hasLength(1), // After insert
          hasLength(2), // After second insert
        ]),
      );

      await database.into(database.examinationsTable).insert(examination);
      await database.into(database.examinationsTable).insert(examination);

      await expectation;
    });

    test('watchExaminations with filters emits only matching records', () async {
      final adultExam = ExaminationsTableCompanion.insert(
        commandmentId: 1,
        adult: true,
        single: true,
        married: false,
        religious: false,
        priest: false,
        teen: false,
        child: false,
        activeText: 'Adult',
        description: 'Description',
        female: false,
        male: true,
        count: const Value(0),
      );

      final teenExam = ExaminationsTableCompanion.insert(
        commandmentId: 1,
        adult: false,
        single: true,
        married: false,
        religious: false,
        priest: false,
        teen: true,
        child: false,
        activeText: 'Teen',
        description: 'Description',
        female: false,
        male: true,
        count: const Value(0),
      );

      final stream = dao.watchExaminations([dao.getAdultFilter()]);

      final expectation = expectLater(
        stream,
        emitsInOrder([
          hasLength(1), // After adult insert
          hasLength(1), // After teen insert (shouldn't affect adult filter)
        ]),
      );

      await database.into(database.examinationsTable).insert(adultExam);
      await database.into(database.examinationsTable).insert(teenExam);

      await expectation;
    });
  });

  group('ExaminationsDao Tests', () {
    final testExamination = ExaminationsTableCompanion.insert(
      commandmentId: 1,
      adult: true,
      single: true,
      married: false,
      religious: false,
      priest: false,
      teen: false,
      child: false,
      activeText: 'Active text',
      description: 'Description',
      female: false,
      male: true,
      count: const Value(0),
    );

    test('getExaminations with no filters returns all examinationsTable', () async {
      // Arrange
      await database.into(database.examinationsTable).insert(testExamination);

      // Act
      final results = await dao.watchExaminations([]).first;

      // Assert
      expect(results.length, 1);
    });

    test('filters are combined correctly', () async {
      // Arrange
      final examinationsTable = [
        testExamination,
        testExamination.copyWith(adult: const Value(false)),
      ];

      await Future.wait(
        examinationsTable.map(
          (exam) => database.into(database.examinationsTable).insert(exam),
        ),
      );

      // Act
      final results = await dao.watchExaminations([
        dao.getAdultFilter(),
        dao.getMaleFilter(),
      ]).first;

      // Assert
      expect(results.length, 1);
      expect(results.first.male, isTrue);
      expect(results.first.adult, isTrue);
    });

    test('watchExaminations emits correct sequence of lists', () async {
      // Start watching before inserting
      final stream = dao.watchExaminations([dao.getAdultFilter()]);

      final expectation = expectLater(
        stream,
        emitsInOrder([
          isA<List<ExaminationsTableData>>()
              .having((list) => list.length, 'length', 1)
              .having((list) => list.first.adult, 'is adult', true),
        ]),
      );

      await database.into(database.examinationsTable).insert(testExamination);

      await expectation;
    });

    test('watchExaminations emits updates for multiple changes', () async {
      final stream = dao.watchExaminations([dao.getAdultFilter()]);

      final expectation = expectLater(
        stream,
        emitsInOrder([
          // After first insert
          isA<List<ExaminationsTableData>>().having((list) => list.length, 'length', 1),
          // After second insert
          isA<List<ExaminationsTableData>>().having((list) => list.length, 'length', 2),
        ]),
      );

      await database.into(database.examinationsTable).insert(testExamination);
      await database.into(database.examinationsTable).insert(testExamination);

      await expectation;
    });

    test('getExaminations handles multiple filters correctly', () async {
      // Arrange
      final examinationsTable = [
        testExamination, // adult: true, male: true
        testExamination.copyWith(
          adult: const Value(true),
          male: const Value(false),
        ),
        testExamination.copyWith(
          adult: const Value(false),
          male: const Value(true),
        ),
      ];

      await Future.wait(
        examinationsTable.map(
          (exam) => database.into(database.examinationsTable).insert(exam),
        ),
      );

      // Act
      final results = await dao.watchExaminations([
        dao.getAdultFilter(),
        dao.getMaleFilter(),
        dao.getSingleFilter(),
      ]).first;

      // Assert
      expect(results.length, 1);
      expect(results.first.adult, isTrue);
      expect(results.first.male, isTrue);
      expect(results.first.single, isTrue);
    });

    test('filters exclude non-matching records', () async {
      // Arrange
      final examinationsTable = [
        testExamination,
        testExamination.copyWith(
          adult: const Value(true),
          single: const Value(false),
          married: const Value(true),
        ),
      ];

      await Future.wait(
        examinationsTable.map(
          (exam) => database.into(database.examinationsTable).insert(exam),
        ),
      );

      // Act
      final singleResults = await dao.watchExaminations([dao.getSingleFilter()]).first;
      final marriedResults = await dao.watchExaminations([dao.getMarriedFilter()]).first;

      // Assert
      expect(singleResults.length, 1);
      expect(singleResults.first.single, isTrue);
      expect(marriedResults.length, 1);
      expect(marriedResults.first.married, isTrue);
    });
  });
}
