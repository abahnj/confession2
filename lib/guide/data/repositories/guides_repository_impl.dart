import 'package:confession/database/app_database.dart';
import 'package:confession/database/daos/daos.dart';
import 'package:confession/guide/domain/repositories/guides_repository.dart';

class GuidesRepositoryImpl extends GuidesRepository {
  GuidesRepositoryImpl({
    required GuidesDao guidesDao,
  }) : _guidesDao = guidesDao;

  final GuidesDao _guidesDao;

  @override
  Future<List<GuidesTableData>> getGuidesForId(int id) =>
      _guidesDao.getGuidesForId(id);
}
