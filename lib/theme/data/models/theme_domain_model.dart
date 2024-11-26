import 'package:confession/core/base/domain_model.dart';

final class ThemeDomainModel extends DomainModel {
  const ThemeDomainModel({required this.themeMode});

  @override
  factory ThemeDomainModel.fromJson(Map<String, dynamic> json) =>
      ThemeDomainModel(
        themeMode: json['themeMode'] as String,
      );

  const ThemeDomainModel.empty() : themeMode = 'system';

  final String themeMode;

  @override
  ThemeDomainModel copyWith({
    bool? isDarkMode,
    String? themeName,
  }) =>
      ThemeDomainModel(themeMode: themeMode);

  @override
  Map<String, dynamic> toJson() => {
        'themeMode': themeMode,
      };

  @override
  List<Object?> get props => [themeMode];
}
