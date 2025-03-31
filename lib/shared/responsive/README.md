# Responsive Framework

This directory contains components for building responsive UI layouts, with a focus on master-detail patterns for tablets and foldable devices.

## Components

### ResponsiveLayout

A utility class that provides:
- Screen size detection based on breakpoints
- Layout type determination (compact, medium, expanded)
- Responsive builder pattern
- Extension methods for responsive context
- Foldable device detection heuristics

### MasterDetailLayout

A flexible layout component for implementing master-detail views:
- Support for different display modes based on screen size
- Configurable master and detail pane ratios
- Responsive behavior for different form factors
- Integration with navigation system

### MasterDetailController

A state management solution for master-detail views:
- Selection tracking across screens
- State persistence during navigation
- Shared state between master and detail views

## Usage

To implement a responsive feature using this framework:

1. Import the components:
```dart
import 'package:confession/shared/responsive/responsive.dart';
```

2. Create a controller for your feature:
```dart
final controller = MasterDetailController<YourDataType>();
```

3. Wrap your feature in a provider:
```dart
MasterDetailControllerProvider<YourDataType>(
  notifier: controller,
  child: YourFeatureWidget(),
)
```

4. Use the ResponsiveBuilder to adapt to different screen sizes:
```dart
ResponsiveBuilder(
  builder: (context, layoutType) {
    // Return different layouts based on screen size
    if (layoutType == LayoutType.compact) {
      return PhoneLayout();
    } else {
      return TabletLayout();
    }
  },
)
```

5. For master-detail views, use the MasterDetailLayout:
```dart
MasterDetailLayout(
  displayMode: context.idealDisplayMode,
  masterBuilder: (context) => MasterView(),
  detailBuilder: (context) => DetailView(),
)
```

## Best Practices

- Always design for phones first, then adapt to larger screens
- Use the built-in utility methods to determine screen capabilities
- Consider fold states for foldable devices
- Persist state during screen rotations and folding/unfolding
- Test on multiple form factors