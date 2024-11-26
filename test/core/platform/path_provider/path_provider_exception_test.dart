import 'package:confession/core/platform/path_provider/path_provider_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PathProviderException', () {
    test('creates exception with message', () {
      final exception = PathProviderException('Test error');
      expect(exception.message, 'Test error');
      expect(exception.error, isNull);
    });

    test('creates exception with message and error', () {
      final error = Exception('Original error');
      final exception = PathProviderException('Test error', error);
      expect(exception.message, 'Test error');
      expect(exception.error, error);
    });

    test('toString provides meaningful message', () {
      final exception = PathProviderException('Test error');
      expect(exception.toString(), contains('Test error'));
    });

    test('toString includes PathProviderException prefix', () {
      final exception = PathProviderException('Test error');
      expect(exception.toString(), startsWith('PathProviderException:'));
    });

    test('error can be any type', () {
      const error = 'String error';
      final exception = PathProviderException('Test error', error);
      expect(exception.error, error);
    });
  });
}
