// ignore_for_file: only_throw_errors

import 'dart:io';

import 'package:confession/core/platform/path_provider/path_provider.dart';
import 'package:confession/core/platform/path_provider/path_provider_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDirectory extends Mock implements Directory {}

void main() {
  group('PathProviderImpl Tests', () {
    late _MockDirectory mockDocumentsDirectory;
    late _MockDirectory mockTempDirectory;
    late PathProvider provider;
    late GetDirectoryCallback mockGetDocumentsDirectory;
    late GetDirectoryCallback mockGetTempDirectory;

    setUp(() {
      mockDocumentsDirectory = _MockDirectory();
      mockTempDirectory = _MockDirectory();

      // Initialize callback mocks
      mockGetDocumentsDirectory = () async => mockDocumentsDirectory;
      mockGetTempDirectory = () async => mockTempDirectory;

      provider = PathProviderImpl(
        getDocumentsDirectory: mockGetDocumentsDirectory,
        getTempDirectory: mockGetTempDirectory,
      );
    });

    group('getApplicationDocumentsDirectory', () {
      test('returns correct directory on success', () async {
        final directory = await provider.getApplicationDocumentsDirectory();

        expect(directory, equals(mockDocumentsDirectory));
      });

      test('throws PathProviderException when callback throws', () async {
        final failingProvider = PathProviderImpl(
          getDocumentsDirectory: () async => throw Exception('Test error'),
          getTempDirectory: mockGetTempDirectory,
        );

        await expectLater(
          failingProvider.getApplicationDocumentsDirectory(),
          throwsA(
            isA<PathProviderException>()
                .having(
                  (e) => e.message,
                  'message',
                  'Failed to get application documents directory',
                )
                .having(
                  (e) => e.error,
                  'error',
                  isA<Exception>(),
                ),
          ),
        );
      });

      test('propagates original error in exception', () async {
        const originalError = FileSystemException('Original error');
        final failingProvider = PathProviderImpl(
          getDocumentsDirectory: () async => throw originalError,
          getTempDirectory: mockGetTempDirectory,
        );

        try {
          await failingProvider.getApplicationDocumentsDirectory();
          fail('Should have thrown PathProviderException');
        } catch (e) {
          expect(e, isA<PathProviderException>());
          final exception = e as PathProviderException;
          expect(exception.error, equals(originalError));
        }
      });
    });

    group('getTemporaryDirectory', () {
      test('returns correct directory on success', () async {
        final directory = await provider.getTemporaryDirectory();

        expect(directory, equals(mockTempDirectory));
      });

      test('throws PathProviderException when callback throws', () async {
        final failingProvider = PathProviderImpl(
          getDocumentsDirectory: mockGetDocumentsDirectory,
          getTempDirectory: () async => throw Exception('Test error'),
        );

        await expectLater(
          failingProvider.getTemporaryDirectory(),
          throwsA(
            isA<PathProviderException>()
                .having(
                  (e) => e.message,
                  'message',
                  'Failed to get temporary directory',
                )
                .having(
                  (e) => e.error,
                  'error',
                  isA<Exception>(),
                ),
          ),
        );
      });

      test('propagates original error in exception', () async {
        const originalError = FileSystemException('Original error');
        final failingProvider = PathProviderImpl(
          getDocumentsDirectory: mockGetDocumentsDirectory,
          getTempDirectory: () async => throw originalError,
        );

        try {
          await failingProvider.getTemporaryDirectory();
          fail('Should have thrown PathProviderException');
        } catch (e) {
          expect(e, isA<PathProviderException>());
          final exception = e as PathProviderException;
          expect(exception.error, equals(originalError));
        }
      });
    });

    group('Integration Tests', () {
      test('handles multiple successive calls correctly', () async {
        // First calls
        final docsDir1 = await provider.getApplicationDocumentsDirectory();
        final tempDir1 = await provider.getTemporaryDirectory();

        // Second calls
        final docsDir2 = await provider.getApplicationDocumentsDirectory();
        final tempDir2 = await provider.getTemporaryDirectory();

        expect(docsDir1, equals(mockDocumentsDirectory));
        expect(docsDir2, equals(mockDocumentsDirectory));
        expect(tempDir1, equals(mockTempDirectory));
        expect(tempDir2, equals(mockTempDirectory));
      });

      test('handles concurrent calls correctly', () async {
        final futures = await Future.wait([
          provider.getApplicationDocumentsDirectory(),
          provider.getTemporaryDirectory(),
        ]);

        expect(futures[0], equals(mockDocumentsDirectory));
        expect(futures[1], equals(mockTempDirectory));
      });
    });

    group('Error Scenarios', () {
      test('handles different types of errors correctly', () async {
        final errors = [
          Exception('Basic exception'),
          const FileSystemException('File system error'),
          StateError('State error'),
          ArgumentError('Argument error'),
        ];

        for (final error in errors) {
          final failingProvider = PathProviderImpl(
            getDocumentsDirectory: () async => throw error,
            getTempDirectory: () async => throw error,
          );

          await expectLater(
            failingProvider.getApplicationDocumentsDirectory(),
            throwsA(
              isA<PathProviderException>()
                  .having((e) => e.error, 'error', equals(error)),
            ),
          );

          await expectLater(
            failingProvider.getTemporaryDirectory(),
            throwsA(
              isA<PathProviderException>()
                  .having((e) => e.error, 'error', equals(error)),
            ),
          );
        }
      });

      test('handles delayed errors correctly', () async {
        final delayedFailingProvider = PathProviderImpl(
          getDocumentsDirectory: () async {
            await Future<void>.delayed(const Duration(milliseconds: 100));
            throw Exception('Delayed error');
          },
          getTempDirectory: mockGetTempDirectory,
        );

        await expectLater(
          delayedFailingProvider.getApplicationDocumentsDirectory(),
          throwsA(isA<PathProviderException>()),
        );
      });
    });

    group('Edge Cases', () {
      test('handles zero-length delay correctly', () async {
        final quickProvider = PathProviderImpl(
          getDocumentsDirectory: () async {
            await Future<void>.delayed(Duration.zero);
            return mockDocumentsDirectory;
          },
          getTempDirectory: () async {
            await Future<void>.delayed(Duration.zero);
            return mockTempDirectory;
          },
        );

        final docsDir = await quickProvider.getApplicationDocumentsDirectory();
        final tempDir = await quickProvider.getTemporaryDirectory();

        expect(docsDir, equals(mockDocumentsDirectory));
        expect(tempDir, equals(mockTempDirectory));
      });

      test('handles very quick successive calls', () async {
        await Future.wait(
          List.generate(
            10,
            (_) => provider.getApplicationDocumentsDirectory(),
          ),
        );

        await Future.wait(
          List.generate(
            10,
            (_) => provider.getTemporaryDirectory(),
          ),
        );
      });
    });
  });
}
