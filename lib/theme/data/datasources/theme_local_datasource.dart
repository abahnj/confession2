import 'package:confession/domain/datasources/local_storage_datasource.dart';
import 'package:confession/theme/data/models/theme_domain_model.dart';

abstract class ThemeLocalDataSource
    extends LocalStorageEntity<ThemeDomainModel> {}
