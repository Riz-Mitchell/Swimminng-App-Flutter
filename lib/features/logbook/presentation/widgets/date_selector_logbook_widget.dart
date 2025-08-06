import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/icon_button_widget.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

class DateSelectorLogbookWidget extends ConsumerWidget {
  const DateSelectorLogbookWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final finalDate = DateTime.now();
    final firstDate = DateTime(2010);

    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final selectedDate = ref.watch(selectedDateProvider);

    final backIsActive =
        selectedDate.day != firstDate.day ||
        selectedDate.month != firstDate.month ||
        selectedDate.year != firstDate.year;
    final forwardIsActive =
        selectedDate.day != finalDate.day ||
        selectedDate.month != finalDate.month ||
        selectedDate.year != finalDate.year;

    // print('forwardIsActive: $forwardIsActive');
    // print('backIsActive: $backIsActive');

    return Row(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButtonWidget(
          isActive: backIsActive,
          onTapped: () {
            ref.read(selectedDateProvider.notifier).state = _validateDate(
              date: selectedDate.subtract(Duration(days: 1)),
              firstDate: firstDate,
              lastDate: finalDate,
            );
          },
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
            if (picked != null && picked != selectedDate)
              ref.read(selectedDateProvider.notifier).state = picked;
          },
          child: SizedBox(
            width: 140,
            child: Center(
              child: Text(
                _customDateFormatter(selectedDate),
                style: textTheme.headlineMedium!.copyWith(
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
            onTapped: () {
              ref.read(selectedDateProvider.notifier).state = _validateDate(
                date: selectedDate.add(Duration(days: 1)),
                firstDate: firstDate,
                lastDate: finalDate,
              );
            },
            path: 'assets/svg/Return_Icon.svg',
          ),
        ),
      ],
    );
  }

  DateTime _validateDate({
    required DateTime date,
    required DateTime firstDate,
    required DateTime lastDate,
  }) {
    if (date.isBefore(firstDate)) return firstDate;
    if (date.isAfter(lastDate)) return lastDate;
    return date;
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
