import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/progress_bar_status_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/screens/log_swims_shell_screen.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/header_log_swims_widget.dart';

class CompleteLogSwimsScreen extends ConsumerWidget {
  const CompleteLogSwimsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final progressBarStatus = ref.read(progressBarStatusLogSwimsProvider);

    return LogSwimsShellScreen(
      child: Column(
        spacing: 50,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeaderLogSwimsWidget(progressBarStatus: progressBarStatus),
          Text(
            'All Done!',
            style: textTheme.displayMedium?.copyWith(
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
