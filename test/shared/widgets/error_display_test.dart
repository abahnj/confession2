import 'package:confession/core/errors/app_exception.dart';
import 'package:confession/shared/widgets/error_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ErrorDisplay', () {
    testWidgets('inline error display renders correctly',
        (WidgetTester tester) async {
      // Arrange
      const exception = UnexpectedException(message: 'Test error');
      var retryPressed = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorDisplay(
              exception: exception,
              onRetry: () => retryPressed = true,
              displayType: ErrorDisplayType.inline,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(exception.userMessage), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);

      // Test retry button
      await tester.tap(find.text('Retry'));
      await tester.pump();
      expect(retryPressed, isTrue);
    });

    testWidgets('dialog content renders correctly',
        (WidgetTester tester) async {
      // Arrange
      const exception = UnexpectedException(message: 'Test error');
      var retryPressed = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorDisplay(
              exception: exception,
              onRetry: () => retryPressed = true,
              displayType: ErrorDisplayType.dialog,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(exception.userMessage), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      // Test retry button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(retryPressed, isTrue);
    });

    testWidgets('snackbar content renders correctly',
        (WidgetTester tester) async {
      // Arrange
      const exception = UnexpectedException(message: 'Test error');
      var retryPressed = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorDisplay(
              exception: exception,
              onRetry: () => retryPressed = true,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(exception.userMessage), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);

      // Test retry button
      await tester.tap(find.text('Retry'));
      await tester.pump();
      expect(retryPressed, isTrue);
    });

    testWidgets('page error renders correctly', (WidgetTester tester) async {
      // Arrange
      const exception = UnexpectedException(message: 'Test error');
      var retryPressed = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorDisplay(
              exception: exception,
              onRetry: () => retryPressed = true,
              displayType: ErrorDisplayType.page,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(exception.userMessage), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      // Test retry button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(retryPressed, isTrue);
    });

    testWidgets('shows different icon for NetworkException',
        (WidgetTester tester) async {
      // Arrange
      final exception = NetworkException.connection();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorDisplay(
              exception: exception,
              displayType: ErrorDisplayType.page,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.wifi_off), findsOneWidget);
    });

    testWidgets('shows different icon for AuthException',
        (WidgetTester tester) async {
      // Arrange
      final exception = AuthException.unauthorized();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorDisplay(
              exception: exception,
              displayType: ErrorDisplayType.page,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.lock), findsOneWidget);
    });

    testWidgets('showErrorDialog displays dialog with error',
        (WidgetTester tester) async {
      // Arrange
      const exception = UnexpectedException(message: 'Test error');

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      ErrorDisplay.showErrorDialog(context, exception);
                    },
                    child: const Text('Show Dialog'),
                  ),
                ),
              );
            },
          ),
        ),
      );

      // Open dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text(exception.userMessage), findsOneWidget);
      expect(find.text('Close'), findsOneWidget);

      // Close dialog
      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets('showErrorSnackBar displays snackbar with error',
        (WidgetTester tester) async {
      // Arrange
      const exception = UnexpectedException(message: 'Test error');

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      ErrorDisplay.showErrorSnackBar(context, exception);
                    },
                    child: const Text('Show Snackbar'),
                  ),
                ),
              );
            },
          ),
        ),
      );

      // Open snackbar
      await tester.tap(find.text('Show Snackbar'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text(exception.userMessage), findsOneWidget);
    });
  });
}
