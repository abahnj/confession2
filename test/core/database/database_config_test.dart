import 'package:confession/core/database/database_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DatabaseConfig', () {
    test('has correct schema version', () {
      expect(AppDatabaseConfig.schemaVersion, 4);
    });

    test('has correct database name', () {
      expect(AppDatabaseConfig.databaseName, 'app.db');
    });

    test('has correct asset path', () {
      expect(
        AppDatabaseConfig.defaultAssetPath,
        'assets/database/confession.db',
      );
    });
  });
}
