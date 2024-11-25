import 'package:auto_route/auto_route.dart';
import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/domain/entities/user.dart';
import 'package:confession/domain/enums/user_enums.dart';
import 'package:confession/l10n/l10n.dart';
import 'package:confession/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgeDialog extends StatelessWidget {
  const AgeDialog({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Center(
        child: Text(context.l10n.settingsGenderTitle),
      ),
      children: <Widget>[
        RadioListTile<Age>(
          title: Text(context.l10n.settingsAgeAdult),
          value: Age.adult,
          groupValue: user.age,
          onChanged: (gender) {
            context.read<UserBloc>().add(BlocEvent(argument: UpdateUser(user.copyWith(age: Age.adult))));
            context.maybePop();
          },
        ),
        RadioListTile(
          title: Text(context.l10n.settingsAgeTeen),
          value: Age.teen,
          groupValue: user.age,
          onChanged: (gender) {
            context.read<UserBloc>().add(BlocEvent(argument: UpdateUser(user.copyWith(age: Age.teen))));
            context.maybePop();
          },
        ),
        RadioListTile(
          title: Text(context.l10n.settingsAgeChild),
          value: Age.child,
          groupValue: user.age,
          onChanged: (value) {
            context.read<UserBloc>().add(BlocEvent(argument: UpdateUser(user.copyWith(age: Age.child))));
            context.maybePop();
          },
        ),
      ],
    );
  }
}
