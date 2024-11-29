import 'package:confession/database/app_database.dart';
import 'package:confession/database/daos/commandments_dao.dart';
import 'package:confession/domain/dtos/models/user_domain_model.dart';
import 'package:confession/domain/enums/user_enums.dart';
import 'package:confession/exam/domain/repositories/commandments_repository.dart';

class CommandmentsRepositoryImpl extends CommandmentsRepository {
  CommandmentsRepositoryImpl({
    required CommandmentsDao commandmentsDao,
  }) : _commandmentsDao = commandmentsDao;

  final CommandmentsDao _commandmentsDao;
  @override
  Future<CommandmentsTableData> getCommandmentById(int id) => _commandmentsDao.getCommandmentById(id);

  @override
  Future<List<CommandmentsTableData>> getCommandmentsForUser(UserDomainModel user) {
    if (user.vocation == Vocation.religious) {
      return _commandmentsDao.getCommandmentsForReligious();
    } else if (user.age == Age.child) {
      return _commandmentsDao.getCommandmentsForChildren();
    } else {
      return _commandmentsDao.getCommandmentsForAdults();
    }
  }

  @override
  Future<int> insertCommandment(CommandmentsTableCompanion commandment) =>
      _commandmentsDao.insertCommandment(commandment);
}
