import 'package:confession/core/base/mappers.dart';
import 'package:confession/domain/dtos/models/user_domain_model.dart';
import 'package:confession/domain/entities/user.dart';

class UserMapper implements ViewDataMapper<User, UserDomainModel> {
  @override
  User toViewData(UserDomainModel model) {
    return User(
      vocation: model.vocation,
      age: model.age,
      gender: model.gender,
      lastConfession: model.lastConfession,
    );
  }

  @override
  UserDomainModel toDomainModel(User viewData) {
    return UserDomainModel(
      vocation: viewData.vocation,
      age: viewData.age,
      gender: viewData.gender,
      lastConfession: viewData.lastConfession,
    );
  }
}
