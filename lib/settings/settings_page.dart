import 'package:auto_route/auto_route.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/database/daos/daos.dart';
import 'package:confession/l10n/l10n.dart';
import 'package:confession/settings/widgets/app_theme_dialog.dart';
import 'package:confession/settings/widgets/profile_view.dart';
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

  void _showDialog(BuildContext context, Widget dialog) {
    showAdaptiveDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => dialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    final surfaceVariantTextTheme = context.textTheme.labelMedium
        ?.copyWith(color: context.colorScheme.onSurfaceVariant);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settingsAppBarTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const ProfileView(),
            const SizedBox(height: 16),
            Card.filled(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  BlocBuilder<ThemeCubit, AppThemeMode>(
                    builder: (context, state) {
                      return ListTile(
                        title: Text(
                          context.l10n.settingsThemeTitle,
                          style: context.textTheme.titleMedium,
                        ),
                        subtitle: Text(
                          _getLocalizedThemeMode(context, state.themeMode),
                          style: surfaceVariantTextTheme,
                        ),
                        onTap: () => _showDialog(
                          context,
                          AppThemeDialog(userThemeMode: state.themeMode),
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
                    title: Text(
                      'Send Feedback',
                      style: context.textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      'Report technical issues or suggest new features',
                      style: surfaceVariantTextTheme,
                    ),
                    onTap: () => _showSnackBar(context),
                  ),
                  ListTile(
                    title: Text('Restore Deleted Examinations',
                        style: context.textTheme.titleMedium,),
                    onTap: () => _showDialog(
                      context,
                      AlertDialog(
                        title: const Text('Reset Examinations'),
                        content: const Text(
                          'Are you sure you want to restore all deleted examinations?',
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => context.maybePop(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              final count = await sl
                                  .get<ExaminationsDao>()
                                  .restoreDeletedExaminations();
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Restored $count examinations'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                                await context.maybePop();
                              }
                            },
                            child: const Text('Restore'),
                          ),
                        ],
                      ),
                    ),
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
}
