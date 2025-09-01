import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/logbook/application/logbook_provider.dart';

final lastDate = DateTime.now();
final firstDate = DateTime(2020);

class SelectedDayLogbookNotifier extends Notifier<DateTime> {
  @override
  DateTime build() {
    return DateTime.now();
  }

  Future<void> setSelectedDay(DateTime date) async {
    print('selecting date: $date');
    // Check if the month has been visited and update data if necessary
    await _checkMonthVisited(date);

    state = _validateDate(date: date);
  }

  Future<void> incrementSelectedDay() async {
    DateTime incrementedDate = state.add(Duration(days: 1));

    // Check if the month has been visited and update data if necessary
    await _checkMonthVisited(incrementedDate);

    state = _validateDate(date: incrementedDate);
  }

  Future<void> decrementSelectedDay() async {
    DateTime decrementedDate = state.subtract(Duration(days: 1));

    // Check if the month has been visited and update data if necessary
    await _checkMonthVisited(decrementedDate);

    state = _validateDate(date: decrementedDate);
  }

  void resetSelectedDay() {
    state = DateTime.now();
  }

  DateTime _validateDate({required DateTime date}) {
    if (date.isBefore(firstDate)) return firstDate;
    if (date.isAfter(lastDate)) return lastDate;
    return date;
  }

  Future<void> _checkMonthVisited(DateTime date) async {
    await ref
        .read(logbookProvider.notifier)
        .checkMonthVisitedAndUpdateData(date);
  }
}

final selectedDayLogbookProvider =
    NotifierProvider<SelectedDayLogbookNotifier, DateTime>(
      SelectedDayLogbookNotifier.new,
    );
