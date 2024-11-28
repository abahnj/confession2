import 'package:confession/core/di/modules/module.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/database/daos/daos.dart';
import 'package:confession/guide/data/mappers/guides_mapper.dart';
import 'package:confession/guide/data/repositories/guides_repository_impl.dart';
import 'package:confession/guide/domain/repositories/guides_repository.dart';
import 'package:confession/guide/usecases/get_guides_usecase.dart';

class GuidesModule extends Module {
  @override
  void init() {
    sl
      ..registerSingleton<GuidesDao>(GuidesDao(sl()))
      ..registerCachedFactory<GuidesRepository>(
        () => GuidesRepositoryImpl(
          guidesDao: sl(),
        ),
      )
      ..registerCachedFactory(GuidesMapper.new)
      ..registerCachedFactory(
        () => GetGuidesUsecase(repository: sl(), guidesMapper: sl()),
      );
  }
}
