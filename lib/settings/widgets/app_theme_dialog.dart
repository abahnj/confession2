import 'package:auto_route/auto_route.dart';
import 'package:confession/l10n/l10n.dart';
import 'package:confession/theme/presentation/bloc/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppThemeDialog extends StatelessWidget {
  const AppThemeDialog({required this.userThemeMode, super.key});

  final ThemeMode userThemeMode;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Center(
        child: Text(context.l10n.settingsThemeTitle),
      ),
      children: <Widget>[
        RadioListTile<ThemeMode>(
          title: Text(context.l10n.settingsThemeModeSystem),
          value: ThemeMode.system,
          groupValue: userThemeMode,
          onChanged: (gender) {
            context.read<ThemeCubit>().setThemeMode(ThemeMode.system);
            context.maybePop();
          },
        ),
        RadioListTile<ThemeMode>(
          title: Text(context.l10n.settingsThemeModeDark),
          value: ThemeMode.dark,
          groupValue: userThemeMode,
          onChanged: (gender) {
            context.read<ThemeCubit>().setThemeMode(ThemeMode.dark);
            context.maybePop();
          },
        ),
        RadioListTile<ThemeMode>(
          title: Text(context.l10n.settingsThemeModeLight),
          value: ThemeMode.light,
          groupValue: userThemeMode,
          onChanged: (gender) {
            context.read<ThemeCubit>().setThemeMode(ThemeMode.light);
            context.maybePop();
          },
        ),
      ],
    );
  }
}
