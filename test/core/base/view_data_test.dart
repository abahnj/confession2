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
    });
  });
}
