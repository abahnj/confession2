import 'package:confession/core/errors/app_exception.dart';
import 'package:confession/core/errors/error_handler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockErrorListener extends Mock implements ErrorListener {}

class TestException extends AppException {
  const TestException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
    this.shouldDisplayValue = true,
    this.shouldReportValue = true,
  });

  final bool shouldDisplayValue;
  final bool shouldReportValue;

  @override
  bool get shouldDisplay => shouldDisplayValue;

  @override
  bool get shouldReport => shouldReportValue;
}

class FakeAppException extends Fake implements AppException {}

// Setup to register a fallback value for AppException
void setupAppExceptionFallbacks() {
  registerFallbackValue(const TestException(message: 'Fallback Exception'));
}

void main() {
  late ErrorHandler errorHandler;
  late MockErrorListener mockListener;

  setUpAll(setupAppExceptionFallbacks);

  setUp(() {
    errorHandler = ErrorHandler.instance;
    mockListener = MockErrorListener();
  });

  tearDown(() {
    // Clean up any pending interactions from previous tests
    reset(mockListener);

    // Remove any listeners that might have been added
    try {
      errorHandler.removeListener(mockListener);
    } catch (_) {}
  });

  group('ErrorHandler', () {
    test('is a singleton', () {
      expect(ErrorHandler.instance, same(ErrorHandler.instance));
    });

    group('Listener Management', () {
      test('addListener adds a listener', () {
        // Act
        errorHandler.addListener(mockListener);

        // Create an exception that should be displayed
        const exception = TestException(message: 'Test error');

        // Trigger the error handler
        errorHandler.handleException(exception);

        // Assert the listener was called
        verify(() => mockListener.onError(exception)).called(1);
      });

      test('removeListener removes a listener', () {
        // Arrange
        errorHandler
          ..addListener(mockListener)

          // Act
          ..removeListener(mockListener);

        // Create an exception that should be displayed
        const exception = TestException(message: 'Test error');

        // Trigger the error handler
        errorHandler.handleException(exception);

        // Assert the listener was not called
        verifyNever(() => mockListener.onError(exception));
      });
    });

    group('Exception Handling', () {
      test('handleException calls listeners for displayable exceptions', () {
        // Arrange
        errorHandler.addListener(mockListener);

        // Act - exception that should be displayed
        const exception = TestException(
          message: 'Should be displayed',
        );

        errorHandler.handleException(exception);

        // Assert
        verify(() => mockListener.onError(exception)).called(1);
      });

      test(
          'handleException does not call listeners for non-displayable exceptions',
          () {
        // Arrange
        errorHandler.addListener(mockListener);

        // Act - exception that should not be displayed
        const exception = TestException(
          message: 'Should not be displayed',
          shouldDisplayValue: false,
        );

        errorHandler.handleException(exception);

        // Assert
        verifyNever(() => mockListener.onError(exception));
      });
    });

    group('Utility Methods', () {
      test('run executes function and handles exceptions', () async {
        // Arrange
        errorHandler.addListener(mockListener);

        // Act - function that completes successfully
        final result = await errorHandler.run(() async => 'success');

        // Assert
        expect(result, equals('success'));
        verifyNever(() => mockListener.onError(any()));
      });

      test('run catches and handles exceptions', () async {
        // Arrange
        errorHandler.addListener(mockListener);
        const exception = TestException(message: 'Async error');

        // Act & Assert - function that throws
        expect(
          () => errorHandler.run(() async => throw exception),
          throwsA(same(exception)),
        );

        // Let the event loop complete to handle the async error
        await Future<void>.delayed(Duration.zero);

        // Verify the error was handled
        verify(() => mockListener.onError(exception)).called(1);
      });

      test('runSync executes function and handles exceptions', () {
        // Arrange
        errorHandler.addListener(mockListener);

        // Act - function that completes successfully
        final result = errorHandler.runSync(() => 'success');

        // Assert
        expect(result, equals('success'));
        verifyNever(() => mockListener.onError(any()));
      });

      test('runSync catches and handles exceptions', () {
        // Arrange
        errorHandler.addListener(mockListener);
        const exception = TestException(message: 'Sync error');

        // Act & Assert - function that throws
        expect(
          () => errorHandler.runSync(() => throw exception),
          throwsA(same(exception)),
        );

        // Verify the error was handled
        verify(() => mockListener.onError(exception)).called(1);
      });
    });
  });
}
