import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:confession/core/database/app_database.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/domain/dtos/models/user_domain_model.dart';
import 'package:confession/domain/enums/user_enums.dart';
import 'package:flutter/widgets.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  Bloc.observer = const AppBlocObserver();

  // Add cross-flavor configuration here

  WidgetsFlutterBinding.ensureInitialized();

  //Initialize dependencies
  ServiceLocator.init();

  final database = sl.get<AppDatabase>();

  final allItems = await database.examinationsDao.getExaminationsForUserAndId(
    4,
    UserDomainModel(
      vocation: Vocation.single,
      age: Age.adult,
      gender: Gender.male,
      lastConfession: DateTime.now().toIso8601String(),
    ),
  );

  log('items in database: $allItems');

  runApp(await builder());
}
