import 'package:confession/data/datasources/local/shared_preferences_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _MockSharedPreferencesWithCache extends Mock
    implements SharedPreferencesWithCache {}

void main() {
  late SharedPreferencesWithCache preferences;
  late SharedPreferencesDataSource dataSource;

  setUp(() async {
    preferences = _MockSharedPreferencesWithCache();
    dataSource = SharedPreferencesDataSource(preferences: preferences);

    final preferencesCache = <String, String>{};

    when(() => preferences.setString(any(), any()))
        .thenAnswer((invocation) async {
      preferencesCache[invocation.positionalArguments[0] as String] =
          invocation.positionalArguments[1] as String;
    });
    when(() => preferences.getString(any())).thenAnswer((invocation) {
      return preferencesCache[invocation.positionalArguments[0] as String];
    });
    when(() => preferences.remove(any())).thenAnswer((invocation) {
      preferencesCache.remove(invocation.positionalArguments[0] as String);
      return Future.value();
    });
    when(() => preferences.clear()).thenAnswer((_) {
      preferencesCache.clear();
      return Future.value();
    });
    when(() => preferences.containsKey(any())).thenAnswer((invocation) {
      return preferencesCache
          .containsKey(invocation.positionalArguments[0] as String);
    });
  });

  test('set stores a value', () async {
    const key = 'testKey';
    const value = 'testValue';
    await dataSource.set(key, value);
    expect(preferences.getString(key), value);
  });

  test('get retrieves a value', () async {
    const key = 'testKey';
    const value = 'testValue';
    await preferences.setString(key, value);
    final result = await dataSource.get(key);
    expect(result, value);
  });

  test('remove deletes a value', () async {
    const key = 'testKey';
    const value = 'testValue';
    await preferences.setString(key, value);
    await dataSource.remove(key);
    expect(preferences.getString(key), isNull);
  });

  test('clear removes all values', () async {
    const key1 = 'testKey1';
    const value1 = 'testValue1';
    const key2 = 'testKey2';
    const value2 = 'testValue2';
    await preferences.setString(key1, value1);
    await preferences.setString(key2, value2);
    await dataSource.clear();
    expect(preferences.getString(key1), isNull);
    expect(preferences.getString(key2), isNull);
  });

  test('has checks if a key exists', () async {
    const key = 'testKey';
    const value = 'testValue';
    await preferences.setString(key, value);
    final result = await dataSource.has(key);
    expect(result, isTrue);
    await preferences.remove(key);
    final resultAfterRemove = await dataSource.has(key);
    expect(resultAfterRemove, isFalse);
  });
}
