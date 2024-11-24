class DatabaseException implements Exception {
  DatabaseException(this.message, [this.error]);
  final String message;
  final dynamic error;

  @override
  String toString() {
    return 'DatabaseException: $message';
  }
}
