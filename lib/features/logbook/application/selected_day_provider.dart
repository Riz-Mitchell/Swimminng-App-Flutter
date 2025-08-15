import 'package:flutter_riverpod/flutter_riverpod.dart';

final lastDate = DateTime.now();
final firstDate = DateTime(2020);

class SelectedDayLogbookNotifier extends Notifier<DateTime> {
  @override
  DateTime build() {
    return DateTime.now();
  }

  void setSelectedDay(DateTime date) {
    state = _validateDate(date: date);
  }

  void incrementSelectedDay() {
    DateTime incrementedDate = state.add(Duration(days: 1));
    state = _validateDate(date: incrementedDate);
  }

  void decrementSelectedDay() {
    DateTime decrementedDate = state.add(Duration(days: 1));
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
}

final selectedDayLogbookProvider =
    NotifierProvider<SelectedDayLogbookNotifier, DateTime>(
      SelectedDayLogbookNotifier.new,
    );
