import 'package:confession/domain/datasources/local_storage_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDataSource implements LocalStorageDataSource {
  SharedPreferencesDataSource({required SharedPreferences preferences})
      : _preferences = preferences;

  final SharedPreferences _preferences;

  @override
  Future<bool> set(String key, String data) async =>
      _preferences.setString(key, data);

  @override
  Future<String?> get(String key) async => _preferences.getString(key);

  @override
  Future<bool> remove(String key) async => _preferences.remove(key);

  @override
  Future<void> clear() async => _preferences.clear();

  @override
  Future<bool> has(String key) async => _preferences.containsKey(key);
}
