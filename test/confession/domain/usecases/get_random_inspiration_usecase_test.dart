import 'package:confession/confession/domain/usecases/get_random_inspiration_usecase.dart';
import 'package:confession/database/app_database.dart';
import 'package:confession/prayers/data/mappers/prayers_mapper.dart';
import 'package:confession/prayers/domain/entities/inspiration.dart';
import 'package:confession/prayers/domain/repositories/prayers_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPrayersRepository extends Mock implements PrayersRepository {}

class MockInspirationsMapper extends Mock implements InspirationsMapper {}

void main() {
  late GetRandomInspirationUsecase usecase;
  late MockPrayersRepository mockRepository;
  late MockInspirationsMapper mockMapper;

  setUp(() {
    mockRepository = MockPrayersRepository();
    mockMapper = MockInspirationsMapper();
    usecase = GetRandomInspirationUsecase(
      repository: mockRepository,
      inspirationsMapper: mockMapper,
    );
  });

  group('GetRandomInspirationUsecase', () {
    const dbInspiration = InspirationsTableData(
      id: 1,
      quote: 'Test inspiration quote',
      author: 'Test Author',
    );

    const mappedInspiration = Inspiration(
      quote: 'Test inspiration quote',
      author: 'Test Author',
    );

    test('should get random inspiration from the repository and map it',
        () async {
      // Arrange
      when(() => mockRepository.getRandomInspiration())
          .thenAnswer((_) async => dbInspiration);
      when(() => mockMapper.toViewData(dbInspiration))
          .thenReturn(mappedInspiration);

      // Act
      final result = await usecase();

      // Assert
      expect(result, equals(mappedInspiration));
      verify(() => mockRepository.getRandomInspiration()).called(1);
      verify(() => mockMapper.toViewData(dbInspiration)).called(1);
      verifyNoMoreInteractions(mockRepository);
      verifyNoMoreInteractions(mockMapper);
    });

    test('should throw exception when repository returns null', () async {
      // Arrange
      when(() => mockRepository.getRandomInspiration())
          .thenAnswer((_) async => null);

      // Act & Assert
      expect(
        () => usecase(),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('No inspiration found'),
          ),
        ),
      );
      verify(() => mockRepository.getRandomInspiration()).called(1);
      verifyNoMoreInteractions(mockRepository);
      verifyZeroInteractions(mockMapper);
    });

    test('should throw exception when repository fails', () async {
      // Arrange
      final exception = Exception('Failed to get inspiration');
      when(() => mockRepository.getRandomInspiration()).thenThrow(exception);

      // Act & Assert
      expect(
        () => usecase(),
        throwsA(same(exception)),
      );
      verify(() => mockRepository.getRandomInspiration()).called(1);
      verifyNoMoreInteractions(mockRepository);
      verifyZeroInteractions(mockMapper);
    });
  });
}
