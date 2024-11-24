import 'dart:convert';

import 'package:confession/domain/datasources/local_storage_datasource.dart';
import 'package:confession/theme/data/datasources/theme_local_datasource.dart';
import 'package:confession/theme/data/models/theme_domain_model.dart';

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  ThemeLocalDataSourceImpl({required LocalStorageDataSource localStorage})
      : _localStorage = localStorage;

  final LocalStorageDataSource _localStorage;
  final String _themeKey = 'theme';

  @override
  Future<void> delete() async => _localStorage.remove(_themeKey);

  @override
  Future<ThemeDomainModel> read() async {
    final json = await _localStorage.get(_themeKey);

    if (json == null) return const ThemeDomainModel.empty();

    final jsonMap = jsonDecode(json) as Map<String, dynamic>;

    return ThemeDomainModel.fromJson(jsonMap);
  }

  @override
  Future<void> write(ThemeDomainModel? value) =>
      _localStorage.set(_themeKey, jsonEncode(value?.toJson()));
}
