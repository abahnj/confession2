import 'package:auto_route/auto_route.dart';
import 'package:confession/domain/entities/user.dart';
import 'package:confession/domain/enums/user_enums.dart';
import 'package:confession/l10n/l10n.dart';
import 'package:confession/presentation/bloc/user/user_bloc.dart';
import 'package:confession/settings/widgets/age_dialog.dart';
import 'package:confession/settings/widgets/app_theme_dialog.dart';
import 'package:confession/shared/utils.dart';
import 'package:confession/theme/domain/entities/theme.dart';
import 'package:confession/theme/presentation/bloc/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Feature not implemented yet'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final surfaceVariantTextTheme =
        context.textTheme.labelMedium?.copyWith(color: context.colorScheme.onSurfaceVariant);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settingsAppBarTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BlocBuilder<UserBloc, User>(
              builder: (context, state) {
                return Card.filled(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          context.l10n.settingsGenderTitle,
                          style: context.textTheme.titleMedium,
                        ),
                        subtitle: Text(_getLocalizedGender(context, state.gender), style: surfaceVariantTextTheme),
                        onTap: () => _showSnackBar(context),
                      ),
                      ListTile(
                        title: Text(
                          context.l10n.settingsAgeTitle,
                          style: context.textTheme.titleMedium,
                        ),
                        subtitle: Text(
                          _getLocalizedAge(context, state.age),
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                        ),
                        onTap: () => showAdaptiveDialog<void>(
                          context: context,
                          builder: (context) => AgeDialog(user: state),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          context.l10n.settingsVocationTitle,
                          style: context.textTheme.titleMedium,
                        ),
                        subtitle: Text(
                          _getLocalizedVocation(context, state.vocation),
                          style: surfaceVariantTextTheme,
                        ),
                        onTap: () => _showSnackBar(context),
                      ),
                      ListTile(
                        title:
                            Text(context.l10n.settingsDateOfLastConfessionTitle, style: context.textTheme.titleMedium),
                        subtitle: Text(state.lastConfession, style: surfaceVariantTextTheme),
                        onTap: () => _showSnackBar(context),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Card.filled(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  BlocBuilder<ThemeCubit, AppThemeMode>(
                    builder: (context, state) {
                      return ListTile(
                        title: Text(context.l10n.settingsThemeTitle, style: context.textTheme.titleMedium),
                        subtitle: Text(
                          _getLocalizedThemeMode(context, state.themeMode),
                          style: surfaceVariantTextTheme,
                        ),
                        onTap: () => showAdaptiveDialog<void>(
                          context: context,
                          builder: (context) => AppThemeDialog(userThemeMode: state.themeMode),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card.filled(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: Text('Send Feedback', style: context.textTheme.titleMedium),
                    subtitle: Text('Report technical issues or suggest new features', style: surfaceVariantTextTheme),
                    onTap: () => _showSnackBar(context),
                  ),
                  ListTile(
                    title: Text('Reset App', style: context.textTheme.titleMedium),
                    onTap: () => _showSnackBar(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getLocalizedThemeMode(BuildContext context, ThemeMode themeMode) {
    return switch (themeMode) {
      ThemeMode.system => context.l10n.settingsThemeModeSystem,
      ThemeMode.dark => context.l10n.settingsThemeModeDark,
      ThemeMode.light => context.l10n.settingsThemeModeLight,
    };
  }

  String _getLocalizedGender(BuildContext context, Gender gender) {
    return switch (gender) {
      Gender.male => context.l10n.settingsGenderMale,
      Gender.female => context.l10n.settingsGenderFemale,
    };
  }

  String _getLocalizedAge(BuildContext context, Age age) {
    return switch (age) {
      Age.adult => context.l10n.settingsAgeAdult,
      Age.teen => context.l10n.settingsAgeTeen,
      Age.child => context.l10n.settingsAgeChild,
    };
  }

  String _getLocalizedVocation(BuildContext context, Vocation vocation) {
    return switch (vocation) {
      Vocation.single => context.l10n.settingsVocationSingle,
      Vocation.married => context.l10n.settingsVocationMarried,
      Vocation.religious => context.l10n.settingsVocationReligious,
      Vocation.priest => context.l10n.settingsVocationPriest,
    };
  }
}
