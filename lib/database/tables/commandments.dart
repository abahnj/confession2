import 'package:drift/drift.dart';

class Commandments extends Table {
  IntColumn get id => integer().named('_id').autoIncrement()();

  IntColumn get number => integer().named('NUMBER')();

  TextColumn get commandmentText => text().named('TEXT')();

  TextColumn get category => text().named('CATEGORY')();

  TextColumn get commandment => text().named('COMMANDMENT')();

  IntColumn get customId => integer().named('CUSTOM_ID').nullable()();

  @override
  String get tableName => 'COMMANDMENTS';
}
