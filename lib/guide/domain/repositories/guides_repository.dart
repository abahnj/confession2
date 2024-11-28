// ignore_for_file: one_member_abstracts

import 'package:confession/database/app_database.dart';

abstract class GuidesRepository {
  Future<List<GuidesTableData>> getGuidesForId(int id);
}
