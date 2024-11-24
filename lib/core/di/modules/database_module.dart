import 'package:confession/core/database/app_database.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/data/datasources/local/database_source.dart';

class DatabaseModule {
  static void init()  {
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
        () => AppDatabase.instance(databaseSource: sl()),
      );
  }
}
