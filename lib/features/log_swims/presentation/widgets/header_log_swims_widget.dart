import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/progress_bar_status_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/progress_icon_log_swims_widget.dart';
import 'package:swimming_app_frontend/shared/application/nav_direction_provider.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/return_widget.dart';

class HeaderLogSwimsWidget extends ConsumerWidget {
  final ProgressBarStatusEnum progressBarStatus;

  const HeaderLogSwimsWidget({super.key, required this.progressBarStatus});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ReturnWidget(
          onTap: () {
            ref.read(navDirectionProvider.notifier).state =
                NavigationDirection.backward;

            print(
              'navigating to logbook landing with direction: ${ref.read(navDirectionProvider)}',
            );

            ref.read(routerProvider).go('/logbook-landing');
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            ProgressIconLogSwimsWidget(
              status: ProgressBarStatusEnum.selectPoolType,
              completed:
                  progressBarStatus.index >
                  ProgressBarStatusEnum.selectPoolType.index,
              isUsing:
                  progressBarStatus == ProgressBarStatusEnum.selectPoolType,
            ),
            ProgressIconLogSwimsWidget(
              status: ProgressBarStatusEnum.selectStroke,
              completed:
                  progressBarStatus.index >
                  ProgressBarStatusEnum.selectStroke.index,
              isUsing: progressBarStatus == ProgressBarStatusEnum.selectStroke,
            ),
            ProgressIconLogSwimsWidget(
              status: ProgressBarStatusEnum.selectDistance,
              completed:
                  progressBarStatus.index >
                  ProgressBarStatusEnum.selectDistance.index,
              isUsing:
                  progressBarStatus == ProgressBarStatusEnum.selectDistance,
            ),
            ProgressIconLogSwimsWidget(
              status: ProgressBarStatusEnum.addSplits,
              completed:
                  progressBarStatus.index >
                  ProgressBarStatusEnum.addSplits.index,
              isUsing: progressBarStatus == ProgressBarStatusEnum.addSplits,
            ),
            ProgressIconLogSwimsWidget(
              status: ProgressBarStatusEnum.completeQuestionnaire,
              completed:
                  progressBarStatus.index >
                  ProgressBarStatusEnum.completeQuestionnaire.index,
              isUsing:
                  progressBarStatus ==
                  ProgressBarStatusEnum.completeQuestionnaire,
            ),
            ProgressIconLogSwimsWidget(
              status: ProgressBarStatusEnum.complete,
              completed:
                  progressBarStatus.index >
                  ProgressBarStatusEnum.complete.index,
              isUsing: progressBarStatus == ProgressBarStatusEnum.complete,
            ),
          ],
        ),
        SizedBox(width: 40, height: 40),
      ],
    );
  }
}
