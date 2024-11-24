import 'dart:io';

import 'package:confession/core/platform/path_provider/path_provider_exception.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

abstract class PathProvider {
  Future<Directory> getApplicationDocumentsDirectory();
  Future<Directory> getTemporaryDirectory();
  Future<Directory> getSupportDirectory();
  Future<Directory?> getExternalStorageDirectory();
}

// lib/core/platform/path_provider/path_provider.dart

class PathProviderImpl implements PathProvider {
  @override
  Future<Directory> getApplicationDocumentsDirectory() async {
    try {
      return await path_provider.getApplicationDocumentsDirectory();
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
      return await path_provider.getTemporaryDirectory();
    } catch (e) {
      throw PathProviderException(
        'Failed to get temporary directory',
        e,
      );
    }
  }

  @override
  Future<Directory> getSupportDirectory() async {
    try {
      return await path_provider.getApplicationSupportDirectory();
    } catch (e) {
      throw PathProviderException(
        'Failed to get support directory',
        e,
      );
    }
  }

  @override
  Future<Directory?> getExternalStorageDirectory() async {
    try {
      return await path_provider.getExternalStorageDirectory();
    } catch (e) {
      throw PathProviderException(
        'Failed to get external storage directory',
        e,
      );
    }
  }
}
