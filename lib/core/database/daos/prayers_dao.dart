import 'package:confession/core/database/app_database.dart';
import 'package:confession/core/database/tables/prayers.dart';
import 'package:drift/drift.dart';

part 'prayers_dao.g.dart';

@DriftAccessor(tables: [Prayers, Inspirations])
class PrayersDao extends DatabaseAccessor<AppDatabase> with _$PrayersDaoMixin {
  PrayersDao(super.db);

  // Future<List<Prayer>> getAllPrayers() => select(prayers).get();

  // Future<Prayer> getPrayerForId(int id) =>
  //     (select(prayers)..where((tbl) => tbl.id.equals(id))).getSingle();

  // Future<Inspirations> getInspirationForId(int id) =>
  //     (select(inspirations)..where((tbl) => tbl.id.equals(id))).getSingle();

  // Future<void> resetExaminationsCount() async {
  //   final table = db.examinations;
  //   await (update(table)..where((tbl) => tbl.count.isBiggerThanValue(0)))
  //       .write(const ExaminationsCompanion(count: Value(0)));
  // }
}
