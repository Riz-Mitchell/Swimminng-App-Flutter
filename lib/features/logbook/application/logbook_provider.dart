import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/logbook/domain/models/logbook_state_model.dart';
import 'package:swimming_app_frontend/features/logbook/domain/models/month_log_model.dart';

class LogbookProvider extends AsyncNotifier<LogbookStateModel> {
  @override
  Future<LogbookStateModel> build() async {
    final now = DateTime.now();
    final year = now.year;
    final month = now.month;

    final thisMonthData = await getMonthData(year, month);

    return LogbookStateModel(months: {'$year-$month': thisMonthData});
  }

  Future<MonthLogModel> getMonthData(int year, int month) async {
    return await Future.value(
      MonthLogModel(
        year: year,
        month: month,
        days: {}, // Initialize with an empty map for days
      ),
    );
  }

  Future<void> updateMonthData(int year, int month) async {
    // collect data for the month and update the state

    final updatedMonthData = await getMonthData(year, month);

    state = AsyncData(
      state.value!.copyWith(
        months: {...state.value!.months, '$year-$month': updatedMonthData},
      ),
    );
  }

  /// When a user adds a swim to the logbook, this method retrieves the current day again and updates the state.
  void reRetrieveDay() {
    final now = DateTime.now();

    updateMonthData(now.year, now.month);
  }
}
