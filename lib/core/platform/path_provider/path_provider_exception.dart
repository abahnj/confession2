class PathProviderException implements Exception {
  PathProviderException(this.message, [this.error]);
  final String message;
  final dynamic error;

  @override
  String toString() => 'PathProviderException: $message';
}
