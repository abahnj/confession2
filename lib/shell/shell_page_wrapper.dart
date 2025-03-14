import 'package:confession/gen/assets.gen.dart';
import 'package:confession/l10n/l10n.dart';
import 'package:confession/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellPageWrapper extends StatelessWidget {
  const ShellPageWrapper({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: _NavigationBar(child: child),
    );
  }
}

class _NavigationBar extends StatelessWidget {
  const _NavigationBar({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).uri.path;
    final currentIndex = _getSelectedIndex(currentLocation);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        // Only navigate if the selected tab is different
        if (index != currentIndex) {
          _onItemTapped(index, context);
        }
      },
      items: _buildNavigationItems(context, currentIndex),
    );
  }

  int _getSelectedIndex(String location) {
    if (location.startsWith('/exam')) {
      return 0;
    } else if (location.startsWith('/confession')) {
      return 1;
    } else if (location.startsWith('/guide')) {
      return 2;
    } else if (location.startsWith('/prayers')) {
      return 3;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/exam');
      case 1:
        context.go('/confession');
      case 2:
        context.go('/guide');
      case 3:
        context.go('/prayers');
    }
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