import 'package:confession/database/app_database.dart';
import 'package:confession/database/tables/guides.t.dart';
import 'package:drift/drift.dart';

part 'guides_dao.g.dart';

@DriftAccessor(tables: [GuidesTable])
class GuidesDao extends DatabaseAccessor<AppDatabase> with _$GuidesDaoMixin {
  GuidesDao(super.db);

  Future<List<GuidesTableData>> getAllGuides() => select(guidesTable).get();

  Future<List<GuidesTableData>> getGuidesForId(int id) =>
      (select(guidesTable)..where((tbl) => tbl.headerId.equals(id))).get();
}
