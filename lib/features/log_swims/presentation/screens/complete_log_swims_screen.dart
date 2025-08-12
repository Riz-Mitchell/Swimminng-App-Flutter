import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/log_swim_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/screens/log_swims_shell_screen.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/header_log_swims_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/metric_button_widget.dart';

class CompleteLogSwimsScreen extends ConsumerWidget {
  const CompleteLogSwimsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return LogSwimsShellScreen(
      child: Column(
        spacing: 40,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeaderLogSwimsWidget(donePage: true),
          Text(
            'All Done!',
            style: textTheme.displaySmall?.copyWith(color: colorScheme.primary),
          ),
          MetricButtonWidget(
            text: 'Complete',
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
