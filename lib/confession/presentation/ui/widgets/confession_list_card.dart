import 'package:confession/confession/presentation/bloc/confession_list_bloc.dart';
import 'package:confession/confession/presentation/ui/widgets/navigation_buttons.dart';
import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/di/service_locator.dart';
import 'package:confession/exam/domain/entities/examination.dart';
import 'package:confession/shared/utils.dart';
import 'package:confession/shared/widgets/confession_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfessionListCard extends StatelessWidget {
  const ConfessionListCard({required this.pageController, super.key});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConfessionListBloc(getExaminationsUsecase: sl())..add(const BlocEvent.noParam()),
      child: BlocBuilder<ConfessionListBloc, BlocState<ExaminationsList>>(
        builder: (context, state) {
          return state.mapOrElse(
            orElse: () => const Center(
              child: CircularProgressIndicator(),
            ),
            success: (examinations) => Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  if (examinations.data.isEmpty)
                    Expanded(
                      child: Center(
                        child: Text(
                          'No data to display\n Please do an Examination of Conscience first',
                          textAlign: TextAlign.center,
                          style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        itemCount: examinations.data.length,
                        itemBuilder: (context, index) {
                          final examination = examinations.data[index];
                          return ConfessionListTile(
                            title: examination.activeText,
                            trailing: Text(
                              examination.count.toString(),
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          );
                        },
                      ),
                    ),
                  NavigationButtons(
                    onNext: () => pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                    nextLabel: 'Next',
                    onBack: () => pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                  ),
                ],
              ),
            ),
            error: () => const Center(
              child: Text('Error'),
            ),
          );
        },
      ),
    );
  }
}
