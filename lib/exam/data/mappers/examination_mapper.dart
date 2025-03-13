import 'package:confession/core/base/mappers.dart';
import 'package:confession/database/app_database.dart';
import 'package:confession/exam/domain/entities/commandment.dart';
import 'package:confession/exam/domain/entities/examination.dart';
import 'package:drift/drift.dart';

class ExaminationMapper extends ViewDataTableMapper<Examination,
    ExaminationsTableData, ExaminationsTableCompanion> {
  @override
  Examination toViewData(ExaminationsTableData model) => Examination(
        id: model.id,
        examinationText: model.description,
        activeText: model.activeText,
        count: model.count,
        isCustom: model.customId != null,
      );

  @override
  ExaminationsTableCompanion toInsertable(Examination viewData) =>
      ExaminationsTableCompanion(
        id: Value(viewData.id),
        description: Value(viewData.examinationText),
        count: Value(viewData.count),
      );
}

class CommandmentsMapper extends ViewDataTableMapper<Commandment,
    CommandmentsTableData, CommandmentsTableCompanion> {
  @override
  Commandment toViewData(CommandmentsTableData model) => Commandment(
        id: model.id,
        commandment: model.commandment,
        commandmentText: model.commandmentText,
      );

  @override
  CommandmentsTableCompanion toInsertable(Commandment viewData) =>
      CommandmentsTableCompanion(
        id: Value(viewData.id),
        commandment: Value(viewData.commandmentText),
      );
}
