import 'package:confession/data/mappers/user_mapper.dart';
import 'package:confession/domain/entities/user.dart';
import 'package:confession/domain/repositories/user_repository.dart';
import 'package:confession/domain/usecases/usecase.dart';

class GetUserUseCase implements UseCase<User, NoParams> {
  const GetUserUseCase({
    required UserRepository userRepository,
    required UserMapper userMapper,
  })  : _repository = userRepository,
        _mapper = userMapper;

  final UserRepository _repository;
  final UserMapper _mapper;

  @override
  Future<User> call(NoParams params) async {
    final model = await _repository.getUser();

    return _mapper.toViewData(model);
  }
}

class SaveUserUseCase implements UseCase<void, User> {
  const SaveUserUseCase({
    required UserRepository userRepository,
    required UserMapper userMapper,
  })  : _repository = userRepository,
        _mapper = userMapper;

  final UserRepository _repository;
  final UserMapper _mapper;

  @override
  Future<void> call(User params) =>
      _repository.saveUser(_mapper.toDomainModel(params));
}

class DeleteUserUseCase implements UseCase<void, NoParams> {
  const DeleteUserUseCase({required UserRepository userRepository})
      : _repository = userRepository;
  final UserRepository _repository;

  @override
  Future<void> call(NoParams params) => _repository.deleteUser();
}
