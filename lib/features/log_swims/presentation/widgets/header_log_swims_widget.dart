import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/progress_bar_status_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/progress_icon_log_swims_widget.dart';
import 'package:swimming_app_frontend/shared/application/nav_direction_provider.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/return_widget.dart';

class HeaderLogSwimsWidget extends ConsumerWidget {
  const HeaderLogSwimsWidget({super.key});

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
              completed: false,
              isUsing: true,
            ),
            ProgressIconLogSwimsWidget(
              status: ProgressBarStatusEnum.selectStroke,
              completed: false,
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
        ),
        SizedBox(width: 40, height: 40),
      ],
    );
  }
}
