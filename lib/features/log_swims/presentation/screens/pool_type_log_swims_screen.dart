import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/pool_type_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/application/progress_bar_status_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/status_log_swim_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/selected_pool_type_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/screens/log_swims_shell_screen.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/pool_type_selector_log_swims_widget.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/header_log_swims_widget.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/metric_button_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/primary_button_widget.dart';

class PoolTypeLogSwimsScreen extends ConsumerWidget {
  const PoolTypeLogSwimsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final selectedPoolType = ref.watch(selectedPoolTypeProvider);

    final isNextEnabled = selectedPoolType != SelectedPoolTypeEnum.unselected;

    final progressBarStatus = ref.read(progressBarStatusLogSwimsProvider);
    final progressBarStatusNotifier = ref.read(
      progressBarStatusLogSwimsProvider.notifier,
    );

    return LogSwimsShellScreen(
      child: Column(
        spacing: 40,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeaderLogSwimsWidget(progressBarStatus: progressBarStatus),
          Column(
            children: [
              Text(
                'Pool Type?',
                style: textTheme.displayMedium?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              Text(
                'Please select the type of pool you swam in.',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.secondary,
                ),
              ),
            ],
          ),
          PoolTypeSelectorLogSwimsWidget(),
          MetricButtonWidget(
            text: 'Next',
            isEnabled: isNextEnabled,
            onPressed: () {
              if (isNextEnabled) {
                progressBarStatusNotifier.state =
                    StatusLogSwimsEnum.selectStroke;

                ref.read(routerProvider).go('/add-swim-stroke');
              }
            },
          ),
        ],
      ),
    );
  }
}
