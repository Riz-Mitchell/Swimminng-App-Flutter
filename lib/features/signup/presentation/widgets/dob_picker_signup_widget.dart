import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/signup/application/signup_provider.dart';

final selectedDayProvider = StateProvider<int>((ref) => DateTime.now().day);

// Selected month (default 1 = January)
final selectedMonthProvider = StateProvider<int>((ref) => DateTime.now().month);

// Selected year (default 2000)
final selectedYearProvider = StateProvider<int>((ref) => DateTime.now().year);

class DobPickerSignupWidget extends ConsumerWidget {
  const DobPickerSignupWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final selectedDay = ref.watch(selectedDayProvider);
    final selectedMonth = ref.watch(selectedMonthProvider);
    final selectedYear = ref.watch(selectedYearProvider);

    final today = DateTime.now();
    final maxYear = today.year;
    final maxMonth = (selectedYear == maxYear) ? today.month : 12;
    final maxDay = (selectedYear == maxYear && selectedMonth == today.month)
        ? today.day
        : _daysInMonth(selectedYear, selectedMonth);

    final pickerStyle = textTheme.bodyLarge?.copyWith(
      color: colorScheme.onBackground,
    );
    final itemExtent = 40.0;

    return SizedBox(
      height: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 10,
            child: CupertinoPicker(
              itemExtent: 40,
              scrollController: FixedExtentScrollController(
                initialItem: selectedDay - 1,
              ),
              onSelectedItemChanged: (index) async {
                ref.read(selectedDayProvider.notifier).state = index + 1;
                await _updateSelectedDate(ref);
              },
              children: List.generate(
                maxDay,
                (i) => Center(child: Text('${i + 1}', style: pickerStyle)),
              ),
            ),
          ),
          // Month Picker
          Expanded(
            flex: 30,
            child: CupertinoPicker(
              itemExtent: 40,
              scrollController: FixedExtentScrollController(
                initialItem: selectedMonth - 1,
              ),
              onSelectedItemChanged: (index) async {
                ref.read(selectedMonthProvider.notifier).state = index + 1;
                await _updateSelectedDate(ref);
              },
              children: List.generate(
                maxMonth,
                (i) => Center(
                  child: Text('${_monthName(i + 1)}', style: pickerStyle),
                ),
              ),
            ),
          ),
          // Year Picker
          Expanded(
            flex: 15,
            child: CupertinoPicker(
              itemExtent: 40,
              scrollController: FixedExtentScrollController(
                initialItem: selectedYear - 1900, // assume range 1900–2100
              ),
              onSelectedItemChanged: (index) async {
                ref.read(selectedYearProvider.notifier).state = 1900 + index;
                await _updateSelectedDate(ref);
              },
              children: List.generate(
                maxYear - 1900 + 1,
                (i) => Center(child: Text('${1900 + i}', style: pickerStyle)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _daysInMonth(int year, int month) {
    // Create the first day of the next month, then subtract 1 day
    final lastDayOfMonth = (month < 12)
        ? DateTime(year, month + 1, 0)
        : DateTime(year + 1, 1, 0);
    return lastDayOfMonth.day;
  }

  String _monthName(int month) {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return monthNames[month - 1];
  }

  Future<void> _updateSelectedDate(WidgetRef ref) async {
    final selectedDay = ref.read(selectedDayProvider);
    final selectedMonth = ref.read(selectedMonthProvider);
    final selectedYear = ref.read(selectedYearProvider);

    final selectedDate = DateTime(selectedYear, selectedMonth, selectedDay);
    print('Birthdate selected: $selectedDate');
    await ref
        .read(signupProvider.notifier)
        .updateSignupForm(dateOfBirth: selectedDate);
  }
}
