import 'package:confession/core/di/modules/module.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/theme/data/datasources/theme_local_datasource.dart';
import 'package:confession/theme/data/datasources/theme_local_datasource_impl.dart';
import 'package:confession/theme/data/mappers/theme_mapper.dart';
import 'package:confession/theme/data/repositories/theme_repository_impl.dart';
import 'package:confession/theme/domain/repositories/theme_repository.dart';
import 'package:confession/theme/domain/usecases.dart/get_theme_usecase.dart';
import 'package:confession/theme/domain/usecases.dart/switch_theme_usecase.dart';
import 'package:confession/theme/presentation/bloc/theme_cubit.dart';

class ThemeModule extends Module {
  @override
  void init() {
    // Theme related dependencies
    sl
      ..registerLazySingleton<ThemeRepository>(
        () => ThemeRepositoryImpl(localDataSource: sl()),
      )
      ..registerLazySingleton<ThemeLocalDataSource>(
        () => ThemeLocalDataSourceImpl(localStorage: sl()),
      )
      // Mappers
      ..registerLazySingleton<ThemeMapper>(ThemeMapper.new)
      // Usecases
      ..registerFactory<SwitchThemeUseCase>(
        () => SwitchThemeUseCase(themeRepository: sl(), themeMapper: sl()),
      )
      ..registerFactory<GetThemeUseCase>(
        () => GetThemeUseCase(themeRepository: sl(), themeMapper: sl()),
      )
      ..registerLazySingleton<ThemeCubit>(
        () => ThemeCubit(
          getThemeUseCase: sl(),
          toggleThemeUsecase: sl(),
        ),
      );
  }
}
