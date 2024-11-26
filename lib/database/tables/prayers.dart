import 'package:drift/drift.dart';

class Prayers extends Table {
  IntColumn get id => integer().named('_id').autoIncrement()();

  TextColumn get prayerName => text().named('PRAYERNAME')();

  TextColumn get prayerText => text().named('PRAYERTEXT')();

  TextColumn get groupName => text().named('GROUPNAME')();

  @override
  String get tableName => 'PRAYERS';
}

class Inspirations extends Table {
  IntColumn get id => integer().named('_id').autoIncrement()();

  TextColumn get author => text().named('AUTHOR')();

  TextColumn get quote => text().named('QUOTE')();

  @override
  String get tableName => 'INSPIRATION';
}
