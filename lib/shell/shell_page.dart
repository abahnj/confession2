import 'package:auto_route/auto_route.dart';
import 'package:confession/router/app_router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ShellPage extends StatelessWidget {
  const ShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      homeIndex: 2,
      routes: const [
        ConfessionRoute(),
        PrayersRoute(),
        ExaminationRoute(),
        GuideRoute(),
      ],
      appBarBuilder: (context, tabsRouter) => AppBar(
        title: Text(
          context.topRoute.name,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontFamily: 'RobotoMono'),
        ),
        leading: const AutoLeadingButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            onPressed: () => throw Exception('Test Crash'),
          ),
        ],
      ),
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(label: 'Books', icon: Icon(Icons.book)),
            BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person)),
            BottomNavigationBarItem(label: 'Settings', icon: Icon(Icons.settings)),
            BottomNavigationBarItem(label: 'More', icon: Icon(Icons.more_horiz)),
          ],
        );
      },
    );
  }
}
