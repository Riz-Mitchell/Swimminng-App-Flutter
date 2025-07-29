import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

class SessionSummarySquadWidget extends ConsumerWidget {
  const SessionSummarySquadWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    final today = DateTime.now();
    final endOfWeek = today.add(
      Duration(days: DateTime.sunday - today.weekday),
    );

    final selectedDate = ref.watch(selectedDateProvider);

    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
      child: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sessions',
                style: textTheme.headlineMedium?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              RotatedBox(
                quarterTurns: 2,
                child: SvgPicture.asset(
                  'assets/svg/Return_Icon.svg',
                  width: 25,
                  height: 25,
                  colorFilter: ColorFilter.mode(
                    colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
          EasyDateTimeLinePicker(
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 14)),
            focusedDate: selectedDate,
            headerOptions: HeaderOptions(headerType: HeaderType.none),
            timelineOptions: TimelineOptions(),
            onDateChange: (date) =>
                ref.read(selectedDateProvider.notifier).state = date,
          ),
        ],
      ),
    );
  }
}
