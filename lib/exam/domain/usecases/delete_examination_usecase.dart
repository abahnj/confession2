import 'package:confession/core/base/view_data.dart';
import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/exam/domain/repositories/examination_repository.dart';
import 'package:confession/exam/presentation/bloc/update_examination_bloc.dart';

class DeleteExaminationUsecase extends AsyncViewDataParamUseCase<
    PrimitiveViewData<int>, DeleteExamination> {
  DeleteExaminationUsecase({required ExaminationRepository repository})
      : _repository = repository;

  final ExaminationRepository _repository;

  @override
  Future<PrimitiveViewData<int>> call(DeleteExamination param) async {
    final examinationId = param.examination.id;

    final updatedExamination = await _repository.deleteExamination(
      examinationId: examinationId,
      undo: param.undo,
    );
    return PrimitiveViewData(data: updatedExamination);
  }
}
