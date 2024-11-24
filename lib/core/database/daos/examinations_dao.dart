import 'package:confession/core/database/app_database.dart';
import 'package:confession/core/database/tables/tables.dart';
import 'package:confession/domain/dtos/models/user_domain_model.dart';
import 'package:confession/domain/enums/user_enums.dart';
import 'package:drift/drift.dart';

part 'examinations_dao.g.dart';

@DriftAccessor(tables: [Examinations])
class ExaminationsDao extends DatabaseAccessor<AppDatabase>
    with _$ExaminationsDaoMixin {
  ExaminationsDao(super.db);

  // Constants for query optimization
  static const _activeExaminationThreshold = 0;

  /// Fetches examinations for a specific commandment
  Future<List<Examination>> getExaminationsForId(int commandmentId) {
    return (select(examinations)
          ..where((t) => t.commandmentId.equals(commandmentId)))
        .get();
  }

  /// Streams examinations filtered by user profile
  Future<List<Examination>> getExaminationsForUserAndId(
    int commandmentId,
    UserDomainModel user,
  ) {
    final query = select(examinations)
      ..where((t) => t.commandmentId.equals(commandmentId));

    // For children, only apply age filter
    if (user.age == Age.child) {
      return _applyAgeFilter(query, user.age).get();
    }

    // For adults, apply all filters
    return _applyAllFilters(
      query,
      user.vocation,
      user.gender,
      user.age,
    ).get();
  }

  /// Updates examination count with optimistic concurrency
  Future<int> updateCountForExamination(Examination examination) {
    return transaction(() async {
      return into(examinations).insertOnConflictUpdate(examination);
    });
  }

  /// Streams active examinations (count > 0)
  Stream<List<Examination>> getActiveExaminations() {
    return (select(examinations)
          ..where(
            (tbl) => tbl.count.isBiggerThanValue(_activeExaminationThreshold),
          ))
        .watch();
  }

  // Private helper methods for query building
  SimpleSelectStatement<$ExaminationsTable, Examination> _applyVocationFilter(
    SimpleSelectStatement<$ExaminationsTable, Examination> query,
    Vocation vocation,
  ) {
    final vocationColumn = switch (vocation) {
      Vocation.single => examinations.single,
      Vocation.married => examinations.married,
      Vocation.priest => examinations.priest,
      Vocation.religious => examinations.religious,
    };

    return query..where((t) => vocationColumn.equals(true));
  }

  SimpleSelectStatement<$ExaminationsTable, Examination> _applyGenderFilter(
    SimpleSelectStatement<$ExaminationsTable, Examination> query,
    Gender gender,
  ) {
    final genderColumn = switch (gender) {
      Gender.male => examinations.male,
      Gender.female => examinations.female,
    };

    return query..where((t) => genderColumn.equals(true));
  }

  SimpleSelectStatement<$ExaminationsTable, Examination> _applyAgeFilter(
    SimpleSelectStatement<$ExaminationsTable, Examination> query,
    Age age,
  ) {
    final ageColumn = switch (age) {
      Age.adult => examinations.adult,
      Age.teen => examinations.teen,
      Age.child => examinations.child,
    };

    return query..where((t) => ageColumn.equals(true));
  }

  SimpleSelectStatement<$ExaminationsTable, Examination> _applyAllFilters(
    SimpleSelectStatement<$ExaminationsTable, Examination> query,
    Vocation vocation,
    Gender gender,
    Age age,
  ) {
    return _applyAgeFilter(
      _applyGenderFilter(
        _applyVocationFilter(query, vocation),
        gender,
      ),
      age,
    );
  }
}

// Extension for more readable query conditions
extension ExaminationQueryExtension on Expression<bool> {
  Expression<bool> and(Expression<bool> other) => this & other;
}
