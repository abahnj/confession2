import 'package:confession/database/app_database.dart';
import 'package:confession/database/tables/guides.t.dart';
import 'package:drift/drift.dart';

part 'guides_dao.g.dart';

@DriftAccessor(tables: [Guides])
class GuidesDao extends DatabaseAccessor<AppDatabase> with _$GuidesDaoMixin {
  GuidesDao(super.db);

  Future<List<Guide>> getAllGuides() => select(guides).get();

  Future<List<Guide>> getGuidesForId(int id) =>
      (select(guides)..where((tbl) => tbl.headerId.equals(id))).get();
}
