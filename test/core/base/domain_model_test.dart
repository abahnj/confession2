import 'package:confession/core/base/domain_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks.dart';

void main() {
  group('DomainModel Tests', () {
    test('static fromJson should throw UnsupportedError', () {
      expect(
        () => DomainModel.fromJson({}),
        throwsA(isA<UnsupportedError>()),
      );
    });

    group('MockDomainModel Implementation', () {
      const testData = {
        'id': 'test-id',
        'name': 'Test Name',
      };

      test('fromJson creates correct instance', () {
        final model = MockDomainModel.fromJson(testData);

        expect(model.id, equals('test-id'));
        expect(model.name, equals('Test Name'));
      });

      test('toJson creates correct map', () {
        const model = MockDomainModel(
          id: 'test-id',
          name: 'Test Name',
        );

        final json = model.toJson();

        expect(json, equals(testData));
      });

      test('copyWith creates new instance with updated values', () {
        const original = MockDomainModel(
          id: 'test-id',
          name: 'Test Name',
        );

        final copied = original.copyWith(name: 'New Name');

        expect(copied.id, equals(original.id));
        expect(copied.name, equals('New Name'));
        expect(identical(original, copied), isFalse);
      });

      test('copyWith keeps original values when parameters are null', () {
        const original = MockDomainModel(
          id: 'test-id',
          name: 'Test Name',
        );

        final copied = original.copyWith();

        expect(copied.id, equals(original.id));
        expect(copied.name, equals(original.name));
        expect(identical(original, copied), isFalse);
      });
    });
  });
}
