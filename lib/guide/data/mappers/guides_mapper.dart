import 'package:confession/core/base/mappers.dart';
import 'package:confession/database/app_database.dart';
import 'package:confession/guide/domain/entities/guide.dart';
import 'package:drift/drift.dart';

class GuidesMapper
    extends ViewDataTableMapper<Guide, GuidesTableData, GuidesTableCompanion> {
  @override
  Guide toViewData(GuidesTableData model) => Guide(
        title: model.guideTitle,
        text: model.guideText,
      );

  @override
  GuidesTableCompanion toInsertable(Guide viewData) => GuidesTableCompanion(
        guideTitle: Value(viewData.title),
        guideText: Value(viewData.text),
      );
}
