import 'package:confession/l10n/l10n.dart';
import 'package:confession/presentation/providers/user_provider.dart';
import 'package:confession/router/app_router.dart';
import 'package:confession/router/observers/app_route_observer.dart';
import 'package:confession/shared/app_theme.dart';
import 'package:confession/theme/domain/entities/theme.dart';
import 'package:confession/theme/presentation/bloc/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final _appRouter = AppRouter();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: BlocBuilder<ThemeCubit, AppThemeMode>(
        builder: (context, state) {
          return MaterialApp.router(
            // routerDelegate: _appRouter.delegate(),
            // routeInformationParser: _appRouter.defaultRouteParser(),
            routerConfig: _appRouter.config(
              navigatorObservers: () => [AppRouteObserver()],
            ),
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: state.themeMode,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
    );
  }
}
