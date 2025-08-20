import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

class MetricButtonWidget extends ConsumerWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color metricColor;
  final bool isEnabled;

  const MetricButtonWidget({
    super.key,
    required this.text,
    this.onPressed,
    this.metricColor = metricBlue,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: isEnabled ? _handleOnPressed : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        alignment: Alignment.center,
        width: 300,
        decoration: BoxDecoration(
          color: isEnabled ? metricColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isEnabled ? metricColor : colorScheme.secondary,
            width: 2,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: AnimatedDefaultTextStyle(
          style: (isEnabled)
              ? textTheme.labelLarge!.copyWith(color: colorScheme.primary)
              : textTheme.labelLarge!.copyWith(color: colorScheme.secondary),
          duration: const Duration(milliseconds: 300),
          child: Text(text),
        ),
      ),
    );
  }

  void _handleOnPressed() {
    if (onPressed != null) {
      onPressed!();
    }
  }

  Color _getSecondary() {
    switch (metricColor) {
      case metricBlue:
        return metricBlueSecondary;
      case metricGreen:
        return metricGreenSecondary;
      case metricRed:
        return metricRedSecondary;
      case metricYellow:
        return metricYellowSecondary;
      case metricPurple:
        return metricPurpleSecondary;
      default:
        return metricBlueSecondary;
    }
  }
}
