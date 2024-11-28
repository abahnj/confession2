import 'package:confession/database/app_database.dart';

abstract class PrayersRepository {
  Future<List<PrayersTableData>> getPrayers();

  Future<InspirationsTableData?> getRandomInspiration();
}
