import 'package:confession/database/app_database.dart';
import 'package:confession/domain/dtos/models/user_domain_model.dart';

abstract class ExaminationRepository {
  Future<void> resetAllExaminationsCount();

  Future<void> resetExaminationCount(int examinationId);

  Future<int> updateExamination(ExaminationsTableData examination);

  Stream<List<ExaminationsTableData>> watchExaminationForUserAndCommandment({
    required UserDomainModel user,
    required int commandmentId,
  });
}
