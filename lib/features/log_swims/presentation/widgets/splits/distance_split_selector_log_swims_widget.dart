import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/log_split_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/application/selected_split_distance_index_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/status_log_split_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/splits/split_modal_header_log_swims_widget.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/splits/split_modal_shell_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/metric_button_widget.dart';

class DistanceSplitSelectorLogSwimsWidget extends ConsumerWidget {
  final void Function(BuildContext context, StatusLogSplitEnum nextStep)
  navigateToStep;

  const DistanceSplitSelectorLogSwimsWidget({
    super.key,
    required this.navigateToStep,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final logSplitState = ref.watch(logSplitProvider);
    final logSplitNotifier = ref.read(logSplitProvider.notifier);

    final selectedDistanceIndex = ref.watch(selectedSplitDistanceIndexProvider);

    final List<int> availableDistances = logSplitState
        .getAvailableSplitDistances();
    // = logSplitState
    //     .getAvailableSplitDistances();

    return SplitModalShellWidget(
      children: [
        SplitModalHeaderLogSwimsWidget(title: 'Split Distance'),
        SizedBox(
          height: 300,
          child: CupertinoPicker(
            itemExtent: 105,
            backgroundColor: Colors.transparent,
            scrollController: FixedExtentScrollController(
              initialItem: selectedDistanceIndex,
            ),
            onSelectedItemChanged: (index) =>
                _onItemChanged(logSplitNotifier, ref, index),
            children: availableDistances.map((distance) {
              return Center(
                child: Text(
                  '${distance}m',
                  style: textTheme.displayLarge?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        MetricButtonWidget(
          text: 'Next',
          isEnabled: true,
          onPressed: () {
            if (true) {
              logSplitNotifier.navigateToNextStep(context, navigateToStep);
            }
          },
        ),
      ],
    );
  }

  void _onItemChanged(
    LogSplitLogSwimsProvider logSplitNotifier,
    WidgetRef ref,
    int index,
  ) {
    ref.read(selectedSplitDistanceIndexProvider.notifier).state = index;
    // logSplitNotifier.selectSplitDistance(availableDistances[index]);
  }
}
