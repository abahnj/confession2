import 'package:confession/core/di/modules/module.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/data/datasources/local/database_source.dart';
import 'package:confession/database/app_database.dart';

class DatabaseModule extends Module {
  @override
  void init() {
    // Database related dependencies
    sl
      ..registerLazySingleton<DatabaseSource>(
        () => DatabaseSource(
          fileSystem: sl(),
          assetBundle: sl(),
          pathProvider: sl(),
        ),
      )
      ..registerLazySingleton<AppDatabase>(
        () => AppDatabase(databaseSource: sl()),
      );
  }
}
