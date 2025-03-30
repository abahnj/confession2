import 'package:confession/core/errors/app_exception.dart';
import 'package:confession/core/errors/throw.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Throw', () {
    group('Direct Methods', () {
      test('network throws NetworkException', () {
        expect(
          () => Throw.network('Network error'),
          throwsA(
            isA<NetworkException>().having(
              (e) => e.message,
              'message',
              'Network error',
            ),
          ),
        );
      });

      test('database throws DatabaseException', () {
        expect(
          () => Throw.database('Database error'),
          throwsA(
            isA<DatabaseException>().having(
              (e) => e.message,
              'message',
              'Database error',
            ),
          ),
        );
      });

      test('auth throws AuthException', () {
        expect(
          () => Throw.auth('Auth error'),
          throwsA(
            isA<AuthException>().having(
              (e) => e.message,
              'message',
              'Auth error',
            ),
          ),
        );
      });

      test('storage throws StorageException', () {
        expect(
          () => Throw.storage('Storage error'),
          throwsA(
            isA<StorageException>().having(
              (e) => e.message,
              'message',
              'Storage error',
            ),
          ),
        );
      });

      test('validation throws ValidationException', () {
        expect(
          () => Throw.validation('Validation error'),
          throwsA(
            isA<ValidationException>().having(
              (e) => e.message,
              'message',
              'Validation error',
            ),
          ),
        );
      });

      test('unexpected throws UnexpectedException', () {
        expect(
          () => Throw.unexpected('Unexpected error'),
          throwsA(
            isA<UnexpectedException>().having(
              (e) => e.message,
              'message',
              'Unexpected error',
            ),
          ),
        );
      });

      test('feature throws FeatureException', () {
        expect(
          () => Throw.feature('Feature error', 'TEST'),
          throwsA(
            isA<FeatureException>()
                .having((e) => e.message, 'message', 'Feature error')
                .having((e) => e.code, 'code', 'FEATURE_TEST'),
          ),
        );
      });
    });

    group('Conditional Methods', () {
      test('whenTrue throws exception when condition is true', () {
        expect(
          () => Throw.whenTrue(
            condition: true,
            message: 'Condition met',
            type: ExceptionType.unexpected,
          ),
          throwsA(
            isA<UnexpectedException>().having(
              (e) => e.message,
              'message',
              'Condition met',
            ),
          ),
        );
      });

      test('whenTrue does nothing when condition is false', () {
        // Should not throw
        Throw.whenTrue(
          condition: false,
          message: 'Should not throw',
          type: ExceptionType.unexpected,
        );
      });

      test('whenTrue with different exception types', () {
        // Test all exception types
        for (final type in ExceptionType.values) {
          if (type == ExceptionType.feature) {
            // Feature type needs a feature code
            expect(
              () => Throw.whenTrue(
                condition: true,
                message: 'Feature error',
                type: type,
                featureCode: 'TEST',
              ),
              throwsA(isA<FeatureException>()),
            );
          } else {
            expect(
              () => Throw.whenTrue(
                condition: true,
                message: '${type.name} error',
                type: type,
              ),
              throwsA(predicate((e) => e is AppException)),
            );
          }
        }
      });

      test('debugAssert in debug mode', () {
        // Note: This test is for coverage purposes,
        // actual behavior depends on kDebugMode which is always false in tests
        Throw.debugAssert(
          condition: true,
          message: 'Debug assert',
        );
      });
    });
  });
}
