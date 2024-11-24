// ignore_for_file: depend_on_referenced_packages

import 'package:confession/core/database/daos/daos.dart';
import 'package:confession/core/database/database_config.dart';
import 'package:confession/core/database/tables/tables.dart';
import 'package:confession/core/errors/database_exception.dart';
import 'package:confession/data/datasources/local/database_source.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Commandments, Examinations, Guides, Prayers, Inspirations],
  daos: [CommandmentsDao, ExaminationsDao, PrayersDao, GuidesDao],
)
class AppDatabase extends _$AppDatabase {
  factory AppDatabase.instance({
    required DatabaseSource databaseSource,
    QueryExecutor? executor,
  }) {
    return _instance ??= AppDatabase._init(
      databaseSource: databaseSource,
      executor: executor,
    );
  }

  AppDatabase._init({
    required DatabaseSource databaseSource,
    QueryExecutor? executor,
  })  : _databaseSource = databaseSource,
        super(executor ?? _openConnection(databaseSource));

  final DatabaseSource _databaseSource;
  static AppDatabase? _instance;

  static void resetInstance() {
    _instance?.close();
    _instance = null;
  }

  @override
  int get schemaVersion => AppDatabaseConfig.schemaVersion;

  static LazyDatabase _openConnection(DatabaseSource databaseSource) {
    return LazyDatabase(() async {
      try {
        final file = await databaseSource.getDatabaseFile();

        if (!file.existsSync()) {
          await databaseSource.ensureDirectoryExists(file);
          await databaseSource.copyAssetDatabase(
            file,
            AppDatabaseConfig.defaultAssetPath,
          );
        }

        await databaseSource.setupAndroidSpecifics();

        return NativeDatabase.createInBackground(file);
      } catch (e) {
        throw DatabaseException('Failed to initialize database', e);
      }
    });
  }

  Future<void> deleteDatabase() async {
    final file = await _databaseSource.getDatabaseFile();
    if (file.existsSync()) {
      await file.delete();
    }
  }

  Future<void> backupDatabase() async {
    try {
      final file = await _databaseSource.getDatabaseFile();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final extension = p.extension(file.path);
      final nameWithoutExtension = p.basenameWithoutExtension(file.path);
      final backupPath = '${p.dirname(file.path)}/backup_${timestamp}_$nameWithoutExtension$extension';

      await file.copy(backupPath);
    } catch (e) {
      throw DatabaseException('Failed to backup database', e);
    }
  }

  Future<bool> isDatabaseInitialized() async {
    final file = await _databaseSource.getDatabaseFile();
    return file.existsSync();
  }
}
