import 'package:confession/shared/responsive/master_detail_layout.dart';
import 'package:flutter/material.dart';

/// Defines the breakpoints for different screen sizes.
class ResponsiveBreakpoints {
  /// Prevent instantiation
  const ResponsiveBreakpoints._();

  /// The width threshold for compact to medium layouts
  static const double compactMedium = 600;

  /// The width threshold for medium to expanded layouts
  static const double mediumExpanded = 840;
}

/// The type of layout based on screen size.
enum LayoutType {
  /// Compact layout for phones
  compact,

  /// Medium layout for small tablets and foldables
  medium,

  /// Expanded layout for large tablets
  expanded,
}

/// Utility class for responsive layouts.
class ResponsiveLayout {
  /// Gets the [LayoutType] based on the current screen width.
  static LayoutType getLayoutTypeOf(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width >= ResponsiveBreakpoints.mediumExpanded) {
      return LayoutType.expanded;
    } else if (width >= ResponsiveBreakpoints.compactMedium) {
      return LayoutType.medium;
    } else {
      return LayoutType.compact;
    }
  }

  /// Checks if the current layout is compact.
  static bool isCompact(BuildContext context) => 
      getLayoutTypeOf(context) == LayoutType.compact;

  /// Checks if the current layout is medium.
  static bool isMedium(BuildContext context) => 
      getLayoutTypeOf(context) == LayoutType.medium;

  /// Checks if the current layout is expanded.
  static bool isExpanded(BuildContext context) => 
      getLayoutTypeOf(context) == LayoutType.expanded;

  /// Checks if the current layout can show a master-detail view.
  static bool canShowMasterDetail(BuildContext context) => 
      !isCompact(context);
      
  /// Checks if the device is potentially a foldable device based on aspect ratio.
  /// 
  /// Note: This is a simple heuristic and isn't a replacement for the Foldable API,
  /// but it can help identify potential foldable devices until the API is more widely available.
  static bool mightBeFoldable(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final aspectRatio = size.width / size.height;
    
    // Many foldable devices in the unfolded state have unusual aspect ratios
    // This is a simple heuristic that works for common foldables
    return aspectRatio > 1.0 && aspectRatio < 1.5;
  }
  
  /// Returns the ideal display mode for the current device.
  /// 
  /// This considers both screen size and potential foldable status.
  static MasterDetailDisplayMode getIdealDisplayMode(BuildContext context) {
    if (isCompact(context)) {
      return MasterDetailDisplayMode.masterOnly;
    } else {
      return MasterDetailDisplayMode.masterDetail;
    }
  }
}

/// A builder widget that responds to different layout types.
class ResponsiveBuilder extends StatelessWidget {
  /// Creates a responsive builder.
  const ResponsiveBuilder({
    required this.builder,
    super.key,
  });

  /// The builder function that takes a context and layout type.
  final Widget Function(BuildContext context, LayoutType layoutType) builder;

  @override
  Widget build(BuildContext context) {
    return builder(context, ResponsiveLayout.getLayoutTypeOf(context));
  }
}

/// Extension methods for responsive layouts.
extension ResponsiveExtension on BuildContext {
  /// The current layout type.
  LayoutType get layoutType => ResponsiveLayout.getLayoutTypeOf(this);

  /// Whether the current layout is compact.
  bool get isCompact => ResponsiveLayout.isCompact(this);

  /// Whether the current layout is medium.
  bool get isMedium => ResponsiveLayout.isMedium(this);

  /// Whether the current layout is expanded.
  bool get isExpanded => ResponsiveLayout.isExpanded(this);

  /// Whether the current layout can show a master-detail view.
  bool get canShowMasterDetail => ResponsiveLayout.canShowMasterDetail(this);
  
  /// Whether the device might be a foldable based on heuristics.
  bool get mightBeFoldable => ResponsiveLayout.mightBeFoldable(this);
  
  /// The ideal display mode for master-detail based on device characteristics.
  MasterDetailDisplayMode get idealDisplayMode => 
      ResponsiveLayout.getIdealDisplayMode(this);
}
