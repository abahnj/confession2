import 'dart:convert';

import 'package:confession/domain/datasources/local_storage_datasource.dart';
import 'package:confession/domain/datasources/user_local_datasource.dart';
import 'package:confession/domain/dtos/models/user_domain_model.dart';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  UserLocalDataSourceImpl(this._localStorage);

  final LocalStorageDataSource _localStorage;
  final String _userKey = 'user';

  @override
  Future<void> delete() async => _localStorage.remove(_userKey);

  @override
  Future<UserDomainModel> read() async {
    final json = await _localStorage.get(_userKey);

    if (json == null) {
      throw Exception('User not found');
    }

    final jsonMap = jsonDecode(json) as Map<String, dynamic>;

    return UserDomainModel.fromJson(jsonMap);
  }

  @override
  Future<void> write(UserDomainModel? value) =>
      _localStorage.set(_userKey, jsonEncode(value?.toJson()));
}
