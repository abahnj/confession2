import 'package:flutter/material.dart';

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({
    required this.onNext,
    required this.nextLabel,
    this.onBack,
    this.backLabel = 'Back',
    super.key,
  });

  final VoidCallback onNext;
  final VoidCallback? onBack;
  final String nextLabel;
  final String backLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (onBack != null)
          OutlinedButton.icon(
            onPressed: onBack,
            icon: const Icon(Icons.navigate_before_rounded),
            label: Text(backLabel),
          ),
        OutlinedButton.icon(
          onPressed: onNext,
          icon: const Icon(Icons.navigate_next_rounded),
          label: Text(nextLabel),
        ),
      ],
    );
  }
}
