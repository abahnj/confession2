import 'package:confession/core/errors/app_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppException', () {
    group('NetworkException', () {
      test('creates basic network exception', () {
        const message = 'Network error';
        const exception = NetworkException(message: message);

        expect(exception.message, equals(message));
        expect(exception.code, isNull);
        expect(exception.error, isNull);
        expect(exception.stackTrace, isNull);
        expect(exception.isConnectionError, isFalse);
        expect(exception.shouldReport, isTrue);
        expect(exception.shouldDisplay, isTrue);
        expect(
          exception.userMessage,
          equals('A network error occurred. Please try again later.'),
        );
      });

      test('creates connection error with factory', () {
        final exception = NetworkException.connection();

        expect(exception.message, equals('No internet connection'));
        expect(exception.isConnectionError, isTrue);
        expect(
          exception.userMessage,
          equals(
            'Unable to connect to the network. Please check your connection and try again.',
          ),
        );
      });

      test('creates timeout error with factory', () {
        final exception = NetworkException.timeout();

        expect(exception.message, equals('Request timed out'));
        expect(exception.code, equals('TIMEOUT'));
        expect(exception.isConnectionError, isFalse);
      });

      test('creates server error with factory', () {
        final exception = NetworkException.server(500);

        expect(exception.message, equals('Server error 500'));
        expect(exception.code, equals('SERVER_500'));
        expect(exception.isConnectionError, isFalse);
      });

      test('toString includes exception type and message', () {
        const exception = NetworkException(
          message: 'Network problem',
          code: 'NET_ERR',
        );

        expect(
          exception.toString(),
          contains('NetworkException(NET_ERR): Network problem'),
        );
      });
    });

    group('DatabaseException', () {
      test('creates basic database exception', () {
        const message = 'Database error';
        const exception = DatabaseException(message: message);

        expect(exception.message, equals(message));
        expect(exception.code, isNull);
        expect(exception.error, isNull);
        expect(exception.stackTrace, isNull);
        expect(
          exception.userMessage,
          equals('A database error occurred. Please restart the app.'),
        );
      });

      test('creates connection error with factory', () {
        final exception = DatabaseException.connection();

        expect(exception.message, equals('Unable to connect to database'));
        expect(exception.code, equals('DB_CONNECTION'));
      });

      test('creates query error with factory', () {
        const queryText = 'SELECT * FROM users';
        final error = Exception('Invalid query');
        final exception = DatabaseException.query(queryText, error);

        expect(exception.message, equals('Database query error: $queryText'));
        expect(exception.code, equals('DB_QUERY'));
        expect(exception.error, equals(error));
      });

      test('creates corruption error with factory', () {
        final exception = DatabaseException.corruption();

        expect(exception.message, equals('Database corruption detected'));
        expect(exception.code, equals('DB_CORRUPTION'));
      });
    });

    group('AuthException', () {
      test('creates basic auth exception', () {
        const message = 'Auth error';
        const exception = AuthException(message: message);

        expect(exception.message, equals(message));
        expect(exception.code, isNull);
        expect(exception.error, isNull);
        expect(exception.stackTrace, isNull);
        expect(exception.requiresLogin, isFalse);
        expect(
          exception.userMessage,
          equals('Authentication error. Please try again.'),
        );
      });

      test('creates unauthorized error with factory', () {
        final exception = AuthException.unauthorized();

        expect(exception.message, equals('Unauthorized access'));
        expect(exception.code, equals('UNAUTHORIZED'));
        expect(exception.requiresLogin, isTrue);
        expect(exception.userMessage, equals('Please sign in to continue.'));
      });

      test('creates session expired error with factory', () {
        final exception = AuthException.sessionExpired();

        expect(
          exception.message,
          equals('Your session has expired. Please sign in again.'),
        );
        expect(exception.code, equals('SESSION_EXPIRED'));
        expect(exception.requiresLogin, isTrue);
      });
    });

    group('ValidationException', () {
      test('creates basic validation exception', () {
        const message = 'Validation error';
        const exception = ValidationException(message: message);

        expect(exception.message, equals(message));
        expect(exception.code, isNull);
        expect(exception.error, isNull);
        expect(exception.stackTrace, isNull);
        expect(exception.field, isNull);
        expect(
          exception.userMessage,
          equals('Please check your input and try again.'),
        );
      });

      test('creates required field error with factory', () {
        const fieldName = 'email';
        final exception = ValidationException.required(fieldName);

        expect(exception.message, equals('$fieldName is required'));
        expect(exception.code, equals('VALIDATION_REQUIRED'));
        expect(exception.field, equals(fieldName));
      });

      test('creates invalid format error with factory', () {
        const fieldName = 'email';
        const format = 'example@domain.com';
        final exception = ValidationException.invalidFormat(fieldName, format);

        expect(
          exception.message,
          equals('$fieldName has invalid format: expected $format'),
        );
        expect(exception.code, equals('VALIDATION_FORMAT'));
        expect(exception.field, equals(fieldName));
      });
    });

    group('StorageException', () {
      test('creates basic storage exception', () {
        const message = 'Storage error';
        const exception = StorageException(message: message);

        expect(exception.message, equals(message));
        expect(exception.code, isNull);
        expect(exception.error, isNull);
        expect(exception.stackTrace, isNull);
        expect(
          exception.userMessage,
          equals('Unable to access storage. Please check app permissions.'),
        );
      });

      test('creates insufficient space error with factory', () {
        final exception = StorageException.insufficientSpace();

        expect(exception.message, equals('Insufficient storage space'));
        expect(exception.code, equals('STORAGE_SPACE'));
      });

      test('creates permission error with factory', () {
        final exception = StorageException.permission();

        expect(exception.message, equals('Storage permission denied'));
        expect(exception.code, equals('STORAGE_PERMISSION'));
      });
    });

    group('UnexpectedException', () {
      test('creates basic unexpected exception', () {
        const message = 'Something went wrong';
        const exception = UnexpectedException(message: message);

        expect(exception.message, equals(message));
        expect(exception.code, equals('UNEXPECTED'));
        expect(exception.error, isNull);
        expect(exception.stackTrace, isNull);
        expect(
          exception.userMessage,
          equals('An unexpected error occurred. Please try again later.'),
        );
      });
    });

    group('FeatureException', () {
      test('creates basic feature exception', () {
        const message = 'Feature error';
        const featureCode = 'PRAYERS';
        const exception = FeatureException(
          message: message,
          featureCode: featureCode,
        );

        expect(exception.message, equals(message));
        expect(exception.code, equals('FEATURE_$featureCode'));
        expect(exception.error, isNull);
        expect(exception.stackTrace, isNull);
        expect(exception.shouldDisplay, isTrue);
      });
    });
  });
}
