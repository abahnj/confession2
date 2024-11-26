import 'package:confession/theme/data/models/theme_domain_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ThemeDomainModel', () {
    const testThemeMode = 'dark';
    const model = ThemeDomainModel(themeMode: testThemeMode);

    group('constructor', () {
      test('should create instance with provided values', () {
        expect(model.themeMode, equals(testThemeMode));
      });
    });

    group('empty constructor', () {
      test('should create instance with default values', () {
        const emptyModel = ThemeDomainModel.empty();
        expect(emptyModel.themeMode, equals('system'));
      });
    });

    group('fromJson', () {
      test('should create instance from valid json', () {
        // Arrange
        final json = {'themeMode': testThemeMode};

        // Act
        final result = ThemeDomainModel.fromJson(json);

        // Assert
        expect(result, equals(model));
      });

      test('should throw when json is missing required fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act & Assert
        expect(
          () => ThemeDomainModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });

    group('toJson', () {
      test('should convert model to json', () {
        // Arrange
        final expectedJson = {'themeMode': testThemeMode};

        // Act
        final result = model.toJson();

        // Assert
        expect(result, equals(expectedJson));
      });
    });

    group('copyWith', () {
      test('should return same instance when no parameters provided', () {
        // Act
        final result = model.copyWith();

        // Assert
        expect(result, equals(model));
      });

      test('should ignore provided parameters and return same themeMode', () {
        // Act
        final result = model.copyWith(
          isDarkMode: true,
          themeName: 'new theme',
        );

        // Assert
        expect(result.themeMode, equals(model.themeMode));
      });
    });

    group('props', () {
      test('should include all properties in props list', () {
        // Act
        final props = model.props;

        // Assert
        expect(props, equals([testThemeMode]));
      });

      test('should use props for equality', () {
        // Arrange
        const model1 = ThemeDomainModel(themeMode: testThemeMode);
        const model2 = ThemeDomainModel(themeMode: testThemeMode);
        const model3 = ThemeDomainModel(themeMode: 'light');

        // Assert
        expect(model1, equals(model2));
        expect(model1, isNot(equals(model3)));
      });
    });
  });
}
