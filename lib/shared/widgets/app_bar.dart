import 'package:auto_route/auto_route.dart';
import 'package:confession/gen/fonts.gen.dart';
import 'package:confession/router/app_router.gr.dart';
import 'package:flutter/material.dart';

class ConfessionAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ConfessionAppBar({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: FittedBox(
        child: Text(
          title ?? context.topRoute.title(context),
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontFamily: FontFamily.robotoMono),
        ),
      ),
      leading: const AutoLeadingButton(),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_rounded),
          onPressed: () => context.pushRoute(const SettingsRoute()),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
