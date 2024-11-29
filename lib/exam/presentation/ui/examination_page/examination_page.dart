import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/domain/entities/user.dart';
import 'package:confession/exam/domain/entities/examination.dart';
import 'package:confession/exam/domain/usecases/get_examinations_usecase.dart';
import 'package:confession/exam/presentation/bloc/examinations_bloc.dart';
import 'package:confession/presentation/bloc/user/user_bloc.dart';
import 'package:confession/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ExaminationPage extends StatelessWidget {
  const ExaminationPage({@PathParam('commandmentId') required this.commandmentId, super.key});

  final int commandmentId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExaminationsBloc(getExaminationsUsecase: sl())
        ..add(
          BlocEvent(
            argument: GetExaminationsParam(commandmentId: commandmentId, user: context.read<UserBloc>().state),
          ),
        ),
      child: BlocListener<UserBloc, User>(
        listener: (context, state) {
          log('UserBloc state: $state');
          context
              .read<ExaminationsBloc>()
              .add(BlocEvent(argument: GetExaminationsParam(commandmentId: commandmentId, user: state)));
        },
        child: const ExaminationConsumer(),
      ),
    );
  }
}

class ExaminationConsumer extends StatelessWidget {
  const ExaminationConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExaminationsBloc, BlocState<ExaminationsList>>(
      builder: (context, state) => state.mapOrElse(
        orElse: () => const ExaminationLoadingView(),
        success: (examinations) => ExaminationLoadedView(examinationsList: examinations),
        error: () => const ExaminationErrorView(),
      ),
    );
  }
}

class ExaminationLoadedView extends StatelessWidget {
  const ExaminationLoadedView({
    required this.examinationsList,
    super.key,
  });

  final ExaminationsList examinationsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ConfessionAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: examinationsList.data
              .map(
                (examination) => ListTile(
                  title: Text(examination.examinationText),
                  subtitle: Text(examination.count.toString()),
                  onTap: () {},
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class ExaminationLoadingView extends StatelessWidget {
  const ExaminationLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ConfessionAppBar(),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class ExaminationErrorView extends StatelessWidget {
  const ExaminationErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ConfessionAppBar(),
      body: Center(
        child: Text('Error'),
      ),
    );
  }
}
