import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/log_split_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/application/split_time_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/status_log_split_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/time_input_type_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/splits/split_modal_header_log_swims_widget.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/splits/split_modal_shell_widget.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/splits/time_input_log_swims_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/metric_button_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/return_widget.dart';

class TimeSplitSelectorLogSwimsWidget extends ConsumerWidget {
  final void Function(BuildContext context, StatusLogSplitEnum nextStep)
  navigateToStep;

  const TimeSplitSelectorLogSwimsWidget({
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
        SplitModalHeaderLogSwimsWidget(title: 'Split Time'),
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
              TimeInputLogSwimsWidget(
                timeInputType: TimeInputTypeEnum.seconds,
                subscriptText: '.',
              ),

              TimeInputLogSwimsWidget(
                timeInputType: TimeInputTypeEnum.hundredths,
                subscriptText: 's',
              ),
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

  void onChanged(String value, WidgetRef ref) {
    if (value.isEmpty) {
      ref.read(splitTimeLogSwimsProvider.notifier).state = '';
      return;
    }

    // Remove any existing dots to handle clean insertion
    String digitsOnly = value.replaceAll('.', '');

    if (digitsOnly.length > 2) {
      // Insert dot before last 2 digits
      final int len = digitsOnly.length;
      final newValue =
          digitsOnly.substring(0, len - 2) +
          '.' +
          digitsOnly.substring(len - 2);

      // Try parse and clamp value
      final parsed = double.tryParse(newValue);
      if (parsed != null && parsed >= 0 && parsed <= 59.99) {
        ref.read(splitTimeLogSwimsProvider.notifier).state = newValue;
      }
    } else {
      // Just accept as is if <= 2 digits (like '5' or '59')
      ref.read(splitTimeLogSwimsProvider.notifier).state = value;
    }
  }
}
