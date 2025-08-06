import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/selected_pool_type_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/pool_type_button_log_swims_widget.dart';

class PoolTypeSelectorLogSwimsWidget extends ConsumerWidget {
  const PoolTypeSelectorLogSwimsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PoolTypeButtonLogSwimsWidget(
          type: SelectedPoolTypeEnum.longCourseMeters,
        ),
        PoolTypeButtonLogSwimsWidget(
          type: SelectedPoolTypeEnum.shortCourseMeters,
        ),
        PoolTypeButtonLogSwimsWidget(
          type: SelectedPoolTypeEnum.shortCourseYards,
        ),
      ],
    );
  }
}
