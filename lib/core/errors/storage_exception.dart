class StorageNotInitializedException implements Exception {
  final String message = 'Storage service not initialized. Call init() first.';

  @override
  String toString() => message;
}
