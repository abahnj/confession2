import 'package:confession/core/base/mappers.dart';
import 'package:confession/theme/data/models/theme_domain_model.dart';
import 'package:confession/theme/domain/entities/theme.dart';
import 'package:flutter/material.dart';

class ThemeMapper extends ViewDataMapper<AppThemeMode, ThemeDomainModel> {
  @override
  ThemeDomainModel toDomainModel(AppThemeMode viewData) {
    return ThemeDomainModel(themeMode: viewData.themeMode.name);
  }

  @override
  AppThemeMode toViewData(ThemeDomainModel model) {
    return AppThemeMode(themeMode: ThemeMode.values.byName(model.themeMode));
  }
}
