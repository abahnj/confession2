import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/presentation/bloc/user/user_bloc.dart';
import 'package:confession/theme/presentation/bloc/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) =>
              sl<UserBloc>()..add(const BlocEvent(argument: LoadUser())),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => sl<ThemeCubit>()..loadThemeSettings(),
        ),
      ],
      child: child,
    );
  }
}
