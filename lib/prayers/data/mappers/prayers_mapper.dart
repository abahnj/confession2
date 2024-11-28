import 'package:confession/core/base/mappers.dart';
import 'package:confession/database/app_database.dart';
import 'package:confession/prayers/domain/entities/inspiration.dart';
import 'package:confession/prayers/domain/entities/prayer.dart';
import 'package:drift/drift.dart';

class PrayersMapper extends ViewDataTableMapper<Prayer, PrayersTableData, PrayersTableCompanion> {
  @override
  Prayer toViewData(PrayersTableData model) => Prayer(
        prayerName: model.prayerName,
        text: model.prayerText,
      );

  @override
  PrayersTableCompanion toInsertable(Prayer viewData) => PrayersTableCompanion(
        prayerName: Value(viewData.prayerName),
        prayerText: Value(viewData.text),
      );
}

class InspirationsMapper extends ViewDataTableMapper<Inspiration, InspirationsTableData, InspirationsTableCompanion> {
  @override
  Inspiration toViewData(InspirationsTableData model) => Inspiration(
        author: model.author,
        quote: model.quote,
      );

  @override
  InspirationsTableCompanion toInsertable(Inspiration viewData) => InspirationsTableCompanion(
        author: Value(viewData.author),
        quote: Value(viewData.quote),
      );
}
