import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/progress_bar_status_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/progress_icon_log_swims_widget.dart';

class ProgressBarLogSwimsWidget extends ConsumerWidget {
  const ProgressBarLogSwimsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 10,
      children: [
        ProgressIconLogSwimsWidget(
          status: ProgressBarStatusEnum.selectPoolType,
          completed: true,
        ),
        ProgressIconLogSwimsWidget(
          status: ProgressBarStatusEnum.selectStroke,
          completed: false,
          isUsing: true,
        ),
        ProgressIconLogSwimsWidget(
          status: ProgressBarStatusEnum.selectDistance,
          completed: false,
        ),
        ProgressIconLogSwimsWidget(
          status: ProgressBarStatusEnum.addSplits,
          completed: false,
        ),
        ProgressIconLogSwimsWidget(
          status: ProgressBarStatusEnum.completeQuestionnaire,
          completed: false,
        ),
        ProgressIconLogSwimsWidget(
          status: ProgressBarStatusEnum.complete,
          completed: false,
        ),
      ],
    );
  }
}
