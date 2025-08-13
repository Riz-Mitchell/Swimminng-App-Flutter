import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/log_swim_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/application/selected_event_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/application/selected_event_stroke_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/screens/log_swims_shell_screen.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/header_log_swims_widget.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/stroke_selector_log_swims_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/metric_button_widget.dart';

class StrokeLogSwimsScreen extends ConsumerWidget {
  const StrokeLogSwimsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // Watch to trigger rebuilds
    final selectedEventStroke = ref.watch(selectedEventStrokeLogSwimsProvider);

    return LogSwimsShellScreen(
      child: Column(
        spacing: 40,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeaderLogSwimsWidget(),
          Text(
            'Event Stroke',
            style: textTheme.displaySmall?.copyWith(color: colorScheme.primary),
          ),
          StrokeSelectorLogSwimsWidget(),
          MetricButtonWidget(
            isEnabled: ref
                .read(selectedEventStrokeLogSwimsProvider.notifier)
                .isValidSelection(),
            text: 'Next',
            onPressed: () {
              if (true) {
                ref.read(logSwimProvider.notifier).navigateToNextStep();
              }
            },
          ),
        ],
      ),
    );
  }
}
