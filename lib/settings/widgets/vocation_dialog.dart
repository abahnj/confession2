import 'package:auto_route/auto_route.dart';
import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/domain/entities/user.dart';
import 'package:confession/domain/enums/user_enums.dart';
import 'package:confession/l10n/l10n.dart';
import 'package:confession/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VocationDialog extends StatelessWidget {
  const VocationDialog({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Center(
        child: Text(context.l10n.settingsVocationTitle),
      ),
      children: <Widget>[
        RadioListTile(
          title: Text(context.l10n.settingsVocationSingle),
          value: Vocation.single,
          groupValue: user.vocation,
          onChanged: (_) {
            context.read<UserBloc>().add(
                  BlocEvent(
                    argument:
                        UpdateUser(user.copyWith(vocation: Vocation.single)),
                  ),
                );
            context.maybePop();
          },
        ),
        RadioListTile(
          title: Text(context.l10n.settingsVocationMarried),
          value: Vocation.married,
          groupValue: user.vocation,
          onChanged: (gender) {
            context.read<UserBloc>().add(
                  BlocEvent(
                    argument:
                        UpdateUser(user.copyWith(vocation: Vocation.married)),
                  ),
                );
            context.maybePop();
          },
        ),
        RadioListTile(
          title: Text(context.l10n.settingsVocationReligious),
          value: Vocation.religious,
          groupValue: user.vocation,
          onChanged: (_) {
            context.read<UserBloc>().add(
                  BlocEvent(
                    argument:
                        UpdateUser(user.copyWith(vocation: Vocation.religious)),
                  ),
                );
            context.maybePop();
          },
        ),
        RadioListTile(
          title: Text(context.l10n.settingsVocationPriest),
          value: Vocation.priest,
          groupValue: user.vocation,
          onChanged: (gender) {
            context.read<UserBloc>().add(
                  BlocEvent(
                    argument:
                        UpdateUser(user.copyWith(vocation: Vocation.priest)),
                  ),
                );
            context.maybePop();
          },
        ),
      ],
    );
  }
}
