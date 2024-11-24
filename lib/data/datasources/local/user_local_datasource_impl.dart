import 'dart:convert';

import 'package:confession/domain/datasources/local_storage_datasource.dart';
import 'package:confession/domain/datasources/user_local_datasource.dart';
import 'package:confession/domain/dtos/models/user_domain_model.dart';
import 'package:confession/domain/entities/storage_keys.dart';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  UserLocalDataSourceImpl(this._localStorage);

  final LocalStorageDataSource _localStorage;
  final String _userKey = 'user';

  @override
  Future<void> delete() async => _localStorage.remove(_userKey);

  @override
  Future<UserDomainModel> read() async {
    final json = await _localStorage.get(StorageKeys.user);

    if (json == null) return const UserDomainModel.empty();

    final jsonMap = jsonDecode(json) as Map<String, dynamic>;

    return UserDomainModel.fromJson(jsonMap);
  }

  @override
  Future<void> write(UserDomainModel? value) => _localStorage.set(StorageKeys.user, jsonEncode(value?.toJson()));
}
