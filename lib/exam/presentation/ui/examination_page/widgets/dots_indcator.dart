import 'dart:math';

import 'package:flutter/material.dart';

/// A customizable animated dots indicator for PageView
class DotsIndicator extends AnimatedWidget {
  const DotsIndicator({
    required this.controller,
    required this.itemCount,
    this.onPageSelected,
    super.key,
    this.color = Colors.white,
    this.selectedColor,
    this.dotSize = 8.0,
    this.maxZoom = 2.0,
    this.dotSpacing = 25.0,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeOut,
  }) : super(listenable: controller);

  final PageController controller;
  final int itemCount;
  final ValueChanged<int>? onPageSelected;
  final Color color;
  final Color? selectedColor;
  final double dotSize;
  final double maxZoom;
  final double dotSpacing;
  final Duration duration;
  final Curve curve;

  Widget _buildDot(BuildContext context, int index) {
    final page = controller.page ?? controller.initialPage.toDouble();
    final selectedness = curve.transform(
      max(
        0,
        1.0 - (page - index).abs(),
      ),
    );
    final zoom = 1.0 + (maxZoom - 1.0) * selectedness;
    final finalColor = Color.lerp(
      color,
      selectedColor ?? color,
      selectedness,
    );

    return Semantics(
      label: 'Page ${index + 1} of $itemCount',
      selected: index == page.round(),
      child: SizedBox(
        width: dotSpacing,
        height: dotSize * maxZoom,
        child: Center(
          child: AnimatedContainer(
            
            duration: duration,
            curve: curve,
            width: dotSize * zoom,
            height: dotSize * zoom,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: finalColor,
            ),
            child: onPageSelected != null
                ? InkWell(
                    onTap: () => onPageSelected?.call(index),
                    customBorder: const CircleBorder(),
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                  )
                : null,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(
          itemCount,
          (index) => _buildDot(context, index),
        ),
      ),
    );
  }
}
