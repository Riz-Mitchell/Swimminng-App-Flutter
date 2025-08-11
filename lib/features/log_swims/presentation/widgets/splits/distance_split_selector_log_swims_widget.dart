import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/log_split_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/status_log_split_enum.dart';
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

    return Column(
      spacing: 40,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Split Distance',
          style: textTheme.headlineLarge?.copyWith(
            color: colorScheme.onPrimary,
          ),
        ),
        MetricButtonWidget(
          text: 'Next',
          isEnabled: true,
          onPressed: () {
            if (true) {
              ref
                  .read(logSplitProvider.notifier)
                  .navigateToNextStep(context, navigateToStep);
            }
          },
        ),
      ],
    );
  }
}
