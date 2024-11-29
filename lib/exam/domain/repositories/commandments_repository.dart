import 'package:confession/database/app_database.dart';
import 'package:confession/domain/dtos/models/user_domain_model.dart';

abstract class CommandmentsRepository {
  Future<CommandmentsTableData> getCommandmentById(int id);
  Future<List<CommandmentsTableData>> getCommandmentsForUser(
    UserDomainModel user,
  );

  Future<int> insertCommandment(CommandmentsTableCompanion commandment);
}
