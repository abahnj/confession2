import 'package:confession/core/base/view_data.dart';
import 'package:confession/theme/data/models/theme_domain_model.dart';

class Theme extends ViewData<ThemeDomainModel> {
  const Theme({
    required this.isDarkMode,
    required this.themeName,
  });

  final bool isDarkMode;
  final String themeName;

  @override
  ThemeDomainModel toDomain() => ThemeDomainModel(
        isDarkMode: isDarkMode,
        themeName: themeName,
      );

  @override
  List<Object?> get props => [isDarkMode, themeName];
}
