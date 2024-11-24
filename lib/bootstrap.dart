import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:confession/core/database/app_database.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/domain/dtos/models/user_domain_model.dart';
import 'package:confession/domain/enums/user_enums.dart';
import 'package:confession/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
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

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (details) {
    FirebaseCrashlytics.instance.recordFlutterError(details);
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
    return true;
  };

  runApp(await builder());
}
