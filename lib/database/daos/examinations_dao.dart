import 'package:confession/database/app_database.dart';
import 'package:confession/database/tables/tables.dart';
import 'package:drift/drift.dart';

part 'examinations_dao.g.dart';

typedef ExaminationFilter = Expression<bool> Function(ExaminationsTable);

extension ExaminationQueryExtension on Expression<bool> {
  Expression<bool> and(Expression<bool> other) => this & other;
}

@DriftAccessor(tables: [ExaminationsTable])
class ExaminationsDao extends DatabaseAccessor<AppDatabase> with _$ExaminationsDaoMixin {
  ExaminationsDao(super.db);

  static const _activeExaminationThreshold = 0;

  // Base query
  SimpleSelectStatement<ExaminationsTable, ExaminationsTableData> _baseQuery() => select(examinationsTable);

  // Filter expressions
  ExaminationFilter getTeenFilter() => (table) => table.teen.equals(true);

  ExaminationFilter getAdultFilter() => (table) => table.adult.equals(true);

  ExaminationFilter getChildFilter() => (table) => table.child.equals(true);

  ExaminationFilter getMaleFilter() => (table) => table.male.equals(true);

  ExaminationFilter getFemaleFilter() => (table) => table.female.equals(true);

  ExaminationFilter getSingleFilter() => (table) => table.single.equals(true);

  ExaminationFilter getMarriedFilter() => (table) => table.married.equals(true);

  ExaminationFilter getPriestFilter() => (table) => table.priest.equals(true);

  ExaminationFilter getReligiousFilter() => (table) => table.religious.equals(true);

  ExaminationFilter getCommandmentFilter(int commandmentId) => (table) => table.commandmentId.equals(commandmentId);

  ExaminationFilter getActiveFilter() => (table) => table.count.isBiggerThanValue(_activeExaminationThreshold);

  // Filter combination
  ExaminationFilter _combineFilters(List<ExaminationFilter> filters) => (table) => switch (filters.length) {
        0 => const Constant(true),
        1 => filters.first(table),
        _ => filters.fold(
            filters.first(table),
            (acc, filter) => acc.and(filter(table)),
          ),
      };

  // Query execution methods
  Future<List<ExaminationsTableData>> getExaminations(List<ExaminationFilter> filters) {
    return (_baseQuery()..where((table) => _combineFilters(filters)(table))).get();
  }

  Stream<List<ExaminationsTableData>> watchExaminations(List<ExaminationFilter> filters) {
    return (_baseQuery()..where((table) => _combineFilters(filters)(table))).watch();
  }

  Future<int> updateExamination(ExaminationsTableData examination) {
    return transaction(() async {
      return into(examinationsTable).insertOnConflictUpdate(examination);
    });
  }

  Future<int> resetExaminationsCount() async =>
      (update(examinationsTable)..where((tbl) => tbl.count.isBiggerThanValue(0)))
          .write(const ExaminationsTableCompanion(count: Value(0)));
}
