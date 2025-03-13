import 'package:confession/database/app_database.dart';
import 'package:confession/database/daos/examinations_dao.dart';
import 'package:confession/domain/dtos/models/user_domain_model.dart';
import 'package:confession/domain/enums/user_enums.dart';
import 'package:confession/exam/domain/repositories/examination_repository.dart';

class ExaminationRepositoryImpl extends ExaminationRepository {
  ExaminationRepositoryImpl({
    required ExaminationsDao examinationsDao,
  }) : _examinationsDao = examinationsDao;

  final ExaminationsDao _examinationsDao;

  ExaminationFilter _getAgeFilter(UserDomainModel user) => switch (user.age) {
        Age.adult => _examinationsDao.getAdultFilter(),
        Age.teen => _examinationsDao.getTeenFilter(),
        Age.child => _examinationsDao.getChildFilter(),
      };

  ExaminationFilter _getCommandmentFilter(int commandmentId) =>
      _examinationsDao.getCommandmentFilter(commandmentId);

  ExaminationFilter _getVocationFilter(UserDomainModel user) =>
      switch (user.vocation) {
        Vocation.priest => _examinationsDao.getPriestFilter(),
        Vocation.religious => _examinationsDao.getReligiousFilter(),
        Vocation.married => _examinationsDao.getMarriedFilter(),
        Vocation.single => _examinationsDao.getSingleFilter(),
      };

  @override
  Future<void> resetAllExaminationsCount() =>
      _examinationsDao.resetExaminationsCount();

  @override
  Future<void> resetExaminationCount(int examinationId) =>
      _examinationsDao.resetExaminationCount(examinationId);

  @override
  Future<int> updateExamination(ExaminationsTableCompanion examination) =>
      _examinationsDao.updateExamination(examination);

  @override
  Stream<List<ExaminationsTableData>> watchExaminationForUserAndCommandment({
    required UserDomainModel user,
    required int commandmentId,
  }) {
    final filters = <ExaminationFilter>[
      _getAgeFilter(user),
      _getVocationFilter(user),
      _getCommandmentFilter(commandmentId),
    ];

    return _examinationsDao.watchExaminations(filters);
  }

  @override
  Future<int> deleteExamination({
    required int examinationId,
    bool undo = false,
  }) =>
      undo
          ? _examinationsDao.undoDeleteExamination(examinationId)
          : _examinationsDao.deleteExamination(examinationId);

  @override
  Future<int> incrementExaminationCount(int examinationId) =>
      _examinationsDao.incrementExaminationCount(examinationId);

  @override
  Future<int> saveDefaultExaminationText(int examinationId) =>
      _examinationsDao.saveDefaultExaminationText(examinationId);

  @override
  Future<int> resetExaminationText(int examinationId) =>
      _examinationsDao.resetExaminationText(examinationId);

  @override
  Stream<List<ExaminationsTableData>> watchActiveExaminations() =>
      _examinationsDao.watchActiveExaminations();
}
