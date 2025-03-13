import 'package:auto_route/auto_route.dart';
import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/domain/entities/user.dart';
import 'package:confession/exam/domain/entities/commandment.dart';
import 'package:confession/exam/domain/usecases/get_commandments_usecase.dart';
import 'package:confession/exam/presentation/bloc/commandments_bloc.dart';
import 'package:confession/exam/presentation/bloc/update_examination_bloc.dart';
import 'package:confession/exam/presentation/ui/examination_page/widgets/dots_indcator.dart';
import 'package:confession/exam/presentation/ui/examination_page/widgets/examination_widget.dart';
import 'package:confession/presentation/bloc/user/user_bloc.dart';
import 'package:confession/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ExaminationPage extends StatelessWidget {
  const ExaminationPage({
    @PathParam('commandmentId') required this.commandmentId,
    super.key,
  });

  final int commandmentId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CommandmentsBloc(getCommandmentsUsecase: sl())
            ..add(
              BlocEvent(
                argument: GetCommandmentsParam(
                  user: context.read<UserBloc>().state,
                ),
              ),
            ),
        ),
        BlocProvider(
          create: (context) => UpdateExaminationBloc(
            updateExaminationUsecase: sl(),
            editExaminationUsecase: sl(),
            resetExaminationUsecase: sl(),
            deleteExaminationUsecase: sl(),
          ),
        ),
      ],
      child: BlocListener<UserBloc, User>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          context
              .read<CommandmentsBloc>()
              .add(BlocEvent(argument: GetCommandmentsParam(user: state)));
        },
        child: ExaminationConsumer(initialCommandmentId: commandmentId),
      ),
    );
  }
}

class ExaminationConsumer extends StatelessWidget {
  const ExaminationConsumer({required this.initialCommandmentId, super.key});

  final int initialCommandmentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ConfessionAppBar(),
      body: BlocBuilder<CommandmentsBloc, BlocState<CommandmentList>>(
        builder: (context, state) => state.mapOrElse(
          orElse: () => const ExaminationsLoadingView(),
          success: (commandments) => ExaminationPageView(
            commandmentsList: commandments,
            initialCommandmentId: initialCommandmentId,
          ),
          error: () => const ExaminationsErrorView(),
        ),
      ),
    );
  }
}

class ExaminationPageView extends StatefulWidget {
  const ExaminationPageView({
    required this.commandmentsList,
    required this.initialCommandmentId,
    super.key,
  });

  final CommandmentList commandmentsList;
  final int initialCommandmentId;

  @override
  State<ExaminationPageView> createState() => _ExaminationPageViewState();
}

class _ExaminationPageViewState extends State<ExaminationPageView> {
  late final PageController _pageController;
  late final int initialIndex;

  @override
  void initState() {
    super.initState();
    initialIndex = widget.commandmentsList.data.indexWhere(
      (commandment) => commandment.id == widget.initialCommandmentId,
    );
    _pageController = PageController(initialPage: initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.commandmentsList.data.length,
            itemBuilder: (context, index) => KeepAliveExaminationPage(
              commandment: widget.commandmentsList.data[index],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: DotsIndicator(
                controller: _pageController,
                itemCount: widget.commandmentsList.data.length,
                selectedColor: Theme.of(context).colorScheme.secondary,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
