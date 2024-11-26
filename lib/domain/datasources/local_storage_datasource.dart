import 'package:confession/core/base/domain_model.dart';

abstract class LocalStorageDataSource {
  Future<void> remove(String key);
  Future<String?> get(String key);
  Future<void> set(String key, String data);
  Future<void> clear();
  Future<bool> has(String key);
}

abstract class LocalStorageEntity<T extends DomainModel> {
  Future<T> read();

  Future<void> write(T? value);

  Future<void> delete();
}
