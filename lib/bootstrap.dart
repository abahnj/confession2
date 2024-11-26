import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/database/app_database.dart';
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
  final examinationsDao = database.examinationsDao;

  final allItems = await examinationsDao.getExaminations([
    examinationsDao.getCommandmentFilter(4),
    examinationsDao.getSingleFilter(),
    examinationsDao.getAdultFilter(),
    examinationsDao.getMaleFilter(),
  ]);

  log('items in database: $allItems');

  runApp(await builder());
}
