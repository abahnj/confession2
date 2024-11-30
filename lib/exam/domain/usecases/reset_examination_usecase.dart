import 'package:confession/core/base/view_data.dart';
import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/exam/domain/repositories/examination_repository.dart';
import 'package:confession/exam/presentation/bloc/update_examination_bloc.dart';

class ResetExaminationUsecase
    extends AsyncViewDataParamUseCase<PrimitiveViewData<int>, ResetText> {
  ResetExaminationUsecase({
    required ExaminationRepository repository,
  }) : _repository = repository;

  final ExaminationRepository _repository;

  @override
  Future<PrimitiveViewData<int>> call(ResetText param) async {
    final examination = param.examination;
    final updatedExamination =
        await _repository.resetExaminationText(examination.id);
    return PrimitiveViewData(data: updatedExamination);
  }
}
