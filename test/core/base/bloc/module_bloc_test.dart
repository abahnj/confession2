// ignore_for_file: cascade_invocations

import 'package:bloc_test/bloc_test.dart';
import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/base/bloc/module_bloc.dart';
import 'package:confession/core/base/view_data.dart';
import 'package:confession/domain/usecases/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _Payload extends Param {
  const _Payload({required this.data});
  final String data;

  @override
  List<Object?> get props => [data];
}

class _TestEvent extends BlocEvent<_Payload> {
  const _TestEvent({required this.payload}) : super(argument: payload);

  final _Payload payload;

  @override
  List<Object?> get props => [payload];
}

class _TestViewData extends ViewData {
  const _TestViewData({required this.data});
  final String data;

  @override
  List<Object?> get props => [data];
}

class _TestModuleBloc extends ModuleBloc<_TestEvent, _TestViewData> {
  _TestModuleBloc() : super(const BlocState.initial()) {
    on<_TestEvent>(
      (event, emit) async {
        await handleEvent(event, emit);
      },
    );
  }

  bool handleEventCalled = false;
  bool listenToAppLifecycleCalled = false;

  @override
  Future<void> handleEvent(
    _TestEvent event,
    Emitter<BlocState<_TestViewData>> emit,
  ) async {
    handleEventCalled = true;
    emit(BlocState.success(data: _TestViewData(data: event.payload.data)));
  }

  @override
  void listenToAppLifecycle() {
    listenToAppLifecycleCalled = true;
  }
}

class _DefaultModuleBloc extends ModuleBloc<_TestEvent, _TestViewData> {
  _DefaultModuleBloc() : super(const BlocState.initial());

  @override
  Future<void> handleEvent(
    _TestEvent event,
    Emitter<BlocState<_TestViewData>> emit,
  ) async {}
}

