import 'dart:convert';

import 'package:confession/data/datasources/local/user_local_datasource_impl.dart';
import 'package:confession/domain/datasources/local_storage_datasource.dart';
import 'package:confession/domain/dtos/models/user_domain_model.dart';
import 'package:confession/domain/enums/user_enums.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalStorageDataSource extends Mock
    implements LocalStorageDataSource {}

void main() {
  late MockLocalStorageDataSource mockLocalStorageDataSource;
  late UserLocalDataSourceImpl userLocalDataSource;

  setUp(() {
    mockLocalStorageDataSource = MockLocalStorageDataSource();
    userLocalDataSource = UserLocalDataSourceImpl(mockLocalStorageDataSource);

    when(() => mockLocalStorageDataSource.get('user'))
        .thenAnswer((_) async => null);
    when(() => mockLocalStorageDataSource.set('user', any()))
        .thenAnswer((_) async {});
    when(() => mockLocalStorageDataSource.remove('user'))
        .thenAnswer((_) async {});
  });

  test('should delete user data from local storage', () async {
    await userLocalDataSource.delete();
    verify(() => mockLocalStorageDataSource.remove('user')).called(1);
  });

  test('should throw when there is no user data', () async {
    when(() => mockLocalStorageDataSource.get('user'))
        .thenAnswer((_) async => null);

    expect(() => userLocalDataSource.read(), throwsA(isA<Exception>()));
  });

  test('should return UserDomainModel when there is user data', () async {
    const userJson =
        '{"age": "adult", "vocation": "married", "gender": "female", "lastConfession": "lastConfession"}';
    when(() => mockLocalStorageDataSource.get('user'))
        .thenAnswer((_) async => userJson);
    final result = await userLocalDataSource.read();
    expect(
      result,
      UserDomainModel.fromJson(jsonDecode(userJson) as Map<String, dynamic>),
    );
  });

  test('should write user data to local storage', () async {
    const user = UserDomainModel(
      age: Age.adult,
      vocation: Vocation.married,
      gender: Gender.female,
      lastConfession: 'lastConfession',
    );

    await userLocalDataSource.write(user);
    verify(
      () => mockLocalStorageDataSource.set('user', jsonEncode(user.toJson())),
    ).called(1);
  });

  test('should write null user data to local storage', () async {
    await userLocalDataSource.write(null);
    verify(() => mockLocalStorageDataSource.set('user', jsonEncode(null)))
        .called(1);
  });
}
