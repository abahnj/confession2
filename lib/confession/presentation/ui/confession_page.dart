import 'package:auto_route/auto_route.dart';
import 'package:confession/confession/presentation/ui/widgets/confession_finish_card.dart';
import 'package:confession/confession/presentation/ui/widgets/confession_list_card.dart';
import 'package:confession/confession/presentation/ui/widgets/confession_prep_card.dart';
import 'package:confession/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ConfessionPage extends StatefulWidget {
  const ConfessionPage({super.key});

  @override
  State<ConfessionPage> createState() => _ConfessionPageState();
}

class _ConfessionPageState extends State<ConfessionPage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ConfessionAppBar(),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          ConfessionPrepCard(pageController: _pageController),
          ConfessionListCard(pageController: _pageController),
          ConfessionFinishCard(pageController: _pageController),
        ],
      ),
    );
  }
}