class _MockEmitter extends Mock implements Emitter<BlocState<_TestViewData>> {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      const _TestEvent(payload: _Payload(data: 'fallback')),
    );
    registerFallbackValue(const _TestViewData(data: 'fallback'));
    registerFallbackValue(const BlocState<_TestViewData>.initial());
  });

  group('map', () {
    test('should return `initial` when state is Initial', () {
      const expectedValue = 'initial';

      // act
      const state = Initial<_TestViewData>();
      final result = state.map(
        initial: () => expectedValue,
        loading: () => 'loading',
        success: (_) => 'success',
        error: () => 'error',
      );

      // assert
      expect(result, expectedValue);
    });

    test('should return `loading` when state is Loading', () {
      const expectedValue = 'loading';

      // act
      const state = Loading<_TestViewData>();
      final result = state.map(
        initial: () => 'initial',
        loading: () => expectedValue,
        success: (_) => 'success',
        error: () => 'error',
      );

      // assert
      expect(result, expectedValue);
    });

    test('should return `value` when state is Success', () {
      const expectedValue = _TestViewData(data: 'test');

      // act
      const state = Success<_TestViewData>(data: expectedValue);
      final result = state.map(
        initial: () => 'initial',
        loading: () => 'loading',
        success: (data) => data,
        error: () => 'error',
      );

      // assert
      expect(result, expectedValue);
    });

    test('should return `error` when state is Error', () {
      const expectedValue = 'error';

      // act
      const state = Error<_TestViewData>();
      final result = state.map(
        initial: () => 'initial',
        loading: () => 'loading',
        success: (_) => 'success',
        error: () => expectedValue,
      );

      // assert
      expect(result, expectedValue);
    });
  });

  group('mapOrElse', () {
    test(
        'should return `orElse` value when state is Initial and not provided in map',
        () {
      const expectedValue = 'orElse';

      // act
      const state = Initial<_TestViewData>();
      final result = state.mapOrElse(
        orElse: () => expectedValue,
        loading: () => 'loading',
        success: (_) => 'success',
        error: () => 'error',
      );

      // assert
      expect(result, expectedValue);
    });

    test(
        'should return `orElse` value when state is Loading and not provided in map',
        () {
      const expectedValue = 'orElse';

      // act
      const state = Loading<_TestViewData>();
      final result = state.mapOrElse(
        orElse: () => expectedValue,
        initial: () => 'initial',
        success: (_) => 'success',
        error: () => 'error',
      );

      // assert
      expect(result, expectedValue);
    });

    test(
        'should return `orElse` value when state is Success and not provided in map',
        () {
      const expectedValue = 'orElse';

      // act
      const state = Success<_TestViewData>(data: _TestViewData(data: 'test'));
      final result = state.mapOrElse(
        orElse: () => expectedValue,
        initial: () => 'initial',
        loading: () => 'loading',
        error: () => 'error',
      );

      // assert
      expect(result, expectedValue);
    });

    test(
        'should return `orElse` value when state is Error and not provided in map',
        () {
      const expectedValue = 'orElse';

      // act
      const state = Error<_TestViewData>();
      final result = state.mapOrElse(
        orElse: () => expectedValue,
        initial: () => 'initial',
        success: (_) => 'success',
      );

      // assert
      expect(result, expectedValue);
    });

    test('should return `orElse` value when no other state is provided in map',
        () {
      const expectedValue = 'orElse';

      // act
      const state = Error<_TestViewData>();
      final result = state.mapOrElse(orElse: () => expectedValue);

      // assert
      expect(result, expectedValue);
    });
  });

  group('maybeMap', () {
    test('should call `initial` when state is Initial', () {
      var isCalled = false;

      // act
      const state = Initial<_TestViewData>();
      state.maybeMap(
        initial: () => isCalled = true,
        loading: () => isCalled = false,
        success: (_) => isCalled = false,
        error: () => isCalled = false,
      );

      // assert
      expect(isCalled, isTrue);
    });

    test('should call `loading` when state is Loading', () {
      var isCalled = false;

      // act
      const state = Loading<_TestViewData>();
      state.maybeMap(
        initial: () => isCalled = false,
        loading: () => isCalled = true,
        success: (_) => isCalled = false,
        error: () => isCalled = false,
      );

      // assert
      expect(isCalled, isTrue);
    });

    test('should call `success` when state is Success', () {
      var isCalled = false;

      // act
      const state = Success<_TestViewData>(data: _TestViewData(data: 'test'));
      state.maybeMap(
        initial: () => isCalled = false,
        loading: () => isCalled = false,
        success: (_) => isCalled = true,
        error: () => isCalled = false,
      );

      // assert
      expect(isCalled, isTrue);
    });

    test('should call `error` when state is Error', () {
      var isCalled = false;

      // act
      const state = Error<_TestViewData>();
      state.maybeMap(
        initial: () => isCalled = false,
        loading: () => isCalled = false,
        success: (_) => isCalled = false,
        error: () => isCalled = true,
      );

      // assert
      expect(isCalled, isTrue);
    });
  });

  group('initial', () {
    const value = Initial<_TestViewData>();

    test('should be a `BlocState` type', () {
      expect(value, isA<BlocState>());
    });

    test('should be equal to `BlocState.initial()`', () {
      expect(value, const BlocState<_TestViewData>.initial());
    });
  });

  group('loading', () {
    const value = Loading<_TestViewData>();

    test('should be a `BlocState` type', () {
      expect(value, isA<BlocState>());
    });

    test('should be equal to `BlocState.loading()`', () {
      expect(value, const BlocState<_TestViewData>.loading());
    });
  });

  group('success', () {
    const value = Success<_TestViewData>(data: _TestViewData(data: 'test'));

    test('should be a `BlocState` type', () {
      expect(value, isA<BlocState>());
    });

    test('should infer correct `BlocState` type', () {
      const value = Success(data: _TestViewData(data: 'test'));

      expect(value, isA<Success<_TestViewData>>());
    });

    test('should be equal to `BlocState.success()`', () {
      expect(
        value,
        const BlocState<_TestViewData>.success(
          data: _TestViewData(data: 'test'),
        ),
      );
    });
  });

  group('error', () {
    const value = Error<_TestViewData>();

    test('should be a `BlocState` type', () {
      expect(value, isA<BlocState>());
    });

    test('should be equal to `BlocState.error()`', () {
      expect(value, const BlocState<_TestViewData>.error());
    });
  });

  group('ModuleBloc Tests', () {
    late _TestModuleBloc bloc;
    late _MockEmitter emitter;

    setUp(() {
      bloc = _TestModuleBloc();
      emitter = _MockEmitter();
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is correct', () {
      expect(bloc.state, const BlocState<_TestViewData>.initial());
    });

    group('handleEvent', () {
      blocTest<_TestModuleBloc, BlocState<_TestViewData>>(
        'emits [loaded] when event is added',
        build: _TestModuleBloc.new,
        act: (bloc) =>
            bloc.add(const _TestEvent(payload: _Payload(data: 'test data'))),
        expect: () => [
          isA<BlocState<_TestViewData>>().having(
            (state) => state.mapOrElse(
              success: (data) => data.data == 'test data',
              orElse: () => false,
            ),
            'loaded state with correct data',
            true,
          ),
        ],
        verify: (bloc) {
          expect(bloc.handleEventCalled, isTrue);
        },
      );

      test('handleEvent method processes event correctly', () async {
        const event = _TestEvent(payload: _Payload(data: 'test data'));
        await bloc.handleEvent(event, emitter);

        verify(
          () => emitter.call(any<BlocState<_TestViewData>>()),
        ).called(1);

        expect(bloc.handleEventCalled, isTrue);
      });
    });

    group('listenToAppLifecycle', () {
      test('default implementation throws UnimplementedError', () {
        final defaultBloc = _DefaultModuleBloc();
        expect(
          defaultBloc.listenToAppLifecycle,
          throwsA(isA<UnimplementedError>()),
        );
      });

      test('overridden implementation executes correctly', () {
        bloc.listenToAppLifecycle();
        expect(bloc.listenToAppLifecycleCalled, isTrue);
      });
    });

    group('props', () {
      test('success props returns correct properties', () {
        const state = Success<_TestViewData>(data: _TestViewData(data: 'test'));
        expect(
          state.props,
          equals([state.data]),
        );
      });

      test('error props returns correct properties', () {
        const state = Error<_TestViewData>();
        expect(
          state.props,
          equals([]),
        );
      });

      test('loading props returns correct properties', () {
        const state = Loading<_TestViewData>();
        expect(
          state.props,
          equals([]),
        );
      });

      test('initial props returns correct properties', () {
        const state = Initial<_TestViewData>();
        expect(
          state.props,
          equals([]),
        );
      });
    });

    group('State Management', () {
      blocTest<_TestModuleBloc, BlocState<_TestViewData>>(
        'handles state transitions correctly',
        build: _TestModuleBloc.new,
        act: (bloc) =>
            bloc.add(const _TestEvent(payload: _Payload(data: 'test data'))),
        expect: () => [
          isA<BlocState<_TestViewData>>().having(
            (state) => state.mapOrElse(
              success: (data) => data.data == 'test data',
              orElse: () => false,
            ),
            'transitions to loaded state',
            true,
          ),
        ],
      );

      blocTest<_TestModuleBloc, BlocState<_TestViewData>>(
        'maintains correct state sequence',
        build: _TestModuleBloc.new,
        act: (bloc) async {
          bloc.add(const _TestEvent(payload: _Payload(data: 'test data 1')));
          await Future<void>.delayed(const Duration(milliseconds: 100));
          bloc.add(const _TestEvent(payload: _Payload(data: 'test data 2')));
        },
        expect: () => [
          const BlocState.success(data: _TestViewData(data: 'test data 1')),
          const BlocState.success(data: _TestViewData(data: 'test data 2')),
        ],
        verify: (bloc) {
          expect(bloc.handleEventCalled, isTrue);
        },
      );
    });
  });

  group('Integration Tests', () {
    late _TestModuleBloc bloc;

    setUp(() {
      bloc = _TestModuleBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('processes multiple events in sequence', () async {
      const events = [
        _TestEvent(payload: _Payload(data: 'first')),
        _TestEvent(payload: _Payload(data: 'second')),
        _TestEvent(payload: _Payload(data: 'third')),
      ];

      for (final event in events) {
        bloc.add(event);
        await Future<void>.delayed(const Duration(milliseconds: 50));
      }

      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(
        bloc.state.mapOrElse(
          success: (data) => data.data == 'third',
          orElse: () => false,
        ),
        isTrue,
      );
    });

    test('handles concurrent event processing correctly', () async {
      // Add multiple events simultaneously
      await Future.wait([
        Future(() => bloc.add(const _TestEvent(payload: _Payload(data: '1')))),
        Future(() => bloc.add(const _TestEvent(payload: _Payload(data: '2')))),
        Future(() => bloc.add(const _TestEvent(payload: _Payload(data: '3')))),
      ]);

      await Future<void>.delayed(const Duration(milliseconds: 100));

      // The last event should be processed last due to event ordering in Bloc
      expect(
        bloc.state.mapOrElse(
          success: (data) => data.data == '3',
          orElse: () => false,
        ),
        isTrue,
      );
    });
  });

  group('Error Handling', () {
    late _TestModuleBloc bloc;

    setUp(() {
      bloc = _TestModuleBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('handles bloc closure correctly', () async {
      await bloc.close();
      expect(
        () => bloc.add(const _TestEvent(payload: _Payload(data: 'test data'))),
        throwsA(isA<StateError>()),
      );
    });

    test('maintains initial state when no events are processed', () {
      expect(bloc.state, const BlocState<_TestViewData>.initial());
    });
  });
}
