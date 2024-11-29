import 'package:confession/database/app_database.dart';
import 'package:confession/database/tables/commandments.t.dart';
import 'package:drift/drift.dart';

part 'commandments_dao.g.dart';

@DriftAccessor(tables: [CommandmentsTable])
class CommandmentsDao extends DatabaseAccessor<AppDatabase>
    with _$CommandmentsDaoMixin {
  CommandmentsDao(super.db);

  Future<List<CommandmentsTableData>> getAllCommandments() =>
      select(commandmentsTable).get();

  Future<int> insertCommandment(
          Insertable<CommandmentsTableData> commandment,) =>
      into(commandmentsTable).insert(commandment);

  Future<List<CommandmentsTableData>> getCommandmentsForChildren() =>
      (select(commandmentsTable)..where((tbl) => tbl.id.isIn([11, 14]))).get();

  Future<List<CommandmentsTableData>> getCommandmentsForReligious() =>
      (select(commandmentsTable)..where((tbl) => tbl.id.isBiggerThanValue(10)))
          .get();

  Future<List<CommandmentsTableData>> getCommandmentsForAdults() =>
      (select(commandmentsTable)..where((tbl) => tbl.id.isSmallerThanValue(11)))
          .get();

  Future<CommandmentsTableData> getCommandmentById(int id) =>
      (select(commandmentsTable)..where((tbl) => tbl.id.equals(id)))
          .getSingle();
}
