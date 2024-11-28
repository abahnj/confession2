import 'package:drift/drift.dart';

class GuidesTable extends Table {
  IntColumn get id => integer().named('_id').autoIncrement()();

  TextColumn get guideTitle => text().named('g_title')();

  TextColumn get guideText => text().named('text')();

  IntColumn get headerId => integer().named('h_id')();

  @override
  String get tableName => 'guide_main';
}
