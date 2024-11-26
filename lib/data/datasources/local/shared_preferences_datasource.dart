import 'package:confession/domain/datasources/local_storage_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDataSource implements LocalStorageDataSource {
  SharedPreferencesDataSource({required SharedPreferencesWithCache preferences})
      : _preferences = preferences;

  final SharedPreferencesWithCache _preferences;

  @override
  Future<void> set(String key, String data) async =>
      _preferences.setString(key, data);

  @override
  Future<String?> get(String key) async => _preferences.getString(key);

  @override
  Future<void> remove(String key) async => _preferences.remove(key);

  @override
  Future<void> clear() async => _preferences.clear();

  @override
  Future<bool> has(String key) async => _preferences.containsKey(key);
}
