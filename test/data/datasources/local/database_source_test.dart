// test/data/datasources/local/database_source_test.dart
import 'dart:io' as io;

import 'package:confession/core/database/database_config.dart';
import 'package:confession/core/errors/database_exception.dart';
import 'package:confession/core/platform/path_provider/path_provider.dart';
import 'package:confession/data/datasources/local/database_source.dart';
import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path/path.dart' as p;

class MockPathProvider extends Mock implements PathProvider {}

class MockAssetBundle extends Mock implements AssetBundle {}

class MockFile extends Mock implements File {}

class MockDirectory extends Mock implements Directory {}

class MockIoDirectory extends Mock implements io.Directory {}

void main() {
  late DatabaseSource databaseSource;
  late FileSystem fileSystem;
  late MockPathProvider mockPathProvider;
  late MockAssetBundle mockAssetBundle;
  late MockIoDirectory mockIoDirectory;

  setUp(() {
    fileSystem = MemoryFileSystem();
    mockPathProvider = MockPathProvider();
    mockAssetBundle = MockAssetBundle();
    mockIoDirectory = MockIoDirectory();

    // Register fallback values
    registerFallbackValue(MockFile());
    registerFallbackValue(MockDirectory());

    // Setup default mock behaviors
    when(() => mockIoDirectory.path).thenReturn('/test/path');
    when(() => mockPathProvider.getApplicationDocumentsDirectory()).thenAnswer((_) async => mockIoDirectory);
    when(() => mockPathProvider.getTemporaryDirectory()).thenAnswer((_) async => mockIoDirectory);

    databaseSource = DatabaseSource(
      pathProvider: mockPathProvider,
      fileSystem: fileSystem,
      assetBundle: mockAssetBundle,
    );
  });

  group('DatabaseSource', () {
    group('initialization', () {
      test('creates instance with provided dependencies', () {
        expect(databaseSource, isNotNull);
      });

      test('uses default FileSystem when not provided', () {
        final source = DatabaseSource(
          pathProvider: mockPathProvider,
          assetBundle: mockAssetBundle,
        );
        expect(source, isNotNull);
      });

      test('uses default AssetBundle when not provided', () {
        final source = DatabaseSource(
          pathProvider: mockPathProvider,
          fileSystem: fileSystem,
        );
        expect(source, isNotNull);
      });
    });

    group('getDatabaseFile', () {
      test('returns correct file path', () async {
        // Arrange
        final expectedPath = p.join('/test/path', AppDatabaseConfig.databaseName);

        // Act
        final file = await databaseSource.getDatabaseFile();

        // Assert
        expect(file.path, expectedPath);
      });

      test('handles path provider error', () async {
        // Arrange
        when(() => mockPathProvider.getApplicationDocumentsDirectory()).thenThrow(Exception('Path provider error'));

        // Act & Assert
        expect(
          () => databaseSource.getDatabaseFile(),
          throwsA(isA<Exception>()),
        );
      });

      test('creates file instance with correct path', () async {
        // Act
        final file = await databaseSource.getDatabaseFile();

        // Assert
        expect(file, isA<File>());
        expect(
          file.path,
          endsWith(AppDatabaseConfig.databaseName),
        );
      });
    });

    group('ensureDirectoryExists', () {
      test('creates directory when it does not exist', () async {
        // Arrange
        final testFile = fileSystem.file('/new/path/test.db');

        // Act
        await databaseSource.ensureDirectoryExists(testFile);

        // Assert
        expect(await testFile.parent.exists(), true);
      });

      test('does not create directory when it already exists', () async {
        // Arrange
        final directory = fileSystem.directory('/existing/path');
        await directory.create(recursive: true);
        final testFile = directory.childFile('test.db');
        final originalModified = directory.statSync().modified;

        // Act
        await databaseSource.ensureDirectoryExists(testFile);

        // Assert
        expect(directory.statSync().modified, originalModified);
      });
    });

    group('copyAssetDatabase', () {
      test('copies asset database successfully', () async {
        // Arrange
        final testDir = fileSystem.directory('/test');
        await testDir.create(recursive: true);
        final testFile = testDir.childFile('db.sqlite');

        final testData = Uint8List.fromList([1, 2, 3, 4]);
        final byteData = ByteData(testData.length);
        testData.asMap().forEach(byteData.setUint8);

        when(() => mockAssetBundle.load(any())).thenAnswer((_) async => byteData);

        // Act
        await databaseSource.copyAssetDatabase(
          testFile,
          AppDatabaseConfig.defaultAssetPath,
        );

        // Assert
        expect(await testFile.exists(), true);
        expect(await testFile.readAsBytes(), testData);
      });

      test('throws DatabaseException when asset loading fails', () async {
        // Arrange
        final testFile = fileSystem.file('/test/db.sqlite');
        when(() => mockAssetBundle.load(any())).thenThrow(Exception('Asset load failed'));

        // Act & Assert
        expect(
          () => databaseSource.copyAssetDatabase(
            testFile,
            AppDatabaseConfig.defaultAssetPath,
          ),
          throwsA(isA<DatabaseException>()),
        );
      });

      test('overwrites existing file', () async {
        // Arrange
        final testFile = fileSystem.file('/test/db.sqlite');
        await testFile.parent.create(recursive: true);
        await testFile.writeAsBytes([5, 5, 5, 5]);

        final newData = Uint8List.fromList([1, 2, 3, 4]);
        final byteData = ByteData(newData.length);
        newData.asMap().forEach(byteData.setUint8);

        when(() => mockAssetBundle.load(any())).thenAnswer((_) async => byteData);

        // Act
        await databaseSource.copyAssetDatabase(
          testFile,
          AppDatabaseConfig.defaultAssetPath,
        );

        // Assert
        expect(testFile.existsSync(), true);
        expect(testFile.readAsBytesSync(), newData);
      });

      test("creates parent directories if they don't exist", () async {
        // Arrange
        final testFile = fileSystem.file('/new/path/db.sqlite');
        final testData = Uint8List.fromList([1, 2, 3, 4]);
        final byteData = ByteData(testData.length);
        testData.asMap().forEach(byteData.setUint8);

        when(() => mockAssetBundle.load(any())).thenAnswer((_) async => byteData);

        // Act
        await databaseSource.ensureDirectoryExists(testFile);
        await databaseSource.copyAssetDatabase(
          testFile,
          AppDatabaseConfig.defaultAssetPath,
        );

        // Assert
        expect(testFile.parent.existsSync(), true);
        expect(testFile.existsSync(), true);
        expect(testFile.readAsBytesSync(), testData);
      });

      test('handles empty asset data', () async {
        // Arrange
        final testFile = fileSystem.file('/test/db.sqlite');
        await testFile.parent.create(recursive: true);

        when(() => mockAssetBundle.load(any())).thenAnswer((_) async => ByteData(0));

        // Act
        await databaseSource.copyAssetDatabase(
          testFile,
          AppDatabaseConfig.defaultAssetPath,
        );

        // Assert
        expect(testFile.existsSync(), true);
        expect(testFile.readAsBytesSync(), isEmpty);
      });

      test('throws DatabaseException when file write fails', () async {
        // Arrange
        final mockFile = MockFile();
        when(() => mockAssetBundle.load(any())).thenAnswer((_) async => ByteData(0));
        when(() => mockFile.writeAsBytes(any())).thenThrow(const FileSystemException('Write failed'));

        // Act & Assert
        expect(
          () => databaseSource.copyAssetDatabase(
            mockFile,
            AppDatabaseConfig.defaultAssetPath,
          ),
          throwsA(isA<DatabaseException>()),
        );
      });
    });

    group('integration tests', () {
      test('complete database file setup flow', () async {
        // Arrange
        final testData = Uint8List.fromList([1, 2, 3, 4]);
        when(() => mockAssetBundle.load(any())).thenAnswer((_) async => ByteData.sublistView(testData));

        // Act
        final dbFile = await databaseSource.getDatabaseFile();
        await databaseSource.ensureDirectoryExists(dbFile);
        await databaseSource.copyAssetDatabase(
          dbFile,
          AppDatabaseConfig.defaultAssetPath,
        );

        // Assert
        expect(await dbFile.exists(), true);
        expect(await dbFile.readAsBytes(), testData);
        expect(await dbFile.parent.exists(), true);
      });

      test('handles complete flow failure gracefully', () async {
        // Arrange
        when(() => mockAssetBundle.load(any())).thenThrow(Exception('Asset load failed'));

        // Act & Assert
        final dbFile = await databaseSource.getDatabaseFile();
        await databaseSource.ensureDirectoryExists(dbFile);

        expect(
          () => databaseSource.copyAssetDatabase(
            dbFile,
            AppDatabaseConfig.defaultAssetPath,
          ),
          throwsA(isA<DatabaseException>()),
        );
      });
    });
  });
}
