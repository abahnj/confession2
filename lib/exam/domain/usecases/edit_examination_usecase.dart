import 'package:confession/core/base/view_data.dart';
import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/exam/data/mappers/examination_mapper.dart';
import 'package:confession/exam/domain/repositories/examination_repository.dart';
import 'package:confession/exam/presentation/bloc/update_examination_bloc.dart';

class EditExaminationUsecase
    extends AsyncViewDataParamUseCase<PrimitiveViewData<int>, EditExamination> {
  EditExaminationUsecase({
    required ExaminationRepository repository,
    required ExaminationMapper examinationsMapper,
  })  : _repository = repository,
        _mapper = examinationsMapper;

  final ExaminationRepository _repository;
  final ExaminationMapper _mapper;

  @override
  Future<PrimitiveViewData<int>> call(EditExamination param) async {
    final examination = param.examination;
    await _repository.saveDefaultExaminationText(examination.id);
    final updatedExamination =
        await _repository.updateExamination(_mapper.toInsertable(examination));
    return PrimitiveViewData(data: updatedExamination);
  }
}
