import 'package:confession/domain/datasources/user_local_datasource.dart';
import 'package:confession/domain/dtos/models/user_domain_model.dart';
import 'package:confession/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl({required UserLocalDataSource userLocalDataSource})
      : _userLocalDataSource = userLocalDataSource;

  final UserLocalDataSource _userLocalDataSource;

  @override
  Future<void> deleteUser() async => _userLocalDataSource.delete();

  @override
  Future<UserDomainModel> getUser() async => _userLocalDataSource.read();

  @override
  Future<void> saveUser(UserDomainModel user) =>
      _userLocalDataSource.write(user);
}
