import 'package:confession/database/app_database.dart';

abstract class PrayersRepository {
  Future<PrayersTableData> getPrayerById(int id);

  Future<List<PrayersTableData>> getPrayers();

  Future<InspirationsTableData?> getRandomInspiration();
}
