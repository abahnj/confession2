import 'package:confession/domain/entities/user.dart';
import 'package:confession/domain/repositories/user_repository.dart';
import 'package:confession/domain/usecases/usecase.dart';

class GetUserUseCase implements UseCase<User, NoParams> {
  const GetUserUseCase({required UserRepository userRepository})
      : _repository = userRepository;

  final UserRepository _repository;

  @override
  Future<User> call(NoParams params) async {
    final model = await _repository.getUser();

    return model.toViewData();
  }
}

class SaveUserUseCase implements UseCase<void, User> {
  const SaveUserUseCase({required UserRepository userRepository})
      : _repository = userRepository;

  final UserRepository _repository;

  @override
  Future<void> call(User params) => _repository.saveUser(params.toDomain());
}

class DeleteUserUseCase implements UseCase<void, NoParams> {
  const DeleteUserUseCase({required UserRepository userRepository})
      : _repository = userRepository;
  final UserRepository _repository;

  @override
  Future<void> call(NoParams params) => _repository.deleteUser();
}
