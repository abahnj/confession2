import 'package:confession/core/base/view_data.dart';
import 'package:flutter/material.dart';

class AppThemeMode extends ViewData {
  const AppThemeMode({required this.themeMode});

  final ThemeMode themeMode;

  @override
  List<Object?> get props => [themeMode];
}
