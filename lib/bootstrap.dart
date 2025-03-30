import 'dart:async';
import 'dart:developer';

import 'package:confession/core/di/service_locator.dart';
import 'package:confession/core/errors/app_exception.dart';
import 'package:confession/core/errors/error_handler.dart';
import 'package:confession/database/app_database.dart';
import 'package:confession/error_reporting.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  // Setup error handling as early as possible
  configureErrorReporting();

  // Add cross-flavor configuration here
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    Intl.systemLocale = await findSystemLocale();
  } catch (e, st) {
    await ErrorHandler.instance.handleException(
      UnexpectedException(
        message: 'Error setting system locale', 
        error: e,
        stackTrace: st,
      ), 
      st,
    );
  }

  // Initialize dependencies
  ServiceLocator.init();

  try {
    final database = sl.get<AppDatabase>();
    final prayersDao = database.prayersDao;
    final inspirationCount = await prayersDao.getRandomInspiration();
    log('inspiration count: $inspirationCount');
  } catch (e, st) {
    final exception = e is AppException
        ? e
        : DatabaseException(
            message: 'Database initialization error',
            error: e,
            stackTrace: st,
          );
    await ErrorHandler.instance.handleException(exception, st);
  }

  runApp(await builder());
}
