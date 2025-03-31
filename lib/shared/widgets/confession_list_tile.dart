import 'package:confession/gen/assets.gen.dart';
import 'package:confession/shared/utils.dart';
import 'package:flutter/material.dart';

class ConfessionListTile extends StatelessWidget {
  const ConfessionListTile({
    required this.title,
    this.isCustom = false,
    super.key,
    this.onTap,
    this.subtitle,
    this.trailing,
    this.onLongPress,
    this.selected = false,
  });

  final VoidCallback? onTap;
  final void Function(LongPressStartDetails)? onLongPress;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final bool isCustom;
  final bool selected;

  static const _padding = EdgeInsets.symmetric(horizontal: 20, vertical: 10);
  static const _borderRadius = 16.0;
  static const _iconSize = 24.0;
  static const _arrowSize = 30.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = selected
        ? Theme.of(context).colorScheme.primaryContainer
        : Theme.of(context).colorScheme.tertiary.withValues(alpha: .2);

    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        side: selected
            ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)
            : BorderSide.none,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: GestureDetector(
        onLongPressStart: onLongPress,
        child: ListTile(
          onTap: onTap,
          contentPadding: _padding,
          leading: _buildLeadingIcon(context),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: selected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle ?? '',
                  overflow: TextOverflow.ellipsis,
                )
              : null,
          trailing: trailing ??
              Icon(
                selected ? Icons.check : Icons.keyboard_arrow_right,
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
        child: SizedBox.square(
          dimension: _iconSize,
          child: Stack(
            children: [
              Assets.vectors.cross.svg(
                colorFilter: ColorFilter.mode(
                  context.colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
              if (isCustom)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.circle,
                    color: context.colorScheme.secondary,
                    size: 8,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
