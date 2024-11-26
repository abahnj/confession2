import 'package:confession/theme/data/mappers/theme_mapper.dart';
import 'package:confession/theme/data/models/theme_domain_model.dart';
import 'package:confession/theme/domain/entities/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ThemeMapper mapper;

  setUp(() {
    mapper = ThemeMapper();
  });

  group('ThemeMapper', () {
    group('toDomainModel', () {
      test('should convert AppThemeMode.system to ThemeDomainModel', () {
        // Arrange
        const viewData = AppThemeMode(themeMode: ThemeMode.system);
        const expected = ThemeDomainModel(themeMode: 'system');

        // Act
        final result = mapper.toDomainModel(viewData);

        // Assert
        expect(result.themeMode, equals(expected.themeMode));
      });

      test('should convert AppThemeMode.light to ThemeDomainModel', () {
        // Arrange
        const viewData = AppThemeMode(themeMode: ThemeMode.light);
        const expected = ThemeDomainModel(themeMode: 'light');

        // Act
        final result = mapper.toDomainModel(viewData);

        // Assert
        expect(result.themeMode, equals(expected.themeMode));
      });

      test('should convert AppThemeMode.dark to ThemeDomainModel', () {
        // Arrange
        const viewData = AppThemeMode(themeMode: ThemeMode.dark);
        const expected = ThemeDomainModel(themeMode: 'dark');

        // Act
        final result = mapper.toDomainModel(viewData);

        // Assert
        expect(result.themeMode, equals(expected.themeMode));
      });

      test('should handle all possible ThemeMode values', () {
        for (final themeMode in ThemeMode.values) {
          // Arrange
          final viewData = AppThemeMode(themeMode: themeMode);
          final expected = ThemeDomainModel(themeMode: themeMode.name);

          // Act
          final result = mapper.toDomainModel(viewData);

          // Assert
          expect(
            result.themeMode,
            equals(expected.themeMode),
            reason: 'Failed for ThemeMode.${themeMode.name}',
          );
        }
      });
    });

    group('toViewData', () {
      test('should convert system ThemeDomainModel to AppThemeMode', () {
        // Arrange
        const model = ThemeDomainModel(themeMode: 'system');
        const expected = AppThemeMode(themeMode: ThemeMode.system);

        // Act
        final result = mapper.toViewData(model);

        // Assert
        expect(result.themeMode, equals(expected.themeMode));
      });

      test('should convert light ThemeDomainModel to AppThemeMode', () {
        // Arrange
        const model = ThemeDomainModel(themeMode: 'light');
        const expected = AppThemeMode(themeMode: ThemeMode.light);

        // Act
        final result = mapper.toViewData(model);

        // Assert
        expect(result.themeMode, equals(expected.themeMode));
      });

      test('should convert dark ThemeDomainModel to AppThemeMode', () {
        // Arrange
        const model = ThemeDomainModel(themeMode: 'dark');
        const expected = AppThemeMode(themeMode: ThemeMode.dark);

        // Act
        final result = mapper.toViewData(model);

        // Assert
        expect(result.themeMode, equals(expected.themeMode));
      });

      test('should throw when ThemeDomainModel has invalid theme mode', () {
        // Arrange
        const model = ThemeDomainModel(themeMode: 'invalid_mode');

        // Act & Assert
        expect(
          () => mapper.toViewData(model),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('should handle empty ThemeDomainModel correctly', () {
        // Arrange
        const model = ThemeDomainModel.empty();
        const expected = AppThemeMode(themeMode: ThemeMode.system);

        // Act
        final result = mapper.toViewData(model);

        // Assert
        expect(result.themeMode, equals(expected.themeMode));
      });
    });

    group('bidirectional conversion', () {
      test('should maintain data integrity when converting back and forth', () {
        for (final themeMode in ThemeMode.values) {
          // Arrange
          final initialViewData = AppThemeMode(themeMode: themeMode);

          // Act
          final domainModel = mapper.toDomainModel(initialViewData);
          final finalViewData = mapper.toViewData(domainModel);

          // Assert
          expect(
            finalViewData.themeMode,
            equals(initialViewData.themeMode),
            reason: 'Failed for ThemeMode.${themeMode.name}',
          );
        }
      });

      test(
          'should maintain data integrity when converting from domain to view and back',
          () {
        final themeModeNames = ThemeMode.values.map((e) => e.name).toList();

        for (final themeModeName in themeModeNames) {
          // Arrange
          final initialDomainModel = ThemeDomainModel(themeMode: themeModeName);

          // Act
          final viewData = mapper.toViewData(initialDomainModel);
          final finalDomainModel = mapper.toDomainModel(viewData);

          // Assert
          expect(
            finalDomainModel.themeMode,
            equals(initialDomainModel.themeMode),
            reason: 'Failed for themeMode: $themeModeName',
          );
        }
      });
    });
  });
}
