import 'package:confession/router/nav_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfessionAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ConfessionAppBar({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: FittedBox(
        child: Text(
          title ?? _getAppBarTitle(context),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_rounded),
          onPressed: () => context.push(NavPath.settings.path),
        ),
      ],
    );
  }

  String _getAppBarTitle(BuildContext context) =>
      GoRouterState.of(context).name?.split('/').last.toUpperCase() ?? '';

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
