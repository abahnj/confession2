import 'dart:developer';

import 'package:confession/gen/assets.gen.dart';
import 'package:confession/shared/utils.dart';
import 'package:flutter/material.dart';

class ConfessionListTile extends StatelessWidget {
  const ConfessionListTile({
    required this.title,
    super.key,
    this.onTap,
    this.subtitle,
    this.trailing,
    this.onLongPress,
  });

  final VoidCallback? onTap;
  final void Function(LongPressStartDetails)? onLongPress;
  final String title;
  final String? subtitle;
  final Widget? trailing;

  static const _padding = EdgeInsets.symmetric(horizontal: 20, vertical: 10);
  static const _borderRadius = 16.0;
  static const _iconSize = 24.0;
  static const _arrowSize = 30.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: Theme.of(context).colorScheme.tertiary.withOpacity(.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: GestureDetector(
        onLongPressStart: (details) {
          log('Long press started at ${details.localPosition}');
        },
        child: ListTile(
          onTap: onTap,
          contentPadding: _padding,
          leading: _buildLeadingIcon(context),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle ?? '',
                  overflow: TextOverflow.ellipsis,
                )
              : null,
          trailing: trailing ??
              Icon(
                Icons.keyboard_arrow_right,
                color: theme.iconTheme.color,
                size: _arrowSize,
              ),
        ),
      ),
    );
  }

  Widget _buildLeadingIcon(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Assets.vectors.cross.svg(
          colorFilter: ColorFilter.mode(
            context.colorScheme.primary,
            BlendMode.srcIn,
          ),
          height: _iconSize,
          width: _iconSize,
        ),
      ),
    );
  }
}
