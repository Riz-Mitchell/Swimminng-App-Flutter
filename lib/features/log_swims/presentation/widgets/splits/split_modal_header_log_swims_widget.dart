import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/log_split_log_swims_provider.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/return_widget.dart';

class SplitModalHeaderLogSwimsWidget extends ConsumerWidget {
  final String title;

  const SplitModalHeaderLogSwimsWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final logSplitNotifier = ref.read(logSplitProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ReturnWidget(
          onTap: () {
            logSplitNotifier.navigateToPrevStep(context);
          },
          colorOverride: colorScheme.secondary,
        ),
        Text(
          title,
          style: textTheme.headlineLarge?.copyWith(
            color: colorScheme.onPrimary,
          ),
        ),
        SizedBox(width: 40, height: 40),
      ],
    );
  }
}
