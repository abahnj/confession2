import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/theme/data/mappers/theme_mapper.dart';
import 'package:confession/theme/data/models/theme_domain_model.dart';
import 'package:confession/theme/domain/entities/theme.dart';
import 'package:confession/theme/domain/repositories/theme_repository.dart';
import 'package:confession/theme/domain/usecases.dart/get_theme_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Create mocks
class _MockThemeRepository extends Mock implements ThemeRepository {}

class _MockThemeMapper extends Mock implements ThemeMapper {}

void main() {
  late GetThemeUseCase useCase;
  late _MockThemeRepository mockRepository;
  late _MockThemeMapper mockMapper;

  // Test data
  const testThemeDomainModel = ThemeDomainModel(themeMode: 'dark');
  const testAppThemeMode = AppThemeMode(themeMode: ThemeMode.dark);

  setUpAll(() {
    registerFallbackValue(const ThemeDomainModel.empty());
  });

  setUp(() {
    mockRepository = _MockThemeRepository();
    mockMapper = _MockThemeMapper();
    useCase = GetThemeUseCase(
      themeRepository: mockRepository,
      themeMapper: mockMapper,
    );
  });

  group('GetThemeUseCase', () {
    test('should get theme settings from repository and map to AppThemeMode', () async {
      // Arrange
      when(() => mockRepository.getThemeSettings()).thenAnswer((_) async => testThemeDomainModel);
      when(() => mockMapper.toViewData(testThemeDomainModel)).thenReturn(testAppThemeMode);

      // Act
      final result = await useCase(const NoParams());

      // Assert
      expect(result, equals(testAppThemeMode));
      verify(() => mockRepository.getThemeSettings()).called(1);
      verify(() => mockMapper.toViewData(testThemeDomainModel)).called(1);
    });

    test('should propagate repository exceptions', () async {
      // Arrange
      final exception = Exception('Repository error');
      when(() => mockRepository.getThemeSettings()).thenThrow(exception);

      // Act & Assert
      expect(
        () => useCase(const NoParams()),
        throwsA(equals(exception)),
      );
      verify(() => mockRepository.getThemeSettings()).called(1);
      verifyNever(() => mockMapper.toViewData(any()));
    });

    test('should propagate mapper exceptions', () async {
      // Arrange
      final exception = Exception('Mapping error');
      when(() => mockRepository.getThemeSettings()).thenAnswer((_) async => testThemeDomainModel);
      when(() => mockMapper.toViewData(any())).thenThrow(exception);

      // Act & Assert
      expect(
        () => useCase(const NoParams()),
        throwsA(equals(exception)),
      );
      verify(() => mockRepository.getThemeSettings()).called(1);
    });

    group('initialization', () {
      test('should create use case with provided dependencies', () {
        // Assert
        expect(useCase, isNotNull);
        expect(useCase, isA<AsyncViewDataParamUseCase<AppThemeMode, NoParams>>());
      });
    });

    test('should handle empty theme model correctly', () async {
      // Arrange
      const emptyThemeModel = ThemeDomainModel.empty();
      const defaultThemeMode = AppThemeMode(themeMode: ThemeMode.system);

      when(() => mockRepository.getThemeSettings()).thenAnswer((_) async => emptyThemeModel);
      when(() => mockMapper.toViewData(emptyThemeModel)).thenReturn(defaultThemeMode);

      // Act
      final result = await useCase(const NoParams());

      // Assert
      expect(result, equals(defaultThemeMode));
      verify(() => mockRepository.getThemeSettings()).called(1);
      verify(() => mockMapper.toViewData(emptyThemeModel)).called(1);
    });

    test('should execute in correct order', () async {
      // Arrange
      final executionOrder = <String>[];

      when(() => mockRepository.getThemeSettings()).thenAnswer((_) async {
        executionOrder.add('repository');
        return testThemeDomainModel;
      });

      when(() => mockMapper.toViewData(testThemeDomainModel)).thenAnswer((_) {
        executionOrder.add('mapper');
        return testAppThemeMode;
      });

      // Act
      await useCase(const NoParams());

      // Assert
      expect(executionOrder, equals(['repository', 'mapper']));
    });
  });
}
