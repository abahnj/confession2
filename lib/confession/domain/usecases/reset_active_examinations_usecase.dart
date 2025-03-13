import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/exam/domain/repositories/examination_repository.dart';

class ResetActiveExaminationsUsecase extends UseCase {
  ResetActiveExaminationsUsecase({required ExaminationRepository repository})
      : _repository = repository;

  final ExaminationRepository _repository;

  @override
  Future<void> call() async => _repository.resetAllExaminationsCount();
}
