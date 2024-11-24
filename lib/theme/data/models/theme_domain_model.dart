import 'package:confession/core/base/domain_model.dart';
import 'package:confession/theme/domain/entities/theme.dart';

final class ThemeDomainModel implements DomainModel<Theme> {
  const ThemeDomainModel({
    required this.isDarkMode,
    required this.themeName,
  });

  @override
  factory ThemeDomainModel.fromJson(Map<String, dynamic> json) {
    return ThemeDomainModel(
      isDarkMode: json['isDarkMode'] as bool,
      themeName: json['themeName'] as String,
    );
  }

  const ThemeDomainModel.empty()
      : isDarkMode = false,
        themeName = '';

  final bool isDarkMode;
  final String themeName;

  @override
  ThemeDomainModel copyWith({
    bool? isDarkMode,
    String? themeName,
  }) {
    return ThemeDomainModel(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      themeName: themeName ?? this.themeName,
    );
  }

  @override
  Theme toViewData() => Theme(
        isDarkMode: isDarkMode,
        themeName: themeName,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'isDarkMode': isDarkMode,
      'themeName': themeName,
    };
  }
}
