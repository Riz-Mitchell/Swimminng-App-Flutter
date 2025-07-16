import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/swims/enum/time_period_enum.dart';
import 'package:swimming_app_frontend/features/swims/presentation/widgets/time_period_button.dart';

class TimePeriodGroup extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      spacing: 10,
      children: [
        TimePeriodButton(timePeriod: TimePeriod.week),
        TimePeriodButton(timePeriod: TimePeriod.month),
        TimePeriodButton(timePeriod: TimePeriod.threeMonths),
        TimePeriodButton(timePeriod: TimePeriod.sixMonths),
        TimePeriodButton(timePeriod: TimePeriod.year),
      ],
    );
  }
}
