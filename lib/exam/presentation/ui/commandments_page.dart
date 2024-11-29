import 'package:auto_route/auto_route.dart';
import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/domain/entities/user.dart';
import 'package:confession/exam/domain/entities/commandment.dart';
import 'package:confession/exam/domain/usecases/get_commandments_usecase.dart';
import 'package:confession/exam/presentation/bloc/commandments_bloc.dart';
import 'package:confession/presentation/bloc/user/user_bloc.dart';
import 'package:confession/router/app_router.gr.dart';
import 'package:confession/shared/widgets/app_bar.dart';
import 'package:confession/shared/widgets/confession_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CommandmentsPage extends StatelessWidget {
  const CommandmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommandmentsBloc(getCommandmentsUsecase: sl())
        ..add(BlocEvent(
            argument:
                GetCommandmentsParam(user: context.read<UserBloc>().state),),),
      child: BlocListener<UserBloc, User>(
        listener: (context, state) {
          context
              .read<CommandmentsBloc>()
              .add(BlocEvent(argument: GetCommandmentsParam(user: state)));
        },
        child: const CommandmentsConsumer(),
      ),
    );
  }
}

class CommandmentsConsumer extends StatelessWidget {
  const CommandmentsConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ConfessionAppBar(),
      body: SingleChildScrollView(
        child: BlocBuilder<CommandmentsBloc, BlocState<CommandmentList>>(
          builder: (context, state) => state.mapOrElse(
            orElse: () => const CommandmentsLoadingView(),
            success: (commandments) =>
                CommandmentsLoadedView(commandmentsList: commandments),
            error: () => const CommandmentsErrorView(),
          ),
        ),
      ),
    );
  }
}

class CommandmentsLoadedView extends StatelessWidget {
  const CommandmentsLoadedView({
    required this.commandmentsList,
    super.key,
  });

  final CommandmentList commandmentsList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        const SizedBox(height: 16),
        ...commandmentsList.data.map(
          (commandment) => ConfessionListTile(
            title: commandment.commandment,
            onTap: () {
              context
                  .pushRoute(ExaminationRoute(commandmentId: commandment.id));
            },
            subtitle: commandment.commandmentText.isNotEmpty
                ? commandment.commandmentText
                : null,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class CommandmentsErrorView extends StatelessWidget {
  const CommandmentsErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(height: 200, width: 200, color: Colors.red);
  }
}

class CommandmentsLoadingView extends StatelessWidget {
  const CommandmentsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
