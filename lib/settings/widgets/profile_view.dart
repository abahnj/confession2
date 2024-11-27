import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/domain/entities/user.dart';
import 'package:confession/domain/enums/user_enums.dart';
import 'package:confession/l10n/l10n.dart';
import 'package:confession/presentation/bloc/user/user_bloc.dart';
import 'package:confession/settings/widgets/age_dialog.dart';
import 'package:confession/settings/widgets/gender_dialog.dart';
import 'package:confession/settings/widgets/vocation_dialog.dart';
import 'package:confession/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final surfaceVariantTextTheme = context.textTheme.labelMedium
        ?.copyWith(color: context.colorScheme.onSurfaceVariant);
    return BlocBuilder<UserBloc, User>(
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
                subtitle: Text(
                  _getLocalizedGender(context, state.gender),
                  style: surfaceVariantTextTheme,
                ),
                onTap: () => _showDialog(
                  context,
                  GenderDialog(user: state),
                ),
              ),
              ListTile(
                title: Text(
                  context.l10n.settingsAgeTitle,
                  style: context.textTheme.titleMedium,
                ),
                subtitle: Text(
                  _getLocalizedAge(context, state.age),
                  style: surfaceVariantTextTheme,
                ),
                onTap: () => _showDialog(
                  context,
                  AgeDialog(user: state),
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
                onTap: () => _showDialog(
                  context,
                  VocationDialog(user: state),
                ),
              ),
              ListTile(
                title: Text(
                  context.l10n.settingsDateOfLastConfessionTitle,
                  style: context.textTheme.titleMedium,
                ),
                subtitle: Text(
                  state.lastConfession.isEmpty
                      ? context.l10n.settingsDateOfLastConfessionUnknown
                      : state.formattedLastConfession,
                  style: surfaceVariantTextTheme,
                ),
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDate != null) {
                    if (context.mounted) {
                      context.read<UserBloc>().add(
                            BlocEvent(
                              argument: UpdateUser(
                                state.copyWith(
                                  lastConfession:
                                      selectedDate.toIso8601String(),
                                ),
                              ),
                            ),
                          );
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
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

  void _showDialog(BuildContext context, Widget dialog) {
    showAdaptiveDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => dialog,
    );
  }
}
