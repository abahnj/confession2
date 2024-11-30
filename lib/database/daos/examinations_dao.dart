import 'package:confession/database/app_database.dart';
import 'package:confession/database/tables/tables.dart';
import 'package:drift/drift.dart';

part 'examinations_dao.g.dart';

typedef ExaminationFilter = Expression<bool> Function(ExaminationsTable);

extension ExaminationQueryExtension on Expression<bool> {
  Expression<bool> and(Expression<bool> other) => this & other;
}

@DriftAccessor(tables: [ExaminationsTable])
class ExaminationsDao extends DatabaseAccessor<AppDatabase>
    with _$ExaminationsDaoMixin {
  ExaminationsDao(super.db);

  static const _activeExaminationThreshold = 0;

  // Base query
  SimpleSelectStatement<ExaminationsTable, ExaminationsTableData>
      _baseQuery() => select(examinationsTable);

  // Filter expressions
  ExaminationFilter getTeenFilter() => (table) => table.teen.equals(true);

  ExaminationFilter getAdultFilter() => (table) => table.adult.equals(true);

  ExaminationFilter getChildFilter() => (table) => table.child.equals(true);

  ExaminationFilter getMaleFilter() => (table) => table.male.equals(true);

  ExaminationFilter getFemaleFilter() => (table) => table.female.equals(true);

  ExaminationFilter getSingleFilter() => (table) => table.single.equals(true);

  ExaminationFilter getMarriedFilter() => (table) => table.married.equals(true);

  ExaminationFilter getPriestFilter() => (table) => table.priest.equals(true);

  ExaminationFilter getReligiousFilter() =>
      (table) => table.religious.equals(true);

  ExaminationFilter isNotDeleted() => (table) => table.isDeleted.isNull();

  ExaminationFilter getCommandmentFilter(int commandmentId) =>
      (table) => table.commandmentId.equals(commandmentId);

  // Filter combination
  ExaminationFilter _combineFilters(List<ExaminationFilter> filters) =>
      (table) => switch (filters.length) {
            0 => const Constant(true),
            1 => filters.first(table),
            _ => filters.fold(
                filters.first(table),
                (acc, filter) => acc.and(filter(table)),
              ),
          };

  // Query execution methods
  Future<List<ExaminationsTableData>> getExaminations(
    List<ExaminationFilter> filters,
  ) {
    return (_baseQuery()
          ..where(
              (table) => _combineFilters([isNotDeleted(), ...filters])(table),))
        .get();
  }

  Stream<List<ExaminationsTableData>> watchExaminations(
    List<ExaminationFilter> filters,
  ) {
    return (_baseQuery()
          ..where(
              (table) => _combineFilters([isNotDeleted(), ...filters])(table),))
        .watch();
  }

  Future<int> updateExamination(ExaminationsTableCompanion examination) {
    final id = examination.id.value;

    return (update(examinationsTable)..where((tbl) => tbl.id.equals(id)))
        .write(examination);
  }

  Future<int> deleteExamination(int examinationId) =>
      (update(examinationsTable)..where((tbl) => tbl.id.equals(examinationId)))
          .write(const ExaminationsTableCompanion(isDeleted: Value(true)));

  Future<int> undoDeleteExamination(int examinationId) =>
      (update(examinationsTable)..where((tbl) => tbl.id.equals(examinationId)))
          .write(const ExaminationsTableCompanion(isDeleted: Value(null)));

  Future<int> restoreDeletedExaminations() =>
      (update(examinationsTable)..where((tbl) => tbl.isDeleted.equals(true)))
          .write(const ExaminationsTableCompanion(isDeleted: Value(null)));

  Future<int> incrementExaminationCount(int examinationId) async {
    return (update(examinationsTable)
          ..where((tbl) => tbl.id.equals(examinationId)))
        .write(
      ExaminationsTableCompanion.custom(
          count: examinationsTable.count + const Constant(1),),
    );
  }

  Future<int> saveDefaultExaminationText(int examinationId) async =>
      (update(examinationsTable)
            ..where(
                (tbl) => tbl.id.equals(examinationId) & tbl.customId.isNull(),))
          .write(
        ExaminationsTableCompanion.custom(
          customId: examinationsTable.description,
        ),
      );

  Future<int> resetExaminationText(int examinationId) async =>
      transaction(() async {
        await (update(examinationsTable)
              ..where((tbl) => tbl.id.equals(examinationId)))
            .write(
          ExaminationsTableCompanion.custom(
              description: examinationsTable.customId,),
        );

        return (update(examinationsTable)
              ..where((tbl) => tbl.id.equals(examinationId)))
            .write(
          const ExaminationsTableCompanion(customId: Value(null)),
        );
      });

  Future<int> resetExaminationsCount() async => (update(examinationsTable)
        ..where(
          (tbl) => tbl.count.isBiggerThanValue(_activeExaminationThreshold),
        ))
      .write(const ExaminationsTableCompanion(count: Value(0)));

  Future<int> resetExaminationCount(int examinationId) async =>
      (update(examinationsTable)..where((tbl) => tbl.id.equals(examinationId)))
          .write(const ExaminationsTableCompanion(count: Value(0)));
}
