import 'dart:developer';

import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/theme/domain/entities/theme.dart';
import 'package:confession/theme/domain/usecases.dart/get_theme_usecase.dart';
import 'package:confession/theme/domain/usecases.dart/toggle_theme_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<AppThemeMode> {
  ThemeCubit({
    required GetThemeUseCase getThemeUseCase,
    required ToggleThemeUsecase toggleThemeUsecase,
  })  : _getThemeUseCase = getThemeUseCase,
        _toggleThemeUsecase = toggleThemeUsecase,
        super(const AppThemeMode(themeMode: ThemeMode.system));

  final GetThemeUseCase _getThemeUseCase;
  final ToggleThemeUsecase _toggleThemeUsecase;

  Future<void> loadThemeSettings() async {
    try {
      final theme = await _getThemeUseCase(const NoParams());
      emit(theme);
    } catch (e, st) {
      log('Error loading theme settings', error: e, stackTrace: st);
    }
  }

  Future<void> setThemeMode(ThemeMode theme) async {
    try {
      final newSettings = AppThemeMode(themeMode: theme);
      await _toggleThemeUsecase(newSettings);
      emit(newSettings);
    } catch (e, st) {
      log('Error setting theme mode', error: e, stackTrace: st);
    }
  }
}
