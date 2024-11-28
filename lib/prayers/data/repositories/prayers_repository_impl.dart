import 'package:confession/database/app_database.dart';
import 'package:confession/database/daos/prayers_dao.dart';
import 'package:confession/prayers/domain/repositories/prayers_repository.dart';

class PrayersRepositoryImpl extends PrayersRepository {
  PrayersRepositoryImpl({
    required PrayersDao prayersDao,
  }) : _prayersDao = prayersDao;

  final PrayersDao _prayersDao;
  @override
  Future<InspirationsTableData?> getRandomInspiration() async => _prayersDao.getRandomInspiration();

  @override
  Future<List<PrayersTableData>> getPrayers() async => _prayersDao.getAllPrayers();
}
