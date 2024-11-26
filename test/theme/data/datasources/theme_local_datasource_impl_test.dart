import 'dart:convert';

import 'package:confession/domain/datasources/local_storage_datasource.dart';
import 'package:confession/theme/data/datasources/theme_local_datasource_impl.dart';
import 'package:confession/theme/data/models/theme_domain_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockLocalStorageDataSource extends Mock
    implements LocalStorageDataSource {}

void main() {
  late _MockLocalStorageDataSource mockLocalStorageDataSource;
  late ThemeLocalDataSourceImpl themeLocalDataSource;

  setUp(() {
    mockLocalStorageDataSource = _MockLocalStorageDataSource();
    themeLocalDataSource =
        ThemeLocalDataSourceImpl(localStorage: mockLocalStorageDataSource);

    when(() => mockLocalStorageDataSource.get(any()))
        .thenAnswer((_) async => null);
    when(() => mockLocalStorageDataSource.set(any(), any()))
        .thenAnswer((_) async {});
    when(() => mockLocalStorageDataSource.remove(any()))
        .thenAnswer((_) async {});
  });

  test('should delete theme data from local storage', () async {
    await themeLocalDataSource.delete();
    verify(() => mockLocalStorageDataSource.remove('theme')).called(1);
  });

  test('should return ThemeDomainModel.empty when there is no theme data',
      () async {
    when(() => mockLocalStorageDataSource.get('theme'))
        .thenAnswer((_) async => null);
    final result = await themeLocalDataSource.read();
    expect(result, const ThemeDomainModel.empty());
  });

  test('should return ThemeDomainModel when there is theme data', () async {
    const themeJson = '{"themeMode": "dark"}';
    when(() => mockLocalStorageDataSource.get('theme'))
        .thenAnswer((_) async => themeJson);
    final result = await themeLocalDataSource.read();
    expect(
      result,
      ThemeDomainModel.fromJson(
        jsonDecode(themeJson) as Map<String, dynamic>,
      ),
    );
  });

  test('should write theme data to local storage', () async {
    const theme = ThemeDomainModel(themeMode: 'dark');
    await themeLocalDataSource.write(theme);
    verify(
      () => mockLocalStorageDataSource.set('theme', jsonEncode(theme.toJson())),
    ).called(1);
  });

  test('should write null theme data to local storage', () async {
    await themeLocalDataSource.write(null);
    verify(() => mockLocalStorageDataSource.set('theme', jsonEncode(null)))
        .called(1);
  });
}
