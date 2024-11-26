import 'package:confession/core/base/domain_model.dart';
import 'package:confession/theme/domain/entities/theme.dart';
import 'package:flutter/material.dart';

final class ThemeDomainModel implements DomainModel<AppThemeMode> {
  const ThemeDomainModel({required this.themeMode});

  @override
  factory ThemeDomainModel.fromJson(Map<String, dynamic> json) =>
      ThemeDomainModel(
        themeMode: ThemeMode.values.byName(json['themeMode'] as String),
      );

  const ThemeDomainModel.empty() : themeMode = ThemeMode.system;

  final ThemeMode themeMode;

  @override
  ThemeDomainModel copyWith({
    bool? isDarkMode,
    String? themeName,
  }) =>
      ThemeDomainModel(themeMode: themeMode);

  @override
  AppThemeMode toViewData() => AppThemeMode(themeMode: themeMode);

  @override
  Map<String, dynamic> toJson() => {
        'themeMode': themeMode.name,
      };
}
