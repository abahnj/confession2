import 'package:auto_route/auto_route.dart';
import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/domain/entities/user.dart';
import 'package:confession/domain/enums/user_enums.dart';
import 'package:confession/l10n/l10n.dart';
import 'package:confession/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderDialog extends StatelessWidget {
  const GenderDialog({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Center(
        child: Text(context.l10n.settingsGenderTitle),
      ),
      children: <Widget>[
        RadioListTile(
          title: Text(context.l10n.settingsGenderMale),
          value: Gender.male,
          groupValue: user.gender,
          onChanged: (_) {
            context.read<UserBloc>().add(
                  BlocEvent(
                    argument: UpdateUser(user.copyWith(gender: Gender.male)),
                  ),
                );
            context.maybePop();
          },
        ),
        RadioListTile(
          title: Text(context.l10n.settingsGenderFemale),
          value: Gender.female,
          groupValue: user.gender,
          onChanged: (gender) {
            context.read<UserBloc>().add(
                  BlocEvent(
                    argument: UpdateUser(user.copyWith(gender: Gender.female)),
                  ),
                );
            context.maybePop();
          },
        ),
      ],
    );
  }
}
