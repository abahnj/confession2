// ignore_for_file: one_member_abstracts, unawaited_futures

import 'dart:async';
import 'dart:developer';

import 'package:confession/core/errors/app_exception.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

/// Singleton service for centralized error handling
class ErrorHandler {
  ErrorHandler._();
  static final ErrorHandler instance = ErrorHandler._();

  final _errorListeners = <ErrorListener>[];

  /// Add a listener to receive error notifications
  void addListener(ErrorListener listener) {
    _errorListeners.add(listener);
  }

  /// Remove a previously added listener
  void removeListener(ErrorListener listener) {
    _errorListeners.remove(listener);
  }

  /// Notify all listeners of an error
  void _notifyListeners(AppException exception) {
    for (final listener in _errorListeners) {
      listener.onError(exception);
    }
  }

  /// Initialize the error handler
  void initialize() {
    FlutterError.onError = _handleFlutterError;
    PlatformDispatcher.instance.onError = _handlePlatformError;
  }

  /// Handle Flutter framework errors
  void _handleFlutterError(FlutterErrorDetails details) {
    final exception = UnexpectedException(
      message: details.exceptionAsString(),
      error: details.exception,
      stackTrace: details.stack,
    );

    _reportError(exception, details.stack);
    log(exception.toString(), stackTrace: details.stack);
  }

  /// Handle platform errors
  bool _handlePlatformError(Object error, StackTrace stack) {
    final exception = error is AppException
        ? error
        : UnexpectedException(
            message: error.toString(),
            error: error,
            stackTrace: stack,
          );

    _reportError(exception, stack);
    log(exception.toString(), stackTrace: stack);
    return true;
  }

  /// Handle a caught exception
  Future<void> handleException(Object error, [StackTrace? stackTrace]) async {
    final capturedStackTrace = stackTrace ?? StackTrace.current;

    final exception = error is AppException
        ? error
        : UnexpectedException(
            message: error.toString(),
            error: error,
            stackTrace: capturedStackTrace,
          );

    if (exception.shouldReport) {
      _reportError(exception, capturedStackTrace);
    }

    log(exception.toString(), stackTrace: capturedStackTrace);

    if (exception.shouldDisplay) {
      _notifyListeners(exception);
    }
  }

  /// Report error to crash reporting services
  Future<void> _reportError(
    AppException exception,
    StackTrace? stackTrace,
  ) async {
    try {
      await FirebaseCrashlytics.instance.recordError(
        exception,
        stackTrace,
        reason: exception.message,
      );
    } catch (e) {
      // Prevent crash reporting recursion
      log('Failed to report error to Crashlytics: $e');
    }
  }

  /// Wrap a function with error handling
  Future<T> run<T>(Future<T> Function() function) async {
    try {
      return await function();
    } catch (e, stackTrace) {
      await handleException(e, stackTrace);
      rethrow;
    }
  }

  /// Wrap a synchronous function with error handling
  T runSync<T>(T Function() function) {
    try {
      return function();
    } catch (e, stackTrace) {
      handleException(e, stackTrace);
      rethrow;
    }
  }
}

/// Interface for objects that need to be notified of errors
abstract class ErrorListener {
  void onError(AppException exception);
}
