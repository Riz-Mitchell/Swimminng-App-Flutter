import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/log_swim_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/selected_pool_type_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/pool_type_button_log_swims_widget.dart';

class PoolTypeSelectorLogSwimsWidget extends ConsumerWidget {
  const PoolTypeSelectorLogSwimsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPoolTypeState = ref.watch(logSwimProvider).poolType;
    final logSwimNotifier = ref.read(logSwimProvider.notifier);

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        PoolTypeButtonLogSwimsWidget(
          type: SelectedPoolTypeEnum.longCourseMeters,
          isSelected:
              selectedPoolTypeState == SelectedPoolTypeEnum.longCourseMeters,
        ),
        PoolTypeButtonLogSwimsWidget(
          type: SelectedPoolTypeEnum.shortCourseMeters,
          isSelected:
              selectedPoolTypeState == SelectedPoolTypeEnum.shortCourseMeters,
        ),
        PoolTypeButtonLogSwimsWidget(
          type: SelectedPoolTypeEnum.shortCourseYards,
          isSelected:
              selectedPoolTypeState == SelectedPoolTypeEnum.shortCourseYards,
        ),
      ],
    );
  }
}
