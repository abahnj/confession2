import 'package:confession/core/base/domain_model.dart';
import 'package:confession/core/base/view_data.dart';

abstract class LocalStorageDataSource {
  Future<bool> remove(String key);
  Future<String?> get(String key);
  Future<bool> set(String key, String data);
  Future<void> clear();
  Future<bool> has(String key);
}

abstract class LocalStorageEntity<T extends DomainModel<ViewData<T>>> {
  Future<T> read();

  Future<void> write(T? value);

  Future<void> delete();
}
