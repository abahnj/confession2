import 'package:confession/domain/dtos/models/user_domain_model.dart';
import 'package:confession/domain/entities/user.dart';
import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/exam/data/mappers/examination_mapper.dart';
import 'package:confession/exam/domain/entities/commandment.dart';
import 'package:confession/exam/domain/repositories/commandments_repository.dart';

class GetCommandmentsUsecase extends AsyncViewDataParamUseCase<CommandmentList, GetCommandmentsParam> {
  GetCommandmentsUsecase({required CommandmentsRepository repository, required CommandmentsMapper commandmentsMapper})
      : _repository = repository,
        _mapper = commandmentsMapper;

  final CommandmentsRepository _repository;
  final CommandmentsMapper _mapper;

  @override
  Future<CommandmentList> call(GetCommandmentsParam param) async {
    final user = param.user;
    final commandments = await _repository.getCommandmentsForUser(
      UserDomainModel(vocation: user.vocation, age: user.age, gender: user.gender, lastConfession: user.lastConfession),
    );

    return CommandmentList(data: commandments.map(_mapper.toViewData).toList());
  }
}

class GetCommandmentsParam extends Param {
  const GetCommandmentsParam({required this.user});

  final User user;

  @override
  List<Object?> get props => [user];
}
