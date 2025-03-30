import 'package:bloc_test/bloc_test.dart';
import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/prayers/domain/entities/prayer.dart';
import 'package:confession/prayers/domain/usecases/get_prayers_usecase.dart';
import 'package:confession/prayers/presentation/bloc/prayers_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPrayersUsecase extends Mock implements GetPrayersUsecase {}

void main() {
  late PrayersBloc prayersBloc;
  late MockGetPrayersUsecase mockGetPrayersUsecase;

  setUp(() {
    mockGetPrayersUsecase = MockGetPrayersUsecase();
    prayersBloc = PrayersBloc(getPrayersUsecase: mockGetPrayersUsecase);
  });

  tearDown(() {
    prayersBloc.close();
  });

  group('PrayersBloc', () {
    const testPrayers = PrayerList(
      data: [
        Prayer(
          prayerName: 'Test Prayer 1',
          text: 'Prayer text 1',
        ),
        Prayer(
          prayerName: 'Test Prayer 2',
          text: 'Prayer text 2',
        ),
      ],
    );

    test('initial state should be Loading', () {
      expect(prayersBloc.state, const BlocState<PrayerList>.loading());
    });

    blocTest<PrayersBloc, BlocState<PrayerList>>(
      'emits [Loading, Success] when prayers are fetched successfully',
      build: () {
        when(() => mockGetPrayersUsecase())
            .thenAnswer((_) async => testPrayers);
        return prayersBloc;
      },
      act: (bloc) => bloc.add(const BlocEvent.noParam()),
      expect: () => [
        const BlocState<PrayerList>.loading(),
        const BlocState<PrayerList>.success(data: testPrayers),
      ],
      verify: (_) {
        verify(() => mockGetPrayersUsecase()).called(1);
      },
    );

    blocTest<PrayersBloc, BlocState<PrayerList>>(
      'emits [Loading, Error] when error occurs',
      build: () {
        when(() => mockGetPrayersUsecase())
            .thenThrow(Exception('Failed to fetch prayers'));
        return prayersBloc;
      },
      act: (bloc) => bloc.add(const BlocEvent.noParam()),
      expect: () => [
        const BlocState<PrayerList>.loading(),
        const BlocState<PrayerList>.error(),
      ],
      verify: (_) {
        verify(() => mockGetPrayersUsecase()).called(1);
      },
    );

    blocTest<PrayersBloc, BlocState<PrayerList>>(
      'handles multiple events properly',
      build: () {
        when(() => mockGetPrayersUsecase())
            .thenAnswer((_) async => testPrayers);
        return prayersBloc;
      },
      act: (bloc) => bloc
        ..add(const BlocEvent.noParam())
        ..add(const BlocEvent.noParam()),
      expect: () => [
        const BlocState<PrayerList>.loading(),
        const BlocState<PrayerList>.success(data: testPrayers),
        const BlocState<PrayerList>.loading(),
        const BlocState<PrayerList>.success(data: testPrayers),
      ],
      verify: (_) {
        verify(() => mockGetPrayersUsecase()).called(2);
      },
    );
  });
}
