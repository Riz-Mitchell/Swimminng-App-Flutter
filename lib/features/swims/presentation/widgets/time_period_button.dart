import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/swims/enum/time_period_enum.dart';
import 'package:swimming_app_frontend/features/swims/application/providers/swim_graph_provider.dart';

class TimePeriodButton extends ConsumerWidget {
  TimePeriodButton({super.key, required this.timePeriod});

  final TimePeriod timePeriod;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(swimGraphControllerProvider);

    final selectedTimePeriod = state.valueOrNull?.selectedPeriod;
    print('Selected: $selectedTimePeriod, This: $timePeriod');

    Color targetColor = selectedTimePeriod == timePeriod
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;

    return GestureDetector(
      onTap: () async {
        print('yeh');
        print('timePeriod: ${timePeriod}');
        final notifier = ref.read(swimGraphControllerProvider.notifier);
        await notifier.selectTimePeriod(timePeriod);
      },
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 300),
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: targetColor),
        child: Text(_timePeriodLabel(timePeriod)),
      ),
    );
  }

  String _timePeriodLabel(TimePeriod timePeriod) {
    switch (timePeriod) {
      case TimePeriod.week:
        return "W";
      case TimePeriod.month:
        return "M";
      case TimePeriod.threeMonths:
        return "3M";
      case TimePeriod.sixMonths:
        return "6M";
      case TimePeriod.year:
        return "Y";
    }
  }
}
