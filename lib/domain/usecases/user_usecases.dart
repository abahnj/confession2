import 'package:confession/data/mappers/user_mapper.dart';
import 'package:confession/domain/entities/user.dart';
import 'package:confession/domain/repositories/user_repository.dart';
import 'package:confession/domain/usecases/usecase.dart';

class GetUserUseCase implements AsyncViewDataUseCase<User> {
  const GetUserUseCase({
    required UserRepository userRepository,
    required UserMapper userMapper,
  })  : _repository = userRepository,
        _mapper = userMapper;

  final UserRepository _repository;
  final UserMapper _mapper;

  @override
  Future<User> call() async {
    final model = await _repository.getUser();

    return _mapper.toViewData(model);
  }
}

class SaveUserUseCase implements AsyncParamUseCase<SaveUserParam> {
  const SaveUserUseCase({
    required UserRepository userRepository,
    required UserMapper userMapper,
  })  : _repository = userRepository,
        _mapper = userMapper;

  final UserRepository _repository;
  final UserMapper _mapper;

  @override
  Future<void> call(SaveUserParam param) => _repository.saveUser(_mapper.toDomainModel(param.user));
}

class DeleteUserUseCase implements AsyncUseCase {
  const DeleteUserUseCase({required UserRepository userRepository}) : _repository = userRepository;
  final UserRepository _repository;

  @override
  Future<void> call() => _repository.deleteUser();
}

class SaveUserParam extends Param {
  const SaveUserParam({required this.user});

  final User user;

  @override
  List<Object?> get props => [user];
}
