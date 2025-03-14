import 'package:confession/gen/assets.gen.dart';
import 'package:confession/l10n/l10n.dart';
import 'package:confession/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellPageWrapper extends StatelessWidget {
  const ShellPageWrapper({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _NavigationBar(navigationShell: navigationShell),
    );
  }
}

class _NavigationBar extends StatelessWidget {
  const _NavigationBar({
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: navigationShell.currentIndex,
      onTap: (index) {
        // Only navigate if the selected tab is different
        if (index != navigationShell.currentIndex) {
          navigationShell.goBranch(
            index,
            // This is a root navigation, so we want to initialize the branch
            initialLocation: index == navigationShell.currentIndex,
          );
        }
      },
      items: _buildNavigationItems(context, navigationShell.currentIndex),
    );
  }

  List<BottomNavigationBarItem> _buildNavigationItems(
    BuildContext context, 
    int currentIndex,
  ) {
    return [
      _buildNavigationItem(
        context, 
        Assets.vectors.exam, 
        context.l10n.examinationNavbarTitle,
        currentIndex == 0,
      ),
      _buildNavigationItem(
        context, 
        Assets.vectors.confession, 
        context.l10n.confessionNavbarTitle,
        currentIndex == 1,
      ),
      _buildNavigationItem(
        context, 
        Assets.vectors.guides, 
        context.l10n.guidesNavbarTitle,
        currentIndex == 2,
      ),
      _buildNavigationItem(
        context, 
        Assets.vectors.prayer, 
        context.l10n.prayersNavbarTitle,
        currentIndex == 3,
      ),
    ];
  }

  BottomNavigationBarItem _buildNavigationItem(
    BuildContext context,
    SvgGenImage icon,
    String label,
    bool isActive,
  ) {
    return BottomNavigationBarItem(
      icon: icon.svg(
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
          isActive
              ? context.colorScheme.primary
              : context.colorScheme.onSurfaceVariant,
          BlendMode.srcIn,
        ),
      ),
      label: label,
    );
  }
}