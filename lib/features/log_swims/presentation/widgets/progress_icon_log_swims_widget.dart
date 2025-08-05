import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

class ProgressIconLogSwimsWidget extends ConsumerWidget {
  final bool completed;
  final bool isUsing;

  const ProgressIconLogSwimsWidget({
    super.key,
    required this.completed,
    this.isUsing = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (completed) {
      return Icon(Icons.circle, size: 12, color: metricBlue);
    } else if (isUsing) {
      return Container(
        width: 32,
        height: 32,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: colorScheme.secondary, // Circle border color
            width: 2,
          ),
        ),
        child: SvgPicture.asset(
          'assets/svg/swim_icon.svg',
          width: 25,
          height: 25,
          colorFilter: ColorFilter.mode(colorScheme.secondary, BlendMode.srcIn),
        ),
      );
    } else {
      return Icon(Icons.circle, size: 12, color: colorScheme.secondary);
    }
  }
}
