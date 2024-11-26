import 'package:confession/core/di/modules/module.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/data/datasources/local/user_local_datasource_impl.dart';
import 'package:confession/data/mappers/user_mapper.dart';
import 'package:confession/data/repositories/user_repository_impl.dart';
import 'package:confession/domain/datasources/user_local_datasource.dart';
import 'package:confession/domain/repositories/user_repository.dart';
import 'package:confession/domain/usecases/user_usecases.dart';
import 'package:confession/presentation/bloc/user/user_bloc.dart';

class UserModule extends Module {
  @override
  void init() {
    sl
      ..registerLazySingleton<UserLocalDataSource>(
        () => UserLocalDataSourceImpl(sl()),
      )
      ..registerLazySingleton<UserRepository>(
        () => UserRepositoryImpl(userLocalDataSource: sl()),
      ) //
      //Mappers
      ..registerLazySingleton(UserMapper.new)
      //Usecases
      ..registerFactory(
        () => GetUserUseCase(userRepository: sl(), userMapper: sl()),
      )
      ..registerFactory(
        () => SaveUserUseCase(userRepository: sl(), userMapper: sl()),
      )
      ..registerFactory(() => DeleteUserUseCase(userRepository: sl()))
      // Blocs
      ..registerLazySingleton(
        () => UserBloc(
          getUser: sl(),
          saveUser: sl(),
          deleteUser: sl(),
        ),
      );
  }
}
