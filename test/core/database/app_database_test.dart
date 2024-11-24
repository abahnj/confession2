// test/core/database/app_database_test.dart
import 'package:confession/core/database/app_database.dart';
import 'package:confession/core/database/database_config.dart';
import 'package:confession/core/errors/database_exception.dart';
import 'package:confession/data/datasources/local/database_source.dart';
import 'package:drift/drift.dart' hide isNotNull;
import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDatabaseSource extends Mock implements DatabaseSource {}

class _MockQueryExecutor extends Mock implements QueryExecutor {}

void main() {
  late AppDatabase database;
  late _MockDatabaseSource mockDatabaseSource;
  late _MockQueryExecutor mockExecutor;
  late FileSystem fileSystem;
  late File testFile;

  setUp(() {
    mockDatabaseSource = _MockDatabaseSource();
    mockExecutor = _MockQueryExecutor();
    fileSystem = MemoryFileSystem();
    testFile = fileSystem.file('/test/sqlite.db');

    // Setup default mock behaviors
    when(() => mockDatabaseSource.getDatabaseFile())
        .thenAnswer((_) async => testFile);

    when(() => mockExecutor.close()).thenAnswer((_) async => {});

    database = AppDatabase.instance(
      databaseSource: mockDatabaseSource,
      executor: mockExecutor,
    );
  });

  tearDown(() async {
    await database.close();
  });

  group('AppDatabase', () {
    test('initializes with correct schema version', () {
      expect(database.schemaVersion, AppDatabaseConfig.schemaVersion);
    });

    test('creates new instance with provided executor', () {
      final db = AppDatabase.instance(
        databaseSource: mockDatabaseSource,
        executor: mockExecutor,
      );
      expect(db, isNotNull);
      expect(db.schemaVersion, AppDatabaseConfig.schemaVersion);
    });
  });

  group('deleteDatabase', () {
    test('deletes existing database file', () async {
      // Arrange
      await testFile.parent.create(recursive: true);
      await testFile.writeAsString('test data');

      // Act
      await database.deleteDatabase();

      // Assert
      expect(testFile.existsSync(), false);
    });

    test('handles non-existent database file', () async {
      // Act
      await database.deleteDatabase();

      // Assert
      expect(testFile.existsSync(), false);
    });

    test('handles non-existent parent directory', () async {
      // Act
      await database.deleteDatabase();

      // Assert
      expect(testFile.parent.existsSync(), false);
    });
  });

  group('backupDatabase', () {
    test('creates backup with timestamp', () async {
      // Arrange
      await testFile.parent.create(recursive: true);
      await testFile.writeAsString('test data');

      // Act
      await database.backupDatabase();

      // Assert
      final files = testFile.parent.listSync();
      expect(
        files.any(
          (file) => file.path.contains('backup_') && file.path.endsWith('.db'),
        ),
        true,
      );
    });

    test('backup contains correct data', () async {
      // Arrange
      await testFile.parent.create(recursive: true);
      const testData = 'test database content';
      await testFile.writeAsString(testData);

      // Act
      await database.backupDatabase();

      // Assert
      final backupFile = testFile.parent
          .listSync()
          .firstWhere((file) => file.path.contains('backup_'));
      expect(await fileSystem.file(backupFile.path).readAsString(), testData);
    });

    test('creates multiple backups with different timestamps', () async {
      // Arrange
      await testFile.parent.create(recursive: true);
      await testFile.writeAsString('test data');

      // Act
      await database.backupDatabase();
      await Future<void>.delayed(const Duration(milliseconds: 1));
      await database.backupDatabase();

      // Assert
      final backupFiles = testFile.parent
          .listSync()
          .where((file) => file.path.contains('backup_'))
          .toList();
      expect(backupFiles.length, 2);
      expect(backupFiles[0].path, isNot(equals(backupFiles[1].path)));
    });

    test('throws DatabaseException when source file does not exist', () async {
      // Act & Assert
      expect(
        () => database.backupDatabase(),
        throwsA(isA<DatabaseException>()),
      );
    });
  });
  group('isDatabaseInitialized', () {
    test('returns true when database file exists', () async {
      // Arrange
      await testFile.parent.create(recursive: true);
      await testFile.writeAsString('test data');

      // Act
      final result = await database.isDatabaseInitialized();

      // Assert
      expect(result, true);
    });

    test('returns false when database file does not exist', () async {
      // Act
      final result = await database.isDatabaseInitialized();

      // Assert
      expect(result, false);
    });

    test('returns false when only parent directory exists', () async {
      // Arrange
      await testFile.parent.create(recursive: true);

      // Act
      final result = await database.isDatabaseInitialized();

      // Assert
      expect(result, false);
    });
  });

  group('integration tests', () {
    test('complete database lifecycle', () async {
      // Arrange
      await testFile.parent.create(recursive: true);
      await testFile.writeAsString('test database');

      // Act & Assert

      // Initial state
      expect(await database.isDatabaseInitialized(), true);

      // Create backup
      await database.backupDatabase();
      final backupFiles = testFile.parent
          .listSync()
          .where((file) => file.path.contains('backup_'))
          .toList();
      expect(backupFiles.length, 1);

      // Delete database
      await database.deleteDatabase();
      expect(testFile.existsSync(), false);
      expect(await database.isDatabaseInitialized(), false);

      // Backup should still exist
      expect(backupFiles[0].existsSync(), true);
    });

    test('handles multiple operations sequentially', () async {
      // Arrange
      await testFile.parent.create(recursive: true);
      await testFile.writeAsString('test database');

      // Act & Assert
      // Create multiple backups
      await database.backupDatabase();
      await Future<void>.delayed(const Duration(milliseconds: 1));
      await database.backupDatabase();

      final backupFiles = testFile.parent
          .listSync()
          .where((file) => file.path.contains('backup_'))
          .toList();
      expect(backupFiles.length, 2);

      // Delete original
      await database.deleteDatabase();
      expect(testFile.existsSync(), false);

      // Backups should still exist
      expect(backupFiles[0].existsSync(), true);
      expect(backupFiles[1].existsSync(), true);
    });
  });
}
