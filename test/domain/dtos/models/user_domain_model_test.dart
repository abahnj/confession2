import 'package:confession/domain/dtos/models/user_domain_model.dart';
import 'package:confession/domain/enums/user_enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserDomainModel', () {
    test('fromJson creates a valid model', () {
      final json = {
        'vocation': 'religious',
        'age': 'adult',
        'gender': 'male',
        'lastConfession': '2023-01-01',
      };
      final model = UserDomainModel.fromJson(json);
      expect(model.vocation, Vocation.religious);
      expect(model.age, Age.adult);
      expect(model.gender, Gender.male);
      expect(model.lastConfession, '2023-01-01');
    });

    test('toJson returns a valid map', () {
      const model = UserDomainModel(
        vocation: Vocation.married,
        age: Age.adult,
        gender: Gender.male,
        lastConfession: '2023-01-01',
      );
      final json = model.toJson();
      expect(json['vocation'], 'married');
      expect(json['age'], 'adult');
      expect(json['gender'], 'male');
      expect(json['lastConfession'], '2023-01-01');
    });

    test('copyWith returns a new model with updated values', () {
      const model = UserDomainModel(
        vocation: Vocation.priest,
        age: Age.adult,
        gender: Gender.male,
        lastConfession: '2023-01-01',
      );
      final updatedModel = model.copyWith(
        vocation: Vocation.religious,
      );
      expect(updatedModel.vocation, Vocation.religious);
      expect(updatedModel.age, Age.adult);
      expect(updatedModel.gender, Gender.male);
      expect(updatedModel.lastConfession, '2023-01-01');
    });

    test('copy with without any param returns the same object', () {
      const model = UserDomainModel(
        vocation: Vocation.religious,
        age: Age.teen,
        gender: Gender.male,
        lastConfession: '2023-01-01',
      );
      final updatedModel = model.copyWith();

      expect(updatedModel, model);
    });

    test('props returns a list of properties', () {
      const model = UserDomainModel(
        vocation: Vocation.priest,
        age: Age.adult,
        gender: Gender.male,
        lastConfession: '2023-01-01',
      );
      expect(model.props, [Vocation.priest, Age.adult, Gender.male, '2023-01-01']);
    });

    test('equality operator returns true for identical models', () {
      const model1 = UserDomainModel(
        age: Age.adult,
        vocation: Vocation.married,
        gender: Gender.male,
        lastConfession: '2023-01-01',
      );
      const model2 = UserDomainModel(
        vocation: Vocation.married,
        age: Age.adult,
        gender: Gender.male,
        lastConfession: '2023-01-01',
      );
      expect(model1, model2);
    });

    test('equality operator returns false for different models', () {
      const model1 = UserDomainModel(
        vocation: Vocation.priest,
        age: Age.adult,
        gender: Gender.female,
        lastConfession: '2023-01-01',
      );
      const model2 = UserDomainModel(
        vocation: Vocation.religious,
        age: Age.teen,
        gender: Gender.female,
        lastConfession: '2023-01-01',
      );
      expect(model1, isNot(model2));
    });
  });
}
