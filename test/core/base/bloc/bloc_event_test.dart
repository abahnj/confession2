import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/domain/usecases/usecase.dart';
import 'package:flutter_test/flutter_test.dart';

// Test implementations
class _TestParam extends Param {
  const _TestParam({required this.value});
  final String value;

  @override
  List<Object?> get props => [value];
}

class ComplexParam extends Param {
  const ComplexParam({
    required this.id,
    required this.count,
    required this.isValid,
  });
  final String id;
  final int count;
  final bool isValid;

  @override
  List<Object?> get props => [id, count, isValid];
}

void main() {
  group('BlocEvent Tests', () {
    group('Constructor Tests', () {
      test('creates event with param correctly', () {
        const param = _TestParam(value: 'test');
        const event = BlocEvent<_TestParam>(argument: param);

        expect(event.argument, equals(param));
        expect(event.props, [param]);
      });

      test('creates no-param event correctly', () {
        const event = BlocEvent<NoParams>.noParam();

        expect(event.argument, equals(noParam));
        expect(event.props, [noParam]);
      });

      test('maintains param immutability', () {
        const param = _TestParam(value: 'test');
        const event = BlocEvent<_TestParam>(argument: param);

        expect(event.argument, isA<_TestParam>());
        expect(const BlocEvent<_TestParam>(argument: param), equals(event));
      });
    });

    group('Equality Tests', () {
      test('events with same params are equal', () {
        const param = _TestParam(value: 'test');
        const event1 = BlocEvent<_TestParam>(argument: param);
        const event2 = BlocEvent<_TestParam>(argument: param);

        expect(event1, equals(event2));
        expect(event1.hashCode, equals(event2.hashCode));
      });

      test('events with different params are not equal', () {
        const param1 = _TestParam(value: 'test1');
        const param2 = _TestParam(value: 'test2');
        const event1 = BlocEvent<_TestParam>(argument: param1);
        const event2 = BlocEvent<_TestParam>(argument: param2);

        expect(event1, isNot(equals(event2)));
        expect(event1.hashCode, isNot(equals(event2.hashCode)));
      });

      test('no-param events are equal', () {
        const event1 = BlocEvent<NoParams>.noParam();
        const event2 = BlocEvent<NoParams>.noParam();

        expect(event1, equals(event2));
        expect(event1.hashCode, equals(event2.hashCode));
      });
    });

    group('Complex Param Tests', () {
      test('handles complex params correctly', () {
        const param = ComplexParam(
          id: 'test-id',
          count: 42,
          isValid: true,
        );
        const event = BlocEvent<ComplexParam>(argument: param);

        expect(event.argument.id, equals('test-id'));
        expect(event.argument.count, equals(42));
        expect(event.argument.isValid, isTrue);
      });

      test('maintains equality with complex params', () {
        const param1 = ComplexParam(
          id: 'test-id',
          count: 42,
          isValid: true,
        );
        const param2 = ComplexParam(
          id: 'test-id',
          count: 42,
          isValid: true,
        );
        const event1 = BlocEvent<ComplexParam>(argument: param1);
        const event2 = BlocEvent<ComplexParam>(argument: param2);

        expect(event1, equals(event2));
        expect(event1.hashCode, equals(event2.hashCode));
      });
    });

    group('Props Tests', () {
      test('props contains only the argument', () {
        const param = _TestParam(value: 'test');
        const event = BlocEvent<_TestParam>(argument: param);

        expect(event.props.length, equals(1));
        expect(event.props.first, equals(param));
      });

      test('props reflects param changes', () {
        const param1 = _TestParam(value: 'test1');
        const param2 = _TestParam(value: 'test2');
        const event1 = BlocEvent<_TestParam>(argument: param1);
        const event2 = BlocEvent<_TestParam>(argument: param2);

        expect(event1.props, isNot(equals(event2.props)));
      });
    });

    group('Type Safety Tests', () {
      test('maintains type safety with generic param', () {
        const param = _TestParam(value: 'test');
        const event = BlocEvent<_TestParam>(argument: param);

        expect(event.argument, isA<_TestParam>());
        expect(event, isA<BlocEvent<_TestParam>>());
      });

      test('maintains type safety with NoParam', () {
        const event = BlocEvent<NoParams>.noParam();

        expect(event.argument, isA<NoParams>());
        expect(event, isA<BlocEvent<NoParams>>());
      });
    });

    group('Edge Cases', () {
      test('handles empty string in param', () {
        const param = _TestParam(value: '');
        const event = BlocEvent<_TestParam>(argument: param);

        expect(event.argument.value, isEmpty);
      });

      test('equality works with same reference', () {
        const param = _TestParam(value: 'test');
        const event = BlocEvent<_TestParam>(argument: param);

        expect(event, equals(event));
        expect(event.hashCode, equals(event.hashCode));
      });

      test('differentiates between different param types', () {
        const param1 = _TestParam(value: 'test');
        const param2 = ComplexParam(
          id: 'test',
          count: 0,
          isValid: false,
        );
        const event1 = BlocEvent<_TestParam>(argument: param1);
        const event2 = BlocEvent<ComplexParam>(argument: param2);

        // Events with different param types should not be comparable
        expect(event1, isNot(equals(event2)));
      });
    });
  });
}
