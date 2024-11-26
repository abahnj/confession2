import 'package:confession/database/app_database.dart';
import 'package:confession/database/tables/commandments.dart';
import 'package:drift/drift.dart';

part 'commandments_dao.g.dart';

@DriftAccessor(tables: [Commandments])
class CommandmentsDao extends DatabaseAccessor<AppDatabase>
    with _$CommandmentsDaoMixin {
  CommandmentsDao(super.db);

  Future<List<Commandment>> getAllCommandments() => select(commandments).get();

  Future<int> insertCommandment(Insertable<Commandment> commandment) =>
      into(commandments).insert(commandment);

  Future<List<Commandment>> getCommandmentsForChildren() =>
      (select(commandments)..where((tbl) => tbl.id.isIn([11, 14]))).get();

  Future<List<Commandment>> getCommandmentsForReligious() =>
      (select(commandments)..where((tbl) => tbl.id.isBiggerThanValue(10)))
          .get();

  Future<List<Commandment>> getCommandmentsForAdults() =>
      (select(commandments)..where((tbl) => tbl.id.isSmallerThanValue(11)))
          .get();

  Future<Commandment> getCommandmentById(int id) =>
      (select(commandments)..where((tbl) => tbl.id.equals(id))).getSingle();
}
