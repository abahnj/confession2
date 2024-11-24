import 'package:confession/core/di/modules/module.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/theme/data/datasources/theme_local_datasource.dart';
import 'package:confession/theme/data/datasources/theme_local_datasource_impl.dart';
import 'package:confession/theme/data/repositories/theme_repository_impl.dart';
import 'package:confession/theme/domain/repositories/theme_repository.dart';
import 'package:confession/theme/domain/usecases.dart/get_theme_usecase.dart';
import 'package:confession/theme/domain/usecases.dart/toggle_theme_usecase.dart';
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
      // Usecases
      ..registerFactory<ToggleThemeUsecase>(
        () => ToggleThemeUsecase(themeRepository: sl()),
      )
      ..registerFactory<GetThemeUseCase>(
        () => GetThemeUseCase(themeRepository: sl()),
      )
      ..registerLazySingleton<ThemeCubit>(
        () => ThemeCubit(
          getThemeUseCase: sl(),
          toggleThemeUsecase: sl(),
        ),
      );
  }
}
