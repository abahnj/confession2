import 'package:confession/core/base/mappers.dart';
import 'package:confession/domain/dtos/models/user_domain_model.dart';
import 'package:confession/domain/entities/user.dart';
import 'package:confession/domain/enums/user_enums.dart';

class UserMapper implements ViewDataMapper<User, UserDomainModel> {
  @override
  User toViewData(UserDomainModel model) {
    return User(
      vocation: Vocation.values.byName(model.vocation),
      age: Age.values.byName(model.age),
      gender: Gender.values.byName(model.gender),
      lastConfession: model.lastConfession,
    );
  }

  @override
  UserDomainModel toDomainModel(User viewData) {
    return UserDomainModel(
      vocation: viewData.vocation.name,
      age: viewData.age.name,
      gender: viewData.gender.name,
      lastConfession: viewData.lastConfession,
    );
  }
}
