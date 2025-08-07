import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/log_swim_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/status_log_swim_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/progress_icon_log_swims_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/return_widget.dart';

class HeaderLogSwimsWidget extends ConsumerWidget {
  final bool donePage;

  const HeaderLogSwimsWidget({super.key, this.donePage = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressBarStatus = ref
        .read(logSwimProvider.notifier)
        .getCurrentPageStatus();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // If done make invisible to go back
        (donePage)
            ? SizedBox(width: 40, height: 40)
            : ReturnWidget(
                onTap: () {
                  ref.read(logSwimProvider.notifier).navigateToPrevStep();
                },
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            ProgressIconLogSwimsWidget(
              status: StatusLogSwimsEnum.selectPoolType,
              completed:
                  progressBarStatus.index >
                  StatusLogSwimsEnum.selectPoolType.index,
              isUsing: progressBarStatus == StatusLogSwimsEnum.selectPoolType,
            ),
            ProgressIconLogSwimsWidget(
              status: StatusLogSwimsEnum.selectStroke,
              completed:
                  progressBarStatus.index >
                  StatusLogSwimsEnum.selectStroke.index,
              isUsing: progressBarStatus == StatusLogSwimsEnum.selectStroke,
            ),
            ProgressIconLogSwimsWidget(
              status: StatusLogSwimsEnum.selectDistance,
              completed:
                  progressBarStatus.index >
                  StatusLogSwimsEnum.selectDistance.index,
              isUsing: progressBarStatus == StatusLogSwimsEnum.selectDistance,
            ),
            ProgressIconLogSwimsWidget(
              status: StatusLogSwimsEnum.addSplits,
              completed:
                  progressBarStatus.index > StatusLogSwimsEnum.addSplits.index,
              isUsing: progressBarStatus == StatusLogSwimsEnum.addSplits,
            ),
            ProgressIconLogSwimsWidget(
              status: StatusLogSwimsEnum.completeQuestionnaire,
              completed:
                  progressBarStatus.index >
                  StatusLogSwimsEnum.completeQuestionnaire.index,
              isUsing:
                  progressBarStatus == StatusLogSwimsEnum.completeQuestionnaire,
            ),
            ProgressIconLogSwimsWidget(
              status: StatusLogSwimsEnum.complete,
              completed:
                  progressBarStatus.index > StatusLogSwimsEnum.complete.index,
              isUsing: progressBarStatus == StatusLogSwimsEnum.complete,
            ),
          ],
        ),
        SizedBox(width: 40, height: 40),
      ],
    );
  }
}
