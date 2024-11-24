import 'package:confession/theme/data/models/theme_domain_model.dart';

abstract class ThemeRepository {
  Future<ThemeDomainModel> getThemeSettings();
  Future<void> saveThemeSettings(ThemeDomainModel theme);
}
