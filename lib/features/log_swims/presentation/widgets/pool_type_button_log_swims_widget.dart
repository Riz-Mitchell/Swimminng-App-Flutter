import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/pool_type_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/selected_pool_type_enum.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

class PoolTypeButtonLogSwimsWidget extends ConsumerWidget {
  final SelectedPoolTypeEnum type;

  final Duration animationDuration = const Duration(milliseconds: 500);

  const PoolTypeButtonLogSwimsWidget({super.key, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    final selectedPoolType = ref.watch(selectedPoolTypeProvider);

    final isSelected = selectedPoolType == type;

    return GestureDetector(
      onTap: () {
        ref.read(selectedPoolTypeProvider.notifier).state = type;
      },
      child: AnimatedContainer(
        width: isSelected ? screenWidth : screenWidth * 0.8,
        duration: animationDuration,
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? metricBlue : colorScheme.secondary,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            AnimatedDefaultTextStyle(
              duration: animationDuration,
              curve: Curves.easeInOut,
              style: textTheme.displaySmall!.copyWith(
                color: isSelected ? metricBlue : colorScheme.secondary,
              ),
              child: Text(_getReadableTitle(), textAlign: TextAlign.center),
            ),
            AnimatedDefaultTextStyle(
              duration: animationDuration,
              curve: Curves.easeInOut,
              style: textTheme.bodyMedium!.copyWith(
                color: isSelected ? metricBlue : colorScheme.secondary,
              ),
              child: Text(_getReadableSubtext(), textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }

  String _getReadableSubtext() {
    switch (type) {
      case SelectedPoolTypeEnum.shortCourseMeters:
        return 'Short Course Meters';
      case SelectedPoolTypeEnum.longCourseMeters:
        return 'Long Course Meters';
      case SelectedPoolTypeEnum.shortCourseYards:
        return 'Short Course Yards';
      case SelectedPoolTypeEnum.unselected:
        return 'Unselected';
    }
  }

  String _getReadableTitle() {
    switch (type) {
      case SelectedPoolTypeEnum.shortCourseMeters:
        return 'SCM';
      case SelectedPoolTypeEnum.longCourseMeters:
        return 'LCM';
      case SelectedPoolTypeEnum.shortCourseYards:
        return 'SCY';
      case SelectedPoolTypeEnum.unselected:
        return 'Unselected';
    }
  }
}
