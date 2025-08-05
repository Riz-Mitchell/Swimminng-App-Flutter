import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/progress_icon_log_swims_widget.dart';

class ProgressBarLogSwimsWidget extends ConsumerWidget {
  const ProgressBarLogSwimsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ProgressIconLogSwimsWidget(completed: true),
        ProgressIconLogSwimsWidget(completed: true),
        ProgressIconLogSwimsWidget(completed: false, isUsing: true),
        ProgressIconLogSwimsWidget(completed: false),
      ],
    );
  }
}
