import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/selected_distance_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/distance_button_log_swims_widget.dart';

class EventDistanceSelectorLogSwimsWidget extends ConsumerWidget {
  const EventDistanceSelectorLogSwimsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        DistanceButtonLogSwimsWidget(distanceEnum: DistanceEnum.fifty),
        DistanceButtonLogSwimsWidget(distanceEnum: DistanceEnum.oneHundred),
        DistanceButtonLogSwimsWidget(distanceEnum: DistanceEnum.twoHundred),
        DistanceButtonLogSwimsWidget(distanceEnum: DistanceEnum.fourHundred),
        DistanceButtonLogSwimsWidget(distanceEnum: DistanceEnum.eightHundred),
        DistanceButtonLogSwimsWidget(
          distanceEnum: DistanceEnum.oneThousandFiveHundred,
        ),
      ],
    );
  }
}
