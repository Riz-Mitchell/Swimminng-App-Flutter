import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/log_swim_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/selected_pool_type_enum.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

class PoolTypeButtonLogSwimsWidget extends ConsumerWidget {
  final SelectedPoolTypeEnum type;
  final bool isSelected;

  const PoolTypeButtonLogSwimsWidget({
    super.key,
    this.isSelected = false,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final currColor = isSelected ? metricBlue : colorScheme.secondary;

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
          child: Text(_getReadableTitle()),
        ),
      ),
    );
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

  void _handleOnTap(WidgetRef ref) {
    ref.read(logSwimProvider.notifier).updatePoolType(type);
  }
}
