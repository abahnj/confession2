import 'package:confession/core/di/modules/module.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/database/daos/daos.dart';
import 'package:confession/exam/data/mappers/examination_mapper.dart';
import 'package:confession/exam/data/repositories/commandments_repository_impl.dart';
import 'package:confession/exam/data/repositories/examination_repository_impl.dart';
import 'package:confession/exam/domain/repositories/commandments_repository.dart';
import 'package:confession/exam/domain/repositories/examination_repository.dart';
import 'package:confession/exam/domain/usecases/delete_examination_usecase.dart';
import 'package:confession/exam/domain/usecases/edit_examination_usecase.dart';
import 'package:confession/exam/domain/usecases/get_commandments_usecase.dart';
import 'package:confession/exam/domain/usecases/get_examinations_usecase.dart';
import 'package:confession/exam/domain/usecases/reset_examination_usecase.dart';
import 'package:confession/exam/domain/usecases/update_count_examination_usecase.dart';

class ExaminationModule extends Module {
  @override
  void init() {
    sl
      ..registerLazySingleton<CommandmentsDao>(() => CommandmentsDao(sl()))
      ..registerLazySingleton<ExaminationsDao>(() => ExaminationsDao(sl()))
      ..registerCachedFactory<CommandmentsRepository>(
        () => CommandmentsRepositoryImpl(
          commandmentsDao: sl(),
        ),
      )
      ..registerCachedFactory<ExaminationRepository>(
        () => ExaminationRepositoryImpl(
          examinationsDao: sl(),
        ),
      )
      ..registerCachedFactory(CommandmentsMapper.new)
      ..registerCachedFactory(ExaminationMapper.new)
      ..registerCachedFactory(
        () =>
            GetCommandmentsUsecase(repository: sl(), commandmentsMapper: sl()),
      )
      ..registerCachedFactory(
        () =>
            GetExaminationsUsecase(repository: sl(), examinationsMapper: sl()),
      )
      ..registerCachedFactory(
        () => UpdateCountExaminationUsecase(
          repository: sl(),
          examinationsMapper: sl(),
        ),
      )
      ..registerCachedFactory(
        () =>
            EditExaminationUsecase(repository: sl(), examinationsMapper: sl()),
      )
      ..registerCachedFactory(
        () => ResetExaminationUsecase(repository: sl()),
      )
      ..registerCachedFactory(
        () => DeleteExaminationUsecase(repository: sl()),
      );
  }
}
