import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/exam/data/mappers/examination_mapper.dart';
import 'package:confession/exam/domain/entities/examination.dart';
import 'package:confession/exam/domain/repositories/examination_repository.dart';

class GetActiveExaminationsUsecase
    extends StreamViewDataUseCase<ExaminationsList> {
  GetActiveExaminationsUsecase({
    required ExaminationRepository repository,
    required ExaminationMapper examinationsMapper,
  })  : _repository = repository,
        _mapper = examinationsMapper;

  final ExaminationRepository _repository;
  final ExaminationMapper _mapper;

  @override
  Stream<ExaminationsList> call() {
    return _repository.watchActiveExaminations().map(
          (examinations) => ExaminationsList(
            data: examinations.map(_mapper.toViewData).toList(),
          ),
        );
  }
}
