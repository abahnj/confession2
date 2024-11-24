import 'package:confession/counter/counter.dart';
import 'package:confession/l10n/l10n.dart';
import 'package:confession/presentation/providers/user_provider.dart';
import 'package:confession/shared/app_theme.dart';
import 'package:confession/theme/domain/entities/theme.dart';
import 'package:confession/theme/presentation/bloc/theme_cubit.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: BlocBuilder<ThemeCubit, Theme>(
        builder: (context, state) {
          return MaterialApp(
            theme: state.isDarkMode ? AppTheme.dark : AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const CounterPage(),
          );
        },
      ),
    );
  }
}
