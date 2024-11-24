import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProvider extends StatelessWidget {
  const UserProvider({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UserBloc>()..add(const BlocEvent(argument: LoadUser())),
      child: child,
    );
  }
}
