import 'package:confession/theme/data/datasources/theme_local_datasource.dart';
import 'package:confession/theme/data/models/theme_domain_model.dart';
import 'package:confession/theme/domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  ThemeRepositoryImpl({required this.localDataSource});

  final ThemeLocalDataSource localDataSource;

  @override
  Future<ThemeDomainModel> getThemeSettings() async => localDataSource.read();

  @override
  Future<void> saveThemeSettings(ThemeDomainModel theme) async =>
      localDataSource.write(theme);
}
