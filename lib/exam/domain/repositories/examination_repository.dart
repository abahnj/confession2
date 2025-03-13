import 'package:confession/database/app_database.dart';
import 'package:confession/domain/dtos/models/user_domain_model.dart';

abstract class ExaminationRepository {
  Future<void> resetAllExaminationsCount();

  Future<void> resetExaminationCount(int examinationId);

  Future<int> updateExamination(ExaminationsTableCompanion examination);

  Future<int> saveDefaultExaminationText(int examinationId);

  Future<int> resetExaminationText(int examinationId);

  Future<int> deleteExamination({
    required int examinationId,
    bool undo = false,
  });

  Future<int> incrementExaminationCount(int examinationId);

  Stream<List<ExaminationsTableData>> watchExaminationForUserAndCommandment({
    required UserDomainModel user,
    required int commandmentId,
  });

  Stream<List<ExaminationsTableData>> watchActiveExaminations();
}
