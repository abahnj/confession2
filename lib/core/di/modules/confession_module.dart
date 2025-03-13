import 'package:confession/confession/domain/usecases/get_confession_list_usecase.dart';
import 'package:confession/confession/domain/usecases/get_examination_of_conscience.dart';
import 'package:confession/confession/domain/usecases/get_random_inspiration_usecase.dart';
import 'package:confession/confession/domain/usecases/reset_active_examinations_usecase.dart';
import 'package:confession/core/di/modules/module.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/prayers/data/mappers/prayers_mapper.dart';

class ConfessionModule extends Module {
  @override
  void init() {
    sl
      ..registerFactory(InspirationsMapper.new)
      ..registerCachedFactory(
        () => GetActiveExaminationsUsecase(
          repository: sl(),
          examinationsMapper: sl(),
        ),
      )
      ..registerCachedFactory(
        () => GetExaminationOfConscienceUsecase(
          repository: sl(),
          prayersMapper: sl(),
        ),
      )
      ..registerCachedFactory(
        () => GetRandomInspirationUsecase(
          repository: sl(),
          inspirationsMapper: sl(),
        ),
      )
      ..registerCachedFactory(
        () => ResetActiveExaminationsUsecase(repository: sl()),
      );
  }
}
