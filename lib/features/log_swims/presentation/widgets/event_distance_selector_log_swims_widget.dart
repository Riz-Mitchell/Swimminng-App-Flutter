import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/selected_distance_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/selected_distance_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/distance_button_log_swims_widget.dart';

class EventDistanceSelectorLogSwimsWidget extends ConsumerWidget {
  const EventDistanceSelectorLogSwimsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDistanceState = ref.watch(selectedDistanceLogSwimsProvider);

    final availableDistances = ref
        .read(selectedDistanceLogSwimsProvider.notifier)
        .getAvailableDistances();

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final distance in availableDistances)
          DistanceButtonLogSwimsWidget(
            selectedDistanceEnum: distance,
            isSelected: selectedDistanceState == distance,
          ),
      ],
    );
  }
}
