import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/pool_type_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/application/selected_distance_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/selected_distance_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/selected_pool_type_enum.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

class DistanceButtonLogSwimsWidget extends ConsumerWidget {
  final bool isSelected;
  final SelectedDistanceEnum selectedDistanceEnum;

  const DistanceButtonLogSwimsWidget({
    super.key,
    required this.selectedDistanceEnum,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorShcheme = Theme.of(context).colorScheme;

    final colorScheme = Theme.of(context).colorScheme;
    final currColor = isSelected ? metricBlue : colorScheme.secondary;

    final poolTypeState = ref.watch(selectedPoolTypeProvider);

    return GestureDetector(
      onTap: () => _handleOnTap(ref),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: currColor, width: 2),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: textTheme.bodyMedium!.copyWith(color: (currColor)),
          child: Text(_getDistanceText(poolTypeState)),
        ),
      ),
    );
  }

  void _handleOnTap(WidgetRef ref) {
    ref
        .read(selectedDistanceLogSwimsProvider.notifier)
        .selectDistance(selectedDistanceEnum);
  }

  String _getDistanceText(SelectedPoolTypeEnum poolType) {
    String text = '';
    switch (poolType) {
      case SelectedPoolTypeEnum.longCourseMeters:
      case SelectedPoolTypeEnum.shortCourseMeters:
        text = 'm';
        break;
      case SelectedPoolTypeEnum.shortCourseYards:
        text = 'yd';
        break;
      case SelectedPoolTypeEnum.unselected:
        return '';
    }

    switch (selectedDistanceEnum) {
      case SelectedDistanceEnum.unselected:
        return '';
      case SelectedDistanceEnum.fifty:
        return '50$text';
      case SelectedDistanceEnum.oneHundred:
        return '100$text';
      case SelectedDistanceEnum.twoHundred:
        return '200$text';
      case SelectedDistanceEnum.fourHundred:
        return '400$text';
      case SelectedDistanceEnum.eightHundred:
        return '800$text';
      case SelectedDistanceEnum.oneThousandFiveHundred:
        return '1500$text';
    }
  }
}
