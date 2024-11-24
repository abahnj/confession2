import 'package:confession/core/di/modules/module.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/core/platform/path_provider/path_provider.dart';
import 'package:confession/data/datasources/local/shared_preferences_datasource.dart';
import 'package:confession/domain/datasources/local_storage_datasource.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoreModule extends Module {
  @override
  void init() {
    // Core system dependencies
    sl
      ..registerSingletonAsync<SharedPreferences>(SharedPreferences.getInstance)
      ..registerLazySingleton<FileSystem>(() => const LocalFileSystem())
      ..registerLazySingleton<AssetBundle>(() => rootBundle)
      ..registerLazySingleton<PathProvider>(PathProviderImpl.new)
      ..registerLazySingleton<LocalStorageDataSource>(
        () => SharedPreferencesDataSource(preferences: sl()),
      );
  }
}
