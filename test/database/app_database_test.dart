// ignore_for_file: avoid_print

import 'dart:io' as io;

import 'package:confession/core/errors/database_exception.dart';
import 'package:confession/data/datasources/local/database_source.dart';
import 'package:confession/database/app_database.dart';
import 'package:confession/database/database_config.dart';
import 'package:drift/drift.dart' hide isNotNull;
import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path/path.dart' as p;

class _MockDatabaseSource extends Mock implements DatabaseSource {}

class _MockQueryExecutor extends Mock implements QueryExecutor {}

void main() {
  late AppDatabase database;
  late _MockDatabaseSource mockDatabaseSource;
  late _MockQueryExecutor mockExecutor;
  late FileSystem fileSystem;
  late File testFile;

  setUpAll(() {
    registerFallbackValue(MemoryFileSystem().file(''));
  });

  setUp(() async {
    mockDatabaseSource = _MockDatabaseSource();
    mockExecutor = _MockQueryExecutor();
    fileSystem = MemoryFileSystem();
    testFile = fileSystem.file('~/test/sqlite.db');

    // Setup default mock behaviors
    when(() => mockDatabaseSource.getDatabaseFile())
        .thenAnswer((_) async => testFile);
    when(() => mockDatabaseSource.copyAssetDatabase(any(), any()))
        .thenAnswer((_) async => {});

    when(() => mockExecutor.runSelect(any(), any()))
        .thenAnswer((_) async => []);

    when(() => mockExecutor.close()).thenAnswer((_) async => {});

    await AppDatabase.resetInstance();

    database = AppDatabase.instance(
      databaseSource: mockDatabaseSource,
      executor: mockExecutor,
    );
  });

  tearDown(() async {
    await database.close();
    await AppDatabase.resetInstance();
  });

  group('AppDatabase', () {
    test('initializes with correct schema version', () {
      expect(database.schemaVersion, AppDatabaseConfig.schemaVersion);
    });

    test('creates new instance with provided executor', () async {
      final db = database;
      expect(db, isNotNull);
      expect(db.schemaVersion, AppDatabaseConfig.schemaVersion);
    });

    test('initializes new database when file does not exist', () async {
      final databaseSource = TestDatabaseSource(MemoryFileSystem());
      await AppDatabase.resetInstance();
      final db = AppDatabase.instance(databaseSource: databaseSource);

      // Force database initialization
      await db.into(db.prayers).insert(
            PrayersCompanion.insert(
              prayerName: 'Test Prayer',
              prayerText: 'Test Text',
              groupName: 'Test Group',
            ),
          );

      // Verify the database file was created
      final dbFile = await databaseSource.getDatabaseFile();
      expect(dbFile.existsSync(), isTrue);

      databaseSource.cleanup();
    });

    test('reuses existing database file', () async {
      final databaseSource = TestDatabaseSource(MemoryFileSystem());

      // Pre-create the database file
      final dbFile = fileSystem.file(p.join('path', 'to', 'db.sqlite'));
      await databaseSource.ensureDirectoryExists(dbFile);
      await dbFile.create(recursive: true);
      await databaseSource.copyAssetDatabase(
        dbFile,
        AppDatabaseConfig.defaultAssetPath,
      );

      await AppDatabase.resetInstance();
      final db = AppDatabase.instance(databaseSource: databaseSource);

      // Force initialization
      await db.into(db.prayers).insert(
            PrayersCompanion.insert(
              prayerName: 'Test Prayer',
              prayerText: 'Test Text',
              groupName: 'Test Group',
            ),
          );

      // File should still exist and not be recreated
      expect(dbFile.existsSync(), isTrue);
      expect(dbFile.lastModifiedSync(), isNotNull);

      databaseSource.cleanup();
    });

    test('handles database initialization errors', () async {
      // Create a problematic scenario by making the file unwritable
      fileSystem.file(
        p.join(fileSystem.directory(p.join('path', 'to')).path, 'db.sqlite'),
      );

      // Mock a file system error by using a custom DatabaseSource
      final errorDatabaseSource = ErrorSimulatingDatabaseSource();

      await AppDatabase.resetInstance();
      final db = AppDatabase.instance(databaseSource: errorDatabaseSource);

      expect(
        () => db.select(db.commandments).get(),
        throwsA(isA<DatabaseException>()),
      );
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

class TestDatabaseSource implements DatabaseSource {
  TestDatabaseSource(this._fileSystem) {
    // Get the current path and sanitize it for memory file system
    final currentPath = io.Directory.current.path;

    // Convert Windows path to memory fs compatible path
    final sanitizedPath = currentPath
        .replaceFirst(RegExp(r'^[A-Za-z]:\\'), '')
        .replaceAll(r'\', '/');

    // Create base directory in memory fs
    _baseDir = _fileSystem.directory(sanitizedPath);
    if (!_baseDir.existsSync()) {
      _baseDir.createSync(recursive: true);
    }

    _tempDir = _baseDir.childDirectory('test_db');
  }

  final FileSystem _fileSystem;
  late final Directory _baseDir;
  late final Directory _tempDir;
  File? _dbFile;

  @override
  Future<File> getDatabaseFile() async {
    _dbFile = _tempDir.childFile('db.sqlite');
    return _dbFile!;
  }

  @override
  Future<void> ensureDirectoryExists(File file) async {
    try {
      final directory = file.parent;
      if (!directory.existsSync()) {
        await directory.create(recursive: true);
      }
    } catch (e, stack) {
      print('Error creating directory: $e');
      print('Stack trace: $stack');
      rethrow;
    }
  }

  @override
  Future<void> copyAssetDatabase(File file, String assetPath) async {
    try {
      if (!file.existsSync()) {
        await file.create(recursive: true);
      }
      await file.writeAsBytes([]);
    } catch (e, stack) {
      print('Error copying database: $e');
      print('Stack trace: $stack');
      rethrow;
    }
  }

  void cleanup() {
    try {
      // Clean up the real file system
      final realTestDb = io.Directory('test_db');
      if (realTestDb.existsSync()) {
        realTestDb.deleteSync(recursive: true);
      }

      // Clean up memory file system
      if (_dbFile != null && _dbFile!.existsSync()) {
        _dbFile!.deleteSync();
      }

      if (_tempDir.existsSync()) {
        _tempDir.deleteSync(recursive: true);
      }
    } catch (e, stack) {
      print('Error during cleanup: $e');
      print('Stack trace: $stack');
    }
  }
}

class ErrorSimulatingDatabaseSource implements DatabaseSource {
  ErrorSimulatingDatabaseSource();

  @override
  Future<File> getDatabaseFile() async {
    throw const FileSystemException('Simulated file system error');
  }

  @override
  Future<void> ensureDirectoryExists(File file) async {
    throw const FileSystemException('Cannot create directory');
  }

  @override
  Future<void> copyAssetDatabase(File file, String assetPath) async {
    throw const FileSystemException('Cannot copy database');
  }
}
