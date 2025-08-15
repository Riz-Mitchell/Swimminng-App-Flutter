import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:swimming_app_frontend/features/logbook/application/selected_day_logbook_provider.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/icon_button_widget.dart';

class DateSelectorLogbookWidget extends ConsumerWidget {
  const DateSelectorLogbookWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final selectedDate = ref.watch(selectedDayLogbookProvider);
    final selectedDateNotifier = ref.read(selectedDayLogbookProvider.notifier);

    final backIsActive =
        selectedDate.day != firstDate.day ||
        selectedDate.month != firstDate.month ||
        selectedDate.year != firstDate.year;
    final forwardIsActive =
        selectedDate.day != lastDate.day ||
        selectedDate.month != lastDate.month ||
        selectedDate.year != lastDate.year;

    // print('forwardIsActive: $forwardIsActive');
    // print('backIsActive: $backIsActive');

    return Row(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButtonWidget(
          isActive: backIsActive,
          onTapped: () async =>
              await selectedDateNotifier.decrementSelectedDay(),
          path: 'assets/svg/Return_Icon.svg',
        ),
        GestureDetector(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              builder: (context, child) {
                return Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(colorScheme: colorScheme, textTheme: textTheme),
                  child: child!,
                );
              },
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            );
            if (picked != null && picked != selectedDate) {
              await selectedDateNotifier.setSelectedDay(picked);
            }
          },
          child: SizedBox(
            width: 140,
            child: Center(
              child: Text(
                _customDateFormatter(selectedDate),
                style: textTheme.headlineSmall!.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
        RotatedBox(
          quarterTurns: 2,
          child: IconButtonWidget(
            isActive: forwardIsActive,
            onTapped: () async {
              await selectedDateNotifier.incrementSelectedDay();
            },
            path: 'assets/svg/Return_Icon.svg',
          ),
        ),
      ],
    );
  }

  String _customDateFormatter(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final inputDate = DateTime(date.year, date.month, date.day);

    if (inputDate == today) return "Today";
    if (inputDate == yesterday) return "Yesterday";

    // Get weekday names
    const weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    final weekdayName = weekdays[inputDate.weekday - 1];

    // Check if inputDate is in the current week
    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    // if (inputDate.isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
    //     inputDate.isBefore(endOfWeek.add(const Duration(days: 1)))) {
    //   return weekdayName;
    // }

    if (date.year != now.year) {
      return "$weekdayName. ${DateFormat('MMM dd, yyyy').format(date)}";
    } else {
      return "$weekdayName. ${DateFormat('MMM dd').format(date)}";
    }
  }
}
