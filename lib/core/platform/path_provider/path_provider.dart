import 'dart:io';

import 'package:confession/core/platform/path_provider/path_provider_exception.dart';

typedef GetDirectoryCallback = Future<Directory> Function();

abstract class PathProvider {
  Future<Directory> getApplicationDocumentsDirectory();
  Future<Directory> getTemporaryDirectory();
}

class PathProviderImpl implements PathProvider {
  PathProviderImpl({
    required this.getDocumentsDirectory,
    required this.getTempDirectory,
  });

  final GetDirectoryCallback getDocumentsDirectory;
  final GetDirectoryCallback getTempDirectory;

  @override
  Future<Directory> getApplicationDocumentsDirectory() async {
    try {
      return await getDocumentsDirectory();
    } catch (e) {
      throw PathProviderException(
        'Failed to get application documents directory',
        e,
      );
    }
  }

  @override
  Future<Directory> getTemporaryDirectory() async {
    try {
      return await getTempDirectory();
    } catch (e) {
      throw PathProviderException(
        'Failed to get temporary directory',
        e,
      );
    }
  }
}
