import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/log_swim_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/screens/log_swims_shell_screen.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/header_log_swims_widget.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/splits/split_card_log_swims_widget.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/splits/split_modal_log_swims_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/metric_button_widget.dart';

class SplitsLogSwimsScreen extends ConsumerWidget {
  const SplitsLogSwimsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final currentSplits = ref.watch(logSwimProvider).splits;

    return LogSwimsShellScreen(
      child: Column(
        spacing: 40,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeaderLogSwimsWidget(),
          Text(
            'Add Your Splits',
            style: textTheme.displaySmall?.copyWith(color: colorScheme.primary),
          ),
          SplitModalLogSwimsWidget(),
          // if (currentSplits.isEmpty)
          //   Container(
          //     decoration: BoxDecoration(
          //       color: colorScheme.surface,
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          //     margin: EdgeInsets.symmetric(horizontal: 40),
          //     child: Text(
          //       textAlign: TextAlign.center,
          //       'Tap the \'+\' button to get started!',
          //       style: textTheme.bodyMedium?.copyWith(
          //         color: colorScheme.secondary,
          //       ),
          //     ),
          //   )
          // else
          ...currentSplits.map(
            (split) => SplitCardLogSwimsWidget(
              distance: split.intervalDistance,
              time: split.intervalTime,
              count: split.intervalStrokeCount,
              rate: split.intervalStrokeRate,
              splitRef: split,
            ),
          ),
          MetricButtonWidget(
            text: (currentSplits.isEmpty)
                ? 'Tap the \'+\' button to get started!'
                : 'Next',
            isEnabled: currentSplits.isNotEmpty,
            onPressed: () async {
              if (true) {
                await ref.read(logSwimProvider.notifier).navigateToNextStep();
              }
            },
          ),
        ],
      ),
    );
  }
}
