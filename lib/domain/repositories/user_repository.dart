import 'package:confession/domain/dtos/models/user_domain_model.dart';

abstract class UserRepository {
  Future<void> saveUser(UserDomainModel user);

  Future<UserDomainModel> getUser();

  Future<void> deleteUser();
}
