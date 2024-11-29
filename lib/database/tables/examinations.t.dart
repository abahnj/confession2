import 'package:drift/drift.dart';

class ExaminationsTable extends Table {
  IntColumn get id => integer().named('_id').autoIncrement()();

  IntColumn get commandmentId => integer().named('COMMANDMENT_ID')();

  BoolColumn get adult => boolean().named('ADULT')();

  BoolColumn get single => boolean().named('SINGLE')();

  BoolColumn get married => boolean().named('MARRIED')();

  BoolColumn get religious => boolean().named('RELIGIOUS')();

  BoolColumn get priest => boolean().named('PRIEST')();

  BoolColumn get teen => boolean().named('TEEN')();

  BoolColumn get female => boolean().named('FEMALE')();

  BoolColumn get male => boolean().named('MALE')();

  BoolColumn get child => boolean().named('CHILD')();

  IntColumn get customId => integer().named('CUSTOM_ID').nullable()();

  TextColumn get description => text().named('DESCRIPTION')();

  TextColumn get activeText => text().named('DESCRIPTION_ACTIVE')();

  IntColumn get count =>
      integer().named('COUNT').withDefault(const Constant(0))();

  @override
  String get tableName => 'SIN';
}
