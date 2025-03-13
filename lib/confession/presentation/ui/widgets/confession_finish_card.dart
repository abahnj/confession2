import 'package:auto_route/auto_route.dart';
import 'package:confession/confession/presentation/bloc/examination_of_conscience_bloc.dart';
import 'package:confession/confession/presentation/bloc/finish_confession_bloc.dart';
import 'package:confession/confession/presentation/bloc/random_inspiration_bloc.dart';
import 'package:confession/confession/presentation/ui/widgets/navigation_buttons.dart';
import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/base/view_data.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/prayers/domain/entities/inspiration.dart';
import 'package:confession/prayers/domain/entities/prayer.dart';
import 'package:confession/presentation/bloc/user/user_bloc.dart';
import 'package:confession/router/app_router.gr.dart';
import 'package:confession/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfessionFinishCard extends StatelessWidget {
  const ConfessionFinishCard({required this.pageController, super.key});
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ExaminationOfConscienceBloc(
            getExaminationOfConscienceUsecase: sl(),
          )..add(const BlocEvent.noParam()),
        ),
        BlocProvider<FinishConfessionBloc>(
          create: (context) =>
              FinishConfessionBloc(resetActiveExaminationsUsecase: sl(), getUserUseCase: sl(), saveUserUseCase: sl()),
          lazy: false,
        ),
      ],
      child: Column(
        children: [
          const FinishExaminationCardConsumer(),
          FinishExaminationButtons(pageController: pageController),
        ],
      ),
    );
  }
}

class FinishExaminationCardConsumer extends StatelessWidget {
  const FinishExaminationCardConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExaminationOfConscienceBloc, BlocState<Prayer>>(
      builder: (context, state) {
        return Expanded(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    'Act of Contrition',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              state.mapOrElse(
                                orElse: () => 'Loading...',
                                success: (prayer) => prayer.text,
                                error: () => 'Error',
                              ),
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.titleLarge,
                        children: [
                          const TextSpan(
                            text: 'If the priest says ',
                          ),
                          TextSpan(
                            text: '"Give thanks to the Lord for he is Good" ',
                            style: context.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                              color: context.colorScheme.secondary,
                            ),
                          ),
                          const TextSpan(
                            text: 'answer ',
                          ),
                          TextSpan(
                            text: '"For his mercy endures forever"',
                            style: context.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: context.colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class FinishExaminationButtons extends StatelessWidget {
  const FinishExaminationButtons({
    required this.pageController,
    super.key,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<FinishConfessionBloc, BlocState<EmptyViewData>>(
      listener: (context, state) {
        state.maybeMap(
          success: (_) {
            context.read<UserBloc>().add(const BlocEvent(argument: LoadUser()));
            context.router.push(ShellRoute());
          },
        );
      },
      child: NavigationButtons(
        onBack: () => pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
        onNext: () async {
          await showDialog<void>(
            context: context,
            builder: (context) => BlocProvider(
              create: (context) => RandomInspirationBloc(inspirationUsecase: sl())..add(const BlocEvent.noParam()),
              child: BlocBuilder<RandomInspirationBloc, BlocState<Inspiration>>(
                builder: (context, state) {
                  return state.mapOrElse(
                    orElse: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    success: (inspiration) => AlertDialog(
                      title: Text(inspiration.author),
                      content: Text(inspiration.quote),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                    error: () => const Center(
                      child: Text('Error'),
                    ),
                  );
                },
              ),
            ),
          );

          if (context.mounted) {
            context.read<FinishConfessionBloc>().add(const BlocEvent.noParam());
          }
        },
        nextLabel: 'Finish',
      ),
    );
  }
}
