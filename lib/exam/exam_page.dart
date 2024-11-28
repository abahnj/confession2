import 'package:auto_route/auto_route.dart';
import 'package:confession/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ExaminationPage extends StatelessWidget {
  const ExaminationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ConfessionAppBar(),
      body: Center(
        child: Text('Exam Page'),
      ),
    );
  }
}
