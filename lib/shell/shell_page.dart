import 'package:auto_route/auto_route.dart';
import 'package:confession/gen/assets.gen.dart';
import 'package:confession/gen/fonts.gen.dart';
import 'package:confession/l10n/l10n.dart';
import 'package:confession/router/app_router.gr.dart';
import 'package:confession/shared/utils.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ShellPage extends StatelessWidget {
  ShellPage({super.key});

  final List<NavigationItem> navigationItems = [
    NavigationItem(
      route: const ExaminationRoute(),
      icon: Assets.vectors.exam,
      labelResolver: (context) => context.l10n.examinationNavbarTitle,
    ),
    NavigationItem(
      route: const ConfessionRoute(),
      icon: Assets.vectors.confession,
      labelResolver: (context) => context.l10n.confessionNavbarTitle,
    ),
    NavigationItem(
      route: const GuideRoute(),
      icon: Assets.vectors.guides,
      labelResolver: (context) => context.l10n.guidesNavbarTitle,
    ),
    NavigationItem(
      route: const PrayersRoute(),
      icon: Assets.vectors.prayer,
      labelResolver: (context) => context.l10n.prayersNavbarTitle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: navigationItems.map((item) => item.route).toList(),
      appBarBuilder: (context, tabsRouter) => AppBar(
        title: Text(
          context.topRoute.title(context),
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontFamily: FontFamily.robotoMono),
        ),
        leading: const AutoLeadingButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            onPressed: () => context.pushRoute(const SettingsRoute()),
          ),
        ],
      ),
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: _buildNavigationItems(context, tabsRouter),
        );
      },
    );
  }

  List<BottomNavigationBarItem> _buildNavigationItems(
    BuildContext context,
    TabsRouter tabsRouter,
  ) {
    return navigationItems
        .map(
          (item) => BottomNavigationBarItem(
            icon: _buildIcon(context, item, tabsRouter),
            label: item.labelResolver(context),
          ),
        )
        .toList();
  }

  Widget _buildIcon(
    BuildContext context,
    NavigationItem item,
    TabsRouter tabsRouter,
  ) {
    final index = navigationItems.indexWhere(
      (navItem) => navItem.route == item.route,
    );
    final isActive = tabsRouter.activeIndex == index;

    return item.icon.svg(
      width: 24,
      height: 24,
      colorFilter: ColorFilter.mode(
        isActive
            ? context.colorScheme.primary
            : context.colorScheme.onSurfaceVariant,
        BlendMode.srcIn,
      ),
    );
  }
}

class NavigationItem {
  const NavigationItem({
    required this.route,
    required this.icon,
    required this.labelResolver,
  });

  final PageRouteInfo route;
  final SvgGenImage icon;
  final String Function(BuildContext) labelResolver;
}
