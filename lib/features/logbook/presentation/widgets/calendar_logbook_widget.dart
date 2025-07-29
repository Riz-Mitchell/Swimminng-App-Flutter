import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';
import 'package:table_calendar/table_calendar.dart';

final selectedDayProvider = StateProvider<DateTime?>((ref) {
  return DateTime.now(); // default to today
});

class CalendarLogbookWidget extends ConsumerWidget {
  const CalendarLogbookWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final selectedDay = ref.watch(selectedDayProvider);
    final focusedDay = selectedDay ?? DateTime.now();

    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.now(),
      focusedDay: focusedDay,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: textTheme.bodyLarge!.copyWith(
          color: colorScheme.secondary,
        ),
        weekendStyle: textTheme.bodyLarge!.copyWith(
          color: colorScheme.secondary,
        ),
      ),
      selectedDayPredicate: (day) {
        return isSameDay(selectedDay, day);
      },
      onDaySelected: (selected, focused) {
        ref.read(selectedDayProvider.notifier).state = selected;
      },
      calendarStyle: CalendarStyle(
        outsideTextStyle: TextStyle(color: colorScheme.secondary),
        weekendTextStyle: TextStyle(color: colorScheme.primary),
        withinRangeTextStyle: TextStyle(color: colorScheme.primary),
        todayTextStyle: TextStyle(color: colorScheme.primary),
        todayDecoration: BoxDecoration(
          color: colorScheme.surface,
          shape: BoxShape.circle,
        ),

        selectedDecoration: BoxDecoration(
          color: metricBlue,
          shape: BoxShape.circle,
        ),
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: textTheme.displayLarge!.copyWith(
          color: colorScheme.primary,
        ),
        leftChevronIcon: Icon(Icons.chevron_left, size: 28),
        rightChevronIcon: Icon(Icons.chevron_right, size: 28),
      ),
    );
  }
}
