import 'package:confession/domain/dtos/models/user_domain_model.dart';
import 'package:confession/domain/entities/user.dart';
import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/exam/data/mappers/examination_mapper.dart';
import 'package:confession/exam/domain/entities/examination.dart';
import 'package:confession/exam/domain/repositories/examination_repository.dart';

class GetExaminationsUsecase extends StreamViewDataParamUseCase<ExaminationsList, GetExaminationsParam> {
  GetExaminationsUsecase({required ExaminationRepository repository, required ExaminationMapper examinationsMapper})
      : _repository = repository,
        _mapper = examinationsMapper;

  final ExaminationRepository _repository;
  final ExaminationMapper _mapper;

  @override
  Stream<ExaminationsList> call(GetExaminationsParam param) {
    final user = param.user;
    return _repository
        .watchExaminationForUserAndCommandment(
          user: UserDomainModel(
            vocation: user.vocation,
            age: user.age,
            gender: user.gender,
            lastConfession: user.lastConfession,
          ),
          commandmentId: param.commandmentId,
        )
        .map((examinations) => ExaminationsList(data: examinations.map(_mapper.toViewData).toList()));
  }
}

class GetExaminationsParam extends Param {
  const GetExaminationsParam({required this.user, required this.commandmentId});

  final User user;
  final int commandmentId;

  @override
  List<Object?> get props => [user, commandmentId];
}
