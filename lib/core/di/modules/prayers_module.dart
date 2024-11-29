import 'package:confession/core/di/modules/module.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/database/daos/daos.dart';
import 'package:confession/prayers/data/mappers/prayers_mapper.dart';
import 'package:confession/prayers/data/repositories/prayers_repository_impl.dart';
import 'package:confession/prayers/domain/repositories/prayers_repository.dart';
import 'package:confession/prayers/domain/usecases/get_prayers_usecase.dart';

class PrayersModule extends Module {
  @override
  void init() {
    sl
      ..registerSingleton<PrayersDao>(PrayersDao(sl()))
      ..registerCachedFactory<PrayersRepository>(
        () => PrayersRepositoryImpl(
          prayersDao: sl(),
        ),
      )
      ..registerCachedFactory(PrayersMapper.new)
      ..registerCachedFactory(
          () => GetPrayersUsecase(repository: sl(), prayersMapper: sl()),);
  }
}
