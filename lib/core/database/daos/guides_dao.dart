import 'package:confession/core/database/app_database.dart';
import 'package:confession/core/database/tables/guides.dart';
import 'package:drift/drift.dart';

part 'guides_dao.g.dart';

@DriftAccessor(tables: [Guides])
class GuidesDao extends DatabaseAccessor<AppDatabase> with _$GuidesDaoMixin {
  GuidesDao(super.db);

//   Future<List<Guide>> getAllGuides() => select(guides).get();

//   Future<List<Guide>> getGuidesForId(int id) =>
//       (select(guides)..where((tbl) => tbl.headerId.equals(id))).get();
}
