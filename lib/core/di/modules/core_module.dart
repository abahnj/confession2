import 'package:confession/core/di/service_locator.dart';
import 'package:confession/core/platform/path_provider/path_provider.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/services.dart';

class CoreModule {
  static void init()  {
    // Core system dependencies
    sl
      ..registerLazySingleton<FileSystem>(() => const LocalFileSystem())
      ..registerLazySingleton<AssetBundle>(() => rootBundle)
      ..registerLazySingleton<PathProvider>(PathProviderImpl.new);
  }
}
