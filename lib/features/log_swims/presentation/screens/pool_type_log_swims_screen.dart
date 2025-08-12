import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/log_swim_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/application/pool_type_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/selected_pool_type_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/screens/log_swims_shell_screen.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/pool_type_selector_log_swims_widget.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/header_log_swims_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/metric_button_widget.dart';

class PoolTypeLogSwimsScreen extends ConsumerWidget {
  const PoolTypeLogSwimsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final selectedPoolType = ref.watch(selectedPoolTypeProvider);

    final isNextEnabled = selectedPoolType != SelectedPoolTypeEnum.unselected;

    return LogSwimsShellScreen(
      child: Column(
        spacing: 40,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeaderLogSwimsWidget(),

          Text(
            'Pool Type?',
            style: textTheme.displaySmall?.copyWith(color: colorScheme.primary),
          ),
          PoolTypeSelectorLogSwimsWidget(),
          MetricButtonWidget(
            text: 'Next',
            isEnabled: isNextEnabled,
            onPressed: () {
              if (isNextEnabled) {
                ref.read(logSwimProvider.notifier).navigateToNextStep();
              }
            },
          ),
        ],
      ),
    );
  }
}
