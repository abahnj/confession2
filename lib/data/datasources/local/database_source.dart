// ignore_for_file: depend_on_referenced_packages

import 'package:confession/core/errors/database_exception.dart';
import 'package:confession/core/platform/path_provider/path_provider.dart';
import 'package:confession/database/database_config.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;

class DatabaseSource {
  DatabaseSource({
    required PathProvider pathProvider,
    FileSystem? fileSystem,
    AssetBundle? assetBundle,
  })  : _fileSystem = fileSystem ?? const LocalFileSystem(),
        _assetBundle = assetBundle ?? rootBundle,
        _pathProvider = pathProvider;
  final FileSystem _fileSystem;
  final AssetBundle _assetBundle;
  final PathProvider _pathProvider;

  Future<File> getDatabaseFile() async {
    final dbFolder = await _pathProvider.getApplicationDocumentsDirectory();
    return _fileSystem
        .file(p.join(dbFolder.path, AppDatabaseConfig.databaseName));
  }

  Future<void> ensureDirectoryExists(File file) async {
    final directory = _fileSystem.file(file.path).parent;
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
  }

  Future<void> copyAssetDatabase(File file, String assetPath) async {
    try {
      final content = await _assetBundle.load(assetPath);
      await _fileSystem
          .file(file.path)
          .writeAsBytes(content.buffer.asUint8List());
    } catch (e) {
      throw DatabaseException('Failed to copy asset database', e);
    }
  }
}
