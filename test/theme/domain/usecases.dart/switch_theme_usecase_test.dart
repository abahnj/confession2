import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/theme/data/mappers/theme_mapper.dart';
import 'package:confession/theme/data/models/theme_domain_model.dart';
import 'package:confession/theme/domain/entities/theme.dart';
import 'package:confession/theme/domain/repositories/theme_repository.dart';
import 'package:confession/theme/domain/usecases.dart/switch_theme_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockThemeRepository extends Mock implements ThemeRepository {}

class _MockThemeMapper extends Mock implements ThemeMapper {}

void main() {
  late SwitchThemeUseCase useCase;
  late _MockThemeRepository mockRepository;
  late _MockThemeMapper mockMapper;

  setUp(() {
    mockRepository = _MockThemeRepository();
    mockMapper = _MockThemeMapper();
    useCase = SwitchThemeUseCase(
      themeRepository: mockRepository,
      themeMapper: mockMapper,
    );

    // Register fallback value for ThemeDomainModel
    registerFallbackValue(const ThemeDomainModel(themeMode: 'system'));
  });

  group('SwitchThemeUseCase', () {
    test('should map theme mode and save to repository', () async {
      // Arrange
      const themeMode = AppThemeMode(themeMode: ThemeMode.dark);
      const domainModel = ThemeDomainModel(themeMode: 'dark');

      when(() => mockMapper.toDomainModel(themeMode)).thenReturn(domainModel);
      when(() => mockRepository.saveThemeSettings(any())).thenAnswer((_) => Future.value());

      // Act
      await useCase(const SaveThemeParam(theme: themeMode));

      // Assert
      verify(() => mockMapper.toDomainModel(themeMode)).called(1);
      verify(() => mockRepository.saveThemeSettings(domainModel)).called(1);
    });

    test('should propagate repository exceptions', () async {
      // Arrange
      const themeMode = AppThemeMode(themeMode: ThemeMode.light);
      const domainModel = ThemeDomainModel(themeMode: 'light');
      final exception = Exception('Failed to save theme');

      when(() => mockMapper.toDomainModel(themeMode)).thenReturn(domainModel);
      when(() => mockRepository.saveThemeSettings(any())).thenThrow(exception);

      // Act & Assert
      expect(
        () => useCase(const SaveThemeParam(theme: themeMode)),
        throwsA(equals(exception)),
      );
      verify(() => mockMapper.toDomainModel(themeMode)).called(1);
      verify(() => mockRepository.saveThemeSettings(domainModel)).called(1);
    });

    test('should propagate mapper exceptions', () async {
      // Arrange
      const themeMode = AppThemeMode(themeMode: ThemeMode.system);
      final exception = Exception('Mapping error');

      when(() => mockMapper.toDomainModel(themeMode)).thenThrow(exception);

      // Act & Assert
      expect(
        () => useCase(const SaveThemeParam(theme: themeMode)),
        throwsA(equals(exception)),
      );
      verify(() => mockMapper.toDomainModel(themeMode)).called(1);
      verifyNever(() => mockRepository.saveThemeSettings(any()));
    });

    test('should execute operations in correct order', () async {
      // Arrange
      const themeMode = AppThemeMode(themeMode: ThemeMode.dark);
      const domainModel = ThemeDomainModel(themeMode: 'dark');
      final executionOrder = <String>[];

      when(() => mockMapper.toDomainModel(themeMode)).thenAnswer((_) {
        executionOrder.add('mapper');
        return domainModel;
      });

      when(() => mockRepository.saveThemeSettings(any())).thenAnswer((_) async {
        executionOrder.add('repository');
      });

      // Act
      await useCase(const SaveThemeParam(theme: themeMode));

      // Assert
      expect(executionOrder, equals(['mapper', 'repository']));
    });

    group('initialization', () {
      test('should create use case with provided dependencies', () {
        expect(useCase, isNotNull);
        expect(useCase, isA<AsyncParamUseCase<SaveThemeParam>>());
      });
    });

    test('should handle all theme modes correctly', () async {
      // Test all possible theme modes
      final themeModes = ThemeMode.values.map((value) => AppThemeMode(themeMode: value)).toList();

      for (final themeMode in themeModes) {
        // Arrange
        final domainModel = ThemeDomainModel(themeMode: themeMode.toString().split('.').last);

        when(() => mockMapper.toDomainModel(themeMode)).thenReturn(domainModel);
        when(() => mockRepository.saveThemeSettings(any())).thenAnswer((_) => Future.value());

        // Act
        await useCase(SaveThemeParam(theme: themeMode));

        // Assert
        verify(() => mockMapper.toDomainModel(themeMode)).called(1);
        verify(() => mockRepository.saveThemeSettings(domainModel)).called(1);
      }
    });
  });
}
