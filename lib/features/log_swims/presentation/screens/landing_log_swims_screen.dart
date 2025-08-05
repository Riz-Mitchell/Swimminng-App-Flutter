import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/screens/log_swims_shell_screen.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/progress_bar_log_swims_widget.dart';

class LandingLogSwimsScreen extends ConsumerWidget {
  const LandingLogSwimsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LogSwimsShellScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: ProgressBarLogSwimsWidget(),
          ),
        ],
      ),
    );
  }
}
