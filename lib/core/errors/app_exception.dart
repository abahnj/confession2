/// Base exception class for all application exceptions
abstract class AppException implements Exception {
  const AppException({
    required this.message,
    this.code,
    this.error,
    this.stackTrace,
  });

  final String message;
  final String? code;
  final dynamic error;
  final StackTrace? stackTrace;

  /// Returns true if this exception should be reported to analytics/crash reporting
  bool get shouldReport => true;

  /// Returns true if this exception should be displayed to the user
  bool get shouldDisplay => true;

  /// User-friendly message that can be displayed in the UI
  String get userMessage => message;

  @override
  String toString() {
    final buffer = StringBuffer(runtimeType.toString());
    if (code != null) {
      buffer.write('($code)');
    }
    buffer.write(': $message');
    if (error != null) {
      buffer.write('\nCaused by: $error');
    }
    return buffer.toString();
  }
}

/// Exception for network-related errors
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
    this.isConnectionError = false,
  });

  /// Factory constructor for connection errors
  factory NetworkException.connection([String? message]) {
    return NetworkException(
      message: message ?? 'No internet connection',
      isConnectionError: true,
    );
  }

  /// Factory constructor for timeout errors
  factory NetworkException.timeout([String? message]) {
    return NetworkException(
      message: message ?? 'Request timed out',
      code: 'TIMEOUT',
    );
  }

  /// Factory constructor for server errors
  factory NetworkException.server(int statusCode, [String? message]) {
    return NetworkException(
      message: message ?? 'Server error $statusCode',
      code: 'SERVER_$statusCode',
    );
  }

  final bool isConnectionError;

  @override
  String get userMessage => isConnectionError
      ? 'Unable to connect to the network. Please check your connection and try again.'
      : 'A network error occurred. Please try again later.';
}

/// Exception for authentication-related errors
class AuthException extends AppException {
  const AuthException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
    this.requiresLogin = false,
  });

  /// Factory constructor for unauthorized errors
  factory AuthException.unauthorized([String? message]) {
    return AuthException(
      message: message ?? 'Unauthorized access',
      code: 'UNAUTHORIZED',
      requiresLogin: true,
    );
  }

  /// Factory constructor for session expired errors
  factory AuthException.sessionExpired([String? message]) {
    return AuthException(
      message: message ?? 'Your session has expired. Please sign in again.',
      code: 'SESSION_EXPIRED',
      requiresLogin: true,
    );
  }

  final bool requiresLogin;

  @override
  String get userMessage => requiresLogin
      ? 'Please sign in to continue.'
      : 'Authentication error. Please try again.';
}

/// Exception for database-related errors
class DatabaseException extends AppException {
  const DatabaseException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });

  /// Factory constructor for database connection errors
  factory DatabaseException.connection([String? message]) {
    return DatabaseException(
      message: message ?? 'Unable to connect to database',
      code: 'DB_CONNECTION',
    );
  }

  /// Factory constructor for database query errors
  factory DatabaseException.query(String query, [dynamic error]) {
    return DatabaseException(
      message: 'Database query error: $query',
      code: 'DB_QUERY',
      error: error,
    );
  }

  /// Factory constructor for database corruption errors
  factory DatabaseException.corruption([String? message]) {
    return DatabaseException(
      message: message ?? 'Database corruption detected',
      code: 'DB_CORRUPTION',
    );
  }

  @override
  String get userMessage =>
      'A database error occurred. Please restart the app.';
}

/// Exception for storage-related errors
class StorageException extends AppException {
  const StorageException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });

  /// Factory constructor for insufficient space errors
  factory StorageException.insufficientSpace([String? message]) {
    return StorageException(
      message: message ?? 'Insufficient storage space',
      code: 'STORAGE_SPACE',
    );
  }

  /// Factory constructor for permission errors
  factory StorageException.permission([String? message]) {
    return StorageException(
      message: message ?? 'Storage permission denied',
      code: 'STORAGE_PERMISSION',
    );
  }

  @override
  String get userMessage =>
      'Unable to access storage. Please check app permissions.';
}

/// Exception for validation errors
class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
    this.field,
  });

  /// Factory constructor for required field errors
  factory ValidationException.required(String field) {
    return ValidationException(
      message: '$field is required',
      code: 'VALIDATION_REQUIRED',
      field: field,
    );
  }

  /// Factory constructor for invalid format errors
  factory ValidationException.invalidFormat(String field, [String? format]) {
    return ValidationException(
      message:
          '$field has invalid format${format != null ? ": expected $format" : ""}',
      code: 'VALIDATION_FORMAT',
      field: field,
    );
  }

  final String? field;

  @override
  String get userMessage => 'Please check your input and try again.';
}

/// Exception for unexpected errors
class UnexpectedException extends AppException {
  const UnexpectedException({
    required super.message,
    super.code = 'UNEXPECTED',
    super.error,
    super.stackTrace,
  });

  @override
  String get userMessage =>
      'An unexpected error occurred. Please try again later.';
}

/// Exception for feature-specific errors
class FeatureException extends AppException {
  const FeatureException({
    required super.message,
    required String featureCode,
    super.error,
    super.stackTrace,
  }) : super(code: 'FEATURE_$featureCode');

  @override
  bool get shouldDisplay => true;
}
