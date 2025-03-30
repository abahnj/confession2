import 'package:confession/core/errors/app_exception.dart';
import 'package:flutter/foundation.dart';

/// Utility class for throwing exceptions
class Throw {
  Throw._();

  /// Throw a network exception
  static Never network(String message, {Object? error, StackTrace? stackTrace, String? code}) {
    throw NetworkException(
      message: message,
      code: code,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Throw a database exception
  static Never database(String message, {Object? error, StackTrace? stackTrace, String? code}) {
    throw DatabaseException(
      message: message,
      code: code,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Throw an auth exception
  static Never auth(String message, {Object? error, StackTrace? stackTrace, String? code, bool requiresLogin = false}) {
    throw AuthException(
      message: message,
      code: code,
      error: error,
      stackTrace: stackTrace,
      requiresLogin: requiresLogin,
    );
  }

  /// Throw a storage exception
  static Never storage(String message, {Object? error, StackTrace? stackTrace, String? code}) {
    throw StorageException(
      message: message,
      code: code,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Throw a validation exception
  static Never validation(String message, {Object? error, StackTrace? stackTrace, String? code, String? field}) {
    throw ValidationException(
      message: message,
      code: code,
      error: error,
      stackTrace: stackTrace,
      field: field,
    );
  }

  /// Throw an unexpected exception
  static Never unexpected(String message, {Object? error, StackTrace? stackTrace, String? code}) {
    throw UnexpectedException(
      message: message,
      code: code,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Throw a feature-specific exception
  static Never feature(String message, String featureCode, {Object? error, StackTrace? stackTrace}) {
    throw FeatureException(
      message: message,
      featureCode: featureCode,
      error: error,
      stackTrace: stackTrace,
    );
  }
  
  /// Conditionally throw an exception if the condition is true
  static void whenTrue({
    required bool condition, 
    required String message, 
    required ExceptionType type,
    Object? error,
    StackTrace? stackTrace,
    String? code,
    String? featureCode,
  }) {
    if (!condition) return;
    
    switch (type) {
      case ExceptionType.network:
        network(message, error: error, stackTrace: stackTrace, code: code);
      case ExceptionType.database:
        database(message, error: error, stackTrace: stackTrace, code: code);
      case ExceptionType.auth:
        auth(message, error: error, stackTrace: stackTrace, code: code);
      case ExceptionType.storage:
        storage(message, error: error, stackTrace: stackTrace, code: code);
      case ExceptionType.validation:
        validation(message, error: error, stackTrace: stackTrace, code: code);
      case ExceptionType.unexpected:
        unexpected(message, error: error, stackTrace: stackTrace, code: code);
      case ExceptionType.feature:
        if (featureCode == null) {
          unexpected(message, error: error, stackTrace: stackTrace, code: code);
        } else {
          feature(message, featureCode, error: error, stackTrace: stackTrace);
        }
    }
  }
  
  /// In debug mode, throw an exception if the assertion fails
  static void debugAssert({
    required bool condition, 
    required String message, 
    ExceptionType type = ExceptionType.unexpected,
    Object? error,
    String? code,
    String? featureCode,
  }) {
    if (kDebugMode) {
      whenTrue(
        condition: !condition, 
        message: message, 
        type: type, 
        error: error, 
        stackTrace: StackTrace.current,
        code: code,
        featureCode: featureCode,
      );
    }
  }
}

/// Exception types for the Throw utility
enum ExceptionType {
  network,
  database,
  auth,
  storage,
  validation,
  unexpected,
  feature,
}
