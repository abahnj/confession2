import 'dart:math';

import 'package:confession/database/app_database.dart';
import 'package:confession/database/tables/prayers.t.dart';
import 'package:drift/drift.dart';

part 'prayers_dao.g.dart';

@DriftAccessor(tables: [PrayersTable, InspirationsTable])
class PrayersDao extends DatabaseAccessor<AppDatabase> with _$PrayersDaoMixin {
  PrayersDao(super.db);

  Future<List<PrayersTableData>> getAllPrayers() => select(prayersTable).get();

  Future<PrayersTableData> getPrayerForId(int id) =>
      (select(prayersTable)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<InspirationsTableData> getInspirationForId(int id) =>
      (select(inspirationsTable)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<List<PrayersTableData>> searchPrayers(String query) {
    final searchTerm = '%${query.toLowerCase()}%';
    return (select(prayersTable)
          ..where(
            (tbl) =>
                tbl.prayerName.lower().like(searchTerm) |
                tbl.prayerText.lower().like(searchTerm) |
                tbl.groupName.lower().like(searchTerm),
          ))
        .get();
  }

  Future<int> _getInspirationCount() async {
    final countExp = inspirationsTable.id.count();

    return await (selectOnly(inspirationsTable)..addColumns([countExp])).map((row) => row.read(countExp)).getSingle() ??
        0;
  }

  Future<InspirationsTableData?> getRandomInspiration() async {
    // Get total count first
    final count = await _getInspirationCount();

    if (count == 0) {
      return null;
    }

    // Generate random offset
    final random = Random();
    final offset = random.nextInt(count);

    // Get random inspiration
    return (select(inspirationsTable)..limit(1, offset: offset)).getSingleOrNull();
  }
}
