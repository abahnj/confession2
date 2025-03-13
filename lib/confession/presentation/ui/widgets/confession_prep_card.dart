import 'package:confession/confession/presentation/ui/widgets/navigation_buttons.dart';
import 'package:confession/presentation/bloc/user/user_bloc.dart';
import 'package:confession/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfessionPrepCard extends StatelessWidget {
  const ConfessionPrepCard({required this.pageController, super.key});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final timeAgo = getTimeAgo(context.select((UserBloc userBloc) => userBloc.state.lastConfession));
    return Column(
      children: [
        Expanded(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'In the Name of The Father and The Son and The Holy Spirit',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Amen',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Bless me Father for I have sinned',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Its been $timeAgo since my last confession',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Here are my sins',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'THIS APP IS INTENDED TO BE USED DURING THE SACRAMENT OF '
                    'RECONCILIATION WITH A CATHOLIC PRIEST ONLY. '
                    'THIS IS NOT A SUBSTITUTE FOR A VALID CONFESSION',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        NavigationButtons(
          onNext: () => pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
          nextLabel: 'Next',
        ),
      ],
    );
  }
}
