import 'package:flutter_test/flutter_test.dart';

import 'mocks.dart';

void main() {
  group('ViewData Tests', () {
    group('MockViewData Implementation', () {
      const viewData = MockViewData(
        id: 'test-id',
        name: 'Test Name',
      );

      test('props contains all properties', () {
        expect(
          viewData.props,
          equals([viewData.id, viewData.name]),
        );
      });

      test('equals works correctly with identical properties', () {
        const viewData2 = MockViewData(
          id: 'test-id',
          name: 'Test Name',
        );

        expect(viewData, equals(viewData2));
      });

      test('equals returns false with different properties', () {
        const viewData2 = MockViewData(
          id: 'test-id',
          name: 'Different Name',
        );

        expect(viewData, isNot(equals(viewData2)));
      });

      test('toDomain creates correct DomainModel instance', () {
        final domain = viewData.toDomain();

        expect(domain, isA<MockDomainModel>());
        expect(domain.id, equals(viewData.id));
        expect(domain.name, equals(viewData.name));
      });
    });

    test('ViewData to DomainModel to ViewData maintains data integrity', () {
      const originalViewData = MockViewData(
        id: 'test-id',
        name: 'Test Name',
      );

      final domain = originalViewData.toDomain();
      final reconvertedViewData = domain.toViewData();

      expect(reconvertedViewData, equals(originalViewData));
    });

    test('DomainModel to ViewData to DomainModel maintains data consistency',
        () {
      const originalDomain = MockDomainModel(
        id: 'test-id',
        name: 'Test Name',
      );

      final viewData = originalDomain.toViewData();
      final reconvertedDomain = viewData.toDomain();

      expect(reconvertedDomain.id, equals(originalDomain.id));
      expect(reconvertedDomain.name, equals(originalDomain.name));
    });
  });
}
