import 'package:confession/shared/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

/// The display mode for the master-detail layout.
enum MasterDetailDisplayMode {
  /// Only master is visible, detail is pushed as a new screen.
  masterOnly,

  /// Both master and detail are visible side by side.
  masterDetail,
}

/// Configuration for the master-detail layout.
class MasterDetailLayoutConfig {
  /// Creates a master-detail layout configuration.
  const MasterDetailLayoutConfig({
    this.masterFlex = 1,
    this.detailFlex = 3,
    this.backgroundColor,
    this.masterPadding = const EdgeInsets.all(8),
    this.detailPadding = const EdgeInsets.all(16),
    this.showDivider = true,
    this.dividerColor,
    this.dividerThickness = 1.0,
  });

  /// The flex factor for the master pane.
  final int masterFlex;

  /// The flex factor for the detail pane.
  final int detailFlex;

  /// The background color for the layout.
  final Color? backgroundColor;

  /// The padding for the master pane.
  final EdgeInsets masterPadding;

  /// The padding for the detail pane.
  final EdgeInsets detailPadding;

  /// Whether to show a divider between master and detail.
  final bool showDivider;

  /// The color of the divider.
  final Color? dividerColor;

  /// The thickness of the divider.
  final double dividerThickness;
}

/// A master-detail layout widget.
class MasterDetailLayout extends StatelessWidget {
  /// Creates a master-detail layout.
  const MasterDetailLayout({
    required this.masterBuilder,
    required this.detailBuilder,
    required this.displayMode,
    this.config = const MasterDetailLayoutConfig(),
    this.appBar,
    this.backgroundColor,
    this.onBackPressed,
    super.key,
  });

  /// The builder for the master pane.
  final WidgetBuilder masterBuilder;

  /// The builder for the detail pane.
  final WidgetBuilder detailBuilder;

  /// The display mode for the layout.
  final MasterDetailDisplayMode displayMode;

  /// The configuration for the layout.
  final MasterDetailLayoutConfig config;

  /// The app bar for the layout.
  final PreferredSizeWidget? appBar;

  /// The background color for the layout.
  final Color? backgroundColor;

  /// Callback when back button is pressed.
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor ?? config.backgroundColor,
      body: displayMode == MasterDetailDisplayMode.masterOnly
          ? masterBuilder(context)
          : _buildMasterDetailLayout(context),
    );
  }

  /// Builds the master-detail layout.
  Widget _buildMasterDetailLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: config.masterFlex,
          child: Padding(
            padding: config.masterPadding,
            child: masterBuilder(context),
          ),
        ),
        if (config.showDivider)
          VerticalDivider(
            width: config.dividerThickness,
            color: config.dividerColor ?? Theme.of(context).dividerColor,
          ),
        Expanded(
          flex: config.detailFlex,
          child: Padding(
            padding: config.detailPadding,
            child: detailBuilder(context),
          ),
        ),
      ],
    );
  }
}

/// A builder for master-detail layouts based on screen size.
class ResponsiveMasterDetailBuilder extends StatelessWidget {
  /// Creates a responsive master-detail builder.
  const ResponsiveMasterDetailBuilder({
    required this.masterBuilder,
    required this.detailBuilder,
    this.emptyDetailBuilder,
    this.config = const MasterDetailLayoutConfig(),
    this.appBar,
    this.backgroundColor,
    super.key,
  });

  /// The builder for the master pane.
  final WidgetBuilder masterBuilder;

  /// The builder for the detail pane.
  final WidgetBuilder detailBuilder;

  /// The builder for the empty detail pane.
  final WidgetBuilder? emptyDetailBuilder;

  /// The configuration for the layout.
  final MasterDetailLayoutConfig config;

  /// The app bar for the layout.
  final PreferredSizeWidget? appBar;

  /// The background color for the layout.
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, layoutType) {
        final displayMode = layoutType == LayoutType.compact
            ? MasterDetailDisplayMode.masterOnly
            : MasterDetailDisplayMode.masterDetail;

        return MasterDetailLayout(
          displayMode: displayMode,
          masterBuilder: masterBuilder,
          detailBuilder: emptyDetailBuilder ?? detailBuilder,
          config: config,
          appBar: appBar,
          backgroundColor: backgroundColor,
        );
      },
    );
  }
}
