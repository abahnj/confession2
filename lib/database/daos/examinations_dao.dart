import 'package:confession/database/app_database.dart';
import 'package:confession/database/tables/tables.dart';
import 'package:drift/drift.dart';

part 'examinations_dao.g.dart';

typedef ExaminationFilter = Expression<bool> Function($ExaminationsTable);

extension ExaminationQueryExtension on Expression<bool> {
  Expression<bool> and(Expression<bool> other) => this & other;
}

@DriftAccessor(tables: [Examinations])
class ExaminationsDao extends DatabaseAccessor<AppDatabase>
    with _$ExaminationsDaoMixin {
  ExaminationsDao(super.db);

  static const _activeExaminationThreshold = 0;

  // Base query
  SimpleSelectStatement<$ExaminationsTable, Examination> _baseQuery() =>
      select(examinations);

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

  ExaminationFilter getCommandmentFilter(int commandmentId) =>
      (table) => table.commandmentId.equals(commandmentId);

  ExaminationFilter getActiveFilter() =>
      (table) => table.count.isBiggerThanValue(_activeExaminationThreshold);

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
  Future<List<Examination>> getExaminations(List<ExaminationFilter> filters) {
    return (_baseQuery()..where((table) => _combineFilters(filters)(table)))
        .get();
  }

  Stream<List<Examination>> watchExaminations(List<ExaminationFilter> filters) {
    return (_baseQuery()..where((table) => _combineFilters(filters)(table)))
        .watch();
  }

  Future<int> updateExamination(Examination examination) {
    return transaction(() async {
      return into(examinations).insertOnConflictUpdate(examination);
    });
  }

  Future<int> resetExaminationsCount() async =>
      (update(examinations)..where((tbl) => tbl.count.isBiggerThanValue(0)))
          .write(const ExaminationsCompanion(count: Value(0)));
}
