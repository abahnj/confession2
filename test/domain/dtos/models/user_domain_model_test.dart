import 'package:confession/domain/dtos/models/user_domain_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserDomainModel', () {
    test('fromJson creates a valid model', () {
      final json = {
        'vocation': 'Engineer',
        'age': '30',
        'gender': 'Male',
        'lastConfession': '2023-01-01',
      };
      final model = UserDomainModel.fromJson(json);
      expect(model.vocation, 'Engineer');
      expect(model.age, '30');
      expect(model.gender, 'Male');
      expect(model.lastConfession, '2023-01-01');
    });

    test('toJson returns a valid map', () {
      const model = UserDomainModel(
        vocation: 'Engineer',
        age: '30',
        gender: 'Male',
        lastConfession: '2023-01-01',
      );
      final json = model.toJson();
      expect(json['vocation'], 'Engineer');
      expect(json['age'], '30');
      expect(json['gender'], 'Male');
      expect(json['lastConfession'], '2023-01-01');
    });

    test('copyWith returns a new model with updated values', () {
      const model = UserDomainModel(
        vocation: 'Engineer',
        age: '30',
        gender: 'Male',
        lastConfession: '2023-01-01',
      );
      final updatedModel = model.copyWith(
        vocation: 'Doctor',
      );
      expect(updatedModel.vocation, 'Doctor');
      expect(updatedModel.age, '30');
      expect(updatedModel.gender, 'Male');
      expect(updatedModel.lastConfession, '2023-01-01');
    });

    test('copy with without any param returns the same object', () {
      const model = UserDomainModel(
        vocation: 'Engineer',
        age: '30',
        gender: 'Male',
        lastConfession: '2023-01-01',
      );
      final updatedModel = model.copyWith();

      expect(updatedModel, model);
    });

    test('props returns a list of properties', () {
      const model = UserDomainModel(
        vocation: 'Engineer',
        age: '30',
        gender: 'Male',
        lastConfession: '2023-01-01',
      );
      expect(model.props, ['Engineer', '30', 'Male', '2023-01-01']);
    });

    test('equality operator returns true for identical models', () {
      const model1 = UserDomainModel(
        vocation: 'Engineer',
        age: '30',
        gender: 'Male',
        lastConfession: '2023-01-01',
      );
      const model2 = UserDomainModel(
        vocation: 'Engineer',
        age: '30',
        gender: 'Male',
        lastConfession: '2023-01-01',
      );
      expect(model1, model2);
    });

    test('equality operator returns false for different models', () {
      const model1 = UserDomainModel(
        vocation: 'Engineer',
        age: '30',
        gender: 'Male',
        lastConfession: '2023-01-01',
      );
      const model2 = UserDomainModel(
        vocation: 'Doctor',
        age: '35',
        gender: 'Female',
        lastConfession: '2023-02-01',
      );
      expect(model1, isNot(model2));
    });
  });
}
