import 'package:confession/core/base/view_data.dart';
import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/exam/data/mappers/examination_mapper.dart';
import 'package:confession/exam/domain/entities/examination.dart';
import 'package:confession/exam/domain/repositories/examination_repository.dart';

class UpdateExaminationUsecase extends AsyncViewDataParamUseCase<
    PrimitiveViewData<int>, UpdateExaminationParam> {
  UpdateExaminationUsecase(
      {required ExaminationRepository repository,
      required ExaminationMapper examinationsMapper,})
      : _repository = repository,
        _mapper = examinationsMapper;

  final ExaminationRepository _repository;
  final ExaminationMapper _mapper;

  @override
  Future<PrimitiveViewData<int>> call(UpdateExaminationParam param) async {
    final examination = param.examination;
    final updatedExamination =
        await _repository.updateExamination(_mapper.toInsertable(examination));
    return PrimitiveViewData(data: updatedExamination);
  }
}

class UpdateExaminationParam extends Param {
  const UpdateExaminationParam({required this.examination});

  final Examination examination;

  @override
  List<Object?> get props => [examination];
}
