import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/log_split_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/status_log_split_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/splits/split_modal_header_log_swims_widget.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/splits/split_modal_shell_widget.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/splits/stroke_rate_input_log_swims_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/metric_button_widget.dart';

class StrokeRateSplitSelectorLogSwimsWidget extends ConsumerWidget {
  final void Function(BuildContext context, StatusLogSplitEnum nextStep)
  navigateToStep;

  const StrokeRateSplitSelectorLogSwimsWidget({
    super.key,
    required this.navigateToStep,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final logSplitState = ref.watch(logSplitProvider);
    final logSplitNotifier = ref.read(logSplitProvider.notifier);

    return SplitModalShellWidget(
      children: [
        SplitModalHeaderLogSwimsWidget(title: 'Split Stroke Rate'),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.onPrimaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // TimeInputLogSwimsWidget(
              //   timeInputType: TimeInputTypeEnum.minutes,
              //   subscriptText: 'm',
              // ),
              StrokeRateInputLogSwimsWidget(),
            ],
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
