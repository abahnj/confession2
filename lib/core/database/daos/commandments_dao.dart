import 'package:confession/core/database/app_database.dart';
import 'package:confession/core/database/tables/commandments.dart';
import 'package:drift/drift.dart';

part 'commandments_dao.g.dart';

@DriftAccessor(tables: [Commandments])
class CommandmentsDao extends DatabaseAccessor<AppDatabase> with _$CommandmentsDaoMixin {
  CommandmentsDao(super.db);

  Future<List<Commandment>> getAllCommandments() => select(commandments).get();

  Future<int> insertCommandment(Insertable<Commandment> commandment) => into(commandments).insert(commandment);

  // Future<List<Commandment>> getCommandmentsForUser(User user) {
  //   if (user.age == Age.child) {
  //     return (select(commandments)..where((tbl) => tbl.id.isIn([11, 14])))
  //         .get();
  //   } else if (user.vocation == Vocation.priest ||
  //       user.vocation == Vocation.religious) {
  //     return (select(commandments)
  //           ..where((tbl) => tbl.id.isBiggerThanValue(10)))
  //         .get();
  //   } else {
  //     return (select(commandments)
  //           ..where((tbl) => tbl.id.isSmallerOrEqualValue(10)))
  //         .get();
  //   }
  // }
}
