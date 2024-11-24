import 'package:confession/core/di/env_config.dart';
import 'package:confession/core/di/modules/core_module.dart';
import 'package:confession/core/di/modules/database_module.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

class ServiceLocator {
  static void init({Environment? environment}) {
    if (environment != null) {
      EnvConfig.environment = environment;
    }

    try {
      _initializeModules();
    } catch (e) {
      throw DependencyInitializationException(
        'Failed to initialize dependencies: $e',
      );
    }
  }

  static void _initializeModules() {
    CoreModule.init();
    DatabaseModule.init();
  }

  static Future<void> reset() async {
    await sl.reset();
  }
}

// Custom exception for initialization errors
class DependencyInitializationException implements Exception {
  DependencyInitializationException(this.message);
  final String message;

  @override
  String toString() => 'DependencyInitializationException: $message';
}