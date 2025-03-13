import 'package:confession/gen/assets.gen.dart';

abstract class AppDatabaseConfig {
  static const int schemaVersion = 5;
  static const String databaseName = 'app.db';
  static String defaultAssetPath = Assets.database.confession;
}
