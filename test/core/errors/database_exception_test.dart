import 'package:confession/core/errors/database_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DatabaseException', () {
    test('creates exception with message', () {
      final exception = DatabaseException('Test error');
      expect(exception.message, 'Test error');
      expect(exception.error, isNull);
    });

    test('creates exception with message and error', () {
      final error = Exception('Original error');
      final exception = DatabaseException('Test error', error);
      expect(exception.message, 'Test error');
      expect(exception.error, error);
    });

    test('toString provides meaningful message', () {
      final exception = DatabaseException('Test error');
      expect(exception.toString(), contains('Test error'));
    });
  });
}
