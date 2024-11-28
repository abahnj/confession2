import 'package:confession/data/datasources/local/database_source.dart';
import 'package:confession/database/app_database.dart';
import 'package:confession/database/daos/commandments_dao.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDatabaseSource extends Mock implements DatabaseSource {}

void main() {
  late AppDatabase database;
  late CommandmentsDao dao;
  late _MockDatabaseSource mockDatabaseSource;

  setUp(() async {
    await AppDatabase.resetInstance();
    mockDatabaseSource = _MockDatabaseSource();
    database = AppDatabase.instance(
      databaseSource: mockDatabaseSource,
      executor: NativeDatabase.memory(),
    );
    dao = CommandmentsDao(database);
  });

  tearDown(() async {
    await database.close();
    await AppDatabase.resetInstance();
  });

  final commandment = CommandmentsTableCompanion.insert(
    number: 1,
    category: 'Category',
    commandment: 'First Commandment',
    commandmentText: 'Description 1',
  );

  group('CommandmentsDao - Basic CRUD Operations', () {
    test('insertCommandment should successfully insert a new commandment',
        () async {
      // Arrange

      // Act
      final result = await dao.insertCommandment(commandment);

      // Assert
      expect(result, 1);
      final inserted = await dao.getCommandmentById(1);
      expect(inserted.commandment, 'First Commandment');
      expect(inserted.commandmentText, 'Description 1');
    });

    test('getAllCommandments should return all inserted commandments',
        () async {
      // Arrange
      final commandments = [
        commandment,
        commandment.copyWith(
          number: const Value(2),
          category: const Value('Category'),
          commandment: const Value('Second Commandment'),
          commandmentText: const Value('Description 2'),
        ),
      ];

      // Act
      await Future.wait(
        commandments.map((c) => dao.insertCommandment(c)),
      );
      final results = await dao.getAllCommandments();

      // Assert
      expect(results.length, 2);
      expect(
        results.map((c) => c.commandment).toList(),
        ['First Commandment', 'Second Commandment'],
      );
    });

    test('getCommandmentById should return correct commandment', () async {
      // Arrange
      final commandment = CommandmentsTableCompanion.insert(
        number: 5,
        id: const Value(5),
        commandment: 'Fifth',
        commandmentText: 'Description 5',
        category: 'Category',
      );
      await dao.insertCommandment(commandment);

      // Act
      final result = await dao.getCommandmentById(5);

      // Assert
      expect(result.id, 5);
      expect(result.commandment, 'Fifth');
      expect(result.commandmentText, 'Description 5');
    });

    test('getCommandmentById should throw for non-existent id', () async {
      expect(
        () => dao.getCommandmentById(999),
        throwsStateError,
      );
    });
  });

  group('CommandmentsDao - Filtered Queries', () {
    setUp(() async {
      final commandments = [
        CommandmentsTableCompanion.insert(
          number: 1,
          id: const Value(1),
          commandment: 'Adult 1',
          commandmentText: 'Adult Description 1',
          category: 'Category',
        ),
        CommandmentsTableCompanion.insert(
          number: 2,
          id: const Value(10),
          commandment: 'Adult 10',
          commandmentText: 'Adult Description 10',
          category: 'Category',
        ),
        CommandmentsTableCompanion.insert(
          number: 3,
          id: const Value(11),
          commandment: 'Child 11',
          commandmentText: 'Child Description 11',
          category: 'Category',
        ),
        CommandmentsTableCompanion.insert(
          number: 4,
          id: const Value(12),
          commandment: 'Religious 12',
          commandmentText: 'Religious Description 12',
          category: 'Category',
        ),
        CommandmentsTableCompanion.insert(
          number: 5,
          id: const Value(14),
          commandment: 'Child 14',
          commandmentText: 'Child Description 14',
          category: 'Category',
        ),
      ];

      await Future.wait(
        commandments.map((c) => dao.insertCommandment(c)),
      );
    });

    test(
        'getCommandmentsForChildren returns only child-appropriate commandments',
        () async {
      // Act
      final results = await dao.getCommandmentsForChildren();

      // Assert
      expect(results.length, 2);
      expect(results.map((c) => c.id).toSet(), {11, 14});
      expect(
        results.every((c) => c.commandment.startsWith('Child')),
        true,
      );
    });

    test('getCommandmentsForReligious returns commandments with id > 10',
        () async {
      // Act
      final results = await dao.getCommandmentsForReligious();

      // Assert
      expect(results.length, 3);
      expect(
        results.every((c) => c.id > 10),
        true,
      );
    });

    test('getCommandmentsForAdults returns commandments with id < 11',
        () async {
      // Act
      final results = await dao.getCommandmentsForAdults();

      // Assert
      expect(results.length, 2);
      expect(
        results.every((c) => c.id < 11),
        true,
      );
      expect(
        results.every((c) => c.commandment.startsWith('Adult')),
        true,
      );
    });
  });

  group('CommandmentsDao - Edge Cases', () {
    test('getAllCommandments returns empty list when no commandments exist',
        () async {
      final results = await dao.getAllCommandments();
      expect(results, isEmpty);
    });

    test(
        'filtered queries return empty lists when no matching commandments exist',
        () async {
      final children = await dao.getCommandmentsForChildren();
      final religious = await dao.getCommandmentsForReligious();
      final adults = await dao.getCommandmentsForAdults();

      expect(children, isEmpty);
      expect(religious, isEmpty);
      expect(adults, isEmpty);
    });

    test('insertCommandment handles duplicate ids correctly', () async {
      // Arrange
      final commandment1 = CommandmentsTableCompanion.insert(
        number: 1,
        id: const Value(1),
        commandment: 'First Version',
        commandmentText: 'Description 1',
        category: 'Category',
      );
      final commandment2 = CommandmentsTableCompanion.insert(
        number: 2,
        id: const Value(1),
        commandment: 'Second Version',
        commandmentText: 'Description 2',
        category: 'Category',
      );

      // Act & Assert
      await dao.insertCommandment(commandment1);
      expect(
        () => dao.insertCommandment(commandment2),
        throwsA(isA<SqliteException>()),
      );
    });

    test('large batch of insertions handled correctly', () async {
      // Arrange
      final commandments = List.generate(
        100,
        (i) => CommandmentsTableCompanion.insert(
          number: i + 1,
          id: Value(i + 1),
          commandment: 'Commandment ${i + 1}',
          commandmentText: 'Description ${i + 1}',
          category: 'Category',
        ),
      );

      // Act
      await Future.wait(
        commandments.map((c) => dao.insertCommandment(c)),
      );
      final results = await dao.getAllCommandments();

      // Assert
      expect(results.length, 100);
      expect(
        results.map((c) => c.id).toList(),
        List.generate(100, (i) => i + 1),
      );
    });
  });
}
