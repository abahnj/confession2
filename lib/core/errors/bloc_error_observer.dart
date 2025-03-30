import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:confession/core/errors/app_exception.dart';
import 'package:confession/core/errors/error_handler.dart';

/// BlocObserver that integrates with ErrorHandler
class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    
    // Handle the error through our centralized system
    ErrorHandler.instance.handleException(
      error is AppException ? error : _wrapError(error, bloc),
      stackTrace,
    );
  }

  /// Create a feature-specific exception from a generic error
  AppException _wrapError(Object error, BlocBase<dynamic> bloc) {
    final blocName = bloc.runtimeType.toString();
    
    // Detect specific error types and convert appropriately
    if (error is TimeoutException) {
      return NetworkException.timeout('$blocName operation timed out: ${error.message}');
    }
    
    // Map to feature-specific exception using the bloc name
    return FeatureException(
      message: 'Error in $blocName: $error',
      featureCode: _getFeatureCode(blocName),
      error: error,
    );
  }

  /// Extract a feature code from the bloc name
  String _getFeatureCode(String blocName) {
    // Convert 'FeatureNameBloc' to 'FEATURE_NAME'
    final cleanName = blocName
        .replaceAll('Bloc', '')
        .replaceAll('Cubit', '');
        
    // Convert camelCase to SNAKE_CASE
    final snakeCase = cleanName
        .replaceAllMapped(
          RegExp('([A-Z])'),
          (match) => '_${match.group(1)}',
        )
        .toUpperCase()
        .replaceAll(RegExp('^_'), '');
        
    return snakeCase;
  }
}
