import 'dart:math';

import 'package:confession/database/app_database.dart';
import 'package:confession/database/tables/prayers.t.dart';
import 'package:drift/drift.dart';

part 'prayers_dao.g.dart';

@DriftAccessor(tables: [Prayers, Inspirations])
class PrayersDao extends DatabaseAccessor<AppDatabase> with _$PrayersDaoMixin {
  PrayersDao(super.db);

  Future<List<Prayer>> getAllPrayers() => select(prayers).get();

  Future<Prayer> getPrayerForId(int id) =>
      (select(prayers)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<Inspiration> getInspirationForId(int id) =>
      (select(inspirations)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<List<Prayer>> searchPrayers(String query) {
    final searchTerm = '%${query.toLowerCase()}%';
    return (select(prayers)
          ..where(
            (tbl) =>
                tbl.prayerName.lower().like(searchTerm) |
                tbl.prayerText.lower().like(searchTerm) |
                tbl.groupName.lower().like(searchTerm),
          ))
        .get();
  }

  Future<int> _getInspirationCount() async {
    final countExp = inspirations.id.count();

    return await (selectOnly(inspirations)..addColumns([countExp]))
            .map((row) => row.read(countExp))
            .getSingle() ??
        0;
  }

  Future<Inspiration?> getRandomInspiration() async {
    // Get total count first
    final count = await _getInspirationCount();

    if (count == 0) {
      return null;
    }

    // Generate random offset
    final random = Random();
    final offset = random.nextInt(count);

    // Get random inspiration
    return (select(inspirations)..limit(1, offset: offset)).getSingleOrNull();
  }
}
