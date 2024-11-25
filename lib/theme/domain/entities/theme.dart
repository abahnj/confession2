import 'package:confession/core/base/view_data.dart';
import 'package:confession/theme/data/models/theme_domain_model.dart';
import 'package:flutter/material.dart';

class AppThemeMode extends ViewData<ThemeDomainModel> {
  const AppThemeMode({required this.themeMode});

  final ThemeMode themeMode;

  @override
  ThemeDomainModel toDomain() => ThemeDomainModel(themeMode: themeMode);

  @override
  List<Object?> get props => [themeMode];
}
