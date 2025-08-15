import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/logbook/domain/models/day_log_model.dart';
import 'package:swimming_app_frontend/features/logbook/domain/models/logbook_state_model.dart';
import 'package:swimming_app_frontend/features/logbook/domain/models/month_log_model.dart';
import 'package:swimming_app_frontend/providers/swim_service_provider.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/swim_entity.dart';

class LogbookProvider extends AsyncNotifier<LogbookStateModel> {
  @override
  Future<LogbookStateModel> build() async {
    final now = DateTime.now();
    final year = now.year;
    final month = now.month;

    final thisMonthData = await _retrieveMonthData(year, month);

    return LogbookStateModel(months: {'$year-$month': thisMonthData});
  }

  Future<MonthLogModel> _retrieveMonthData(int year, int month) async {
    // Retrieve the swims for the specified month and organize them by day
    final List<GetSwimEntity> unsortedMonthSwims = await ref
        .read(swimServiceProvider)
        .getSwimsByMonthAsync(year, month);

    final Map<int, List<GetSwimEntity>> swimsByDay = {};

    for (final swim in unsortedMonthSwims) {
      final day = swim.recordedAt.day;
      swimsByDay.putIfAbsent(day, () => []).add(swim);
    }

    final Map<int, DayLogModel> days = {};
    swimsByDay.forEach((day, swims) {
      days[day] = DayLogModel(dayOfMonth: day, swims: swims);
    });

    return MonthLogModel(year: year, month: month, days: days);
  }

  Future<void> _updateMonthData(int year, int month) async {
    // collect data for the month and update the state

    final updatedMonthData = await _retrieveMonthData(year, month);

    state = AsyncData(
      state.value!.copyWith(
        months: {...state.value!.months, '$year-$month': updatedMonthData},
      ),
    );
  }

  Future<DayLogModel> _retrieveDayData(int year, int month, int day) async {
    // Retrieve the specific day data from the service
    final swims = await ref
        .read(swimServiceProvider)
        .getSwimsByQuery(QuerySwimEntity(year: year, month: month, day: day));

    return DayLogModel(dayOfMonth: day, swims: swims);
  }

  Future<void> _updateDayData(int year, int month, int day) async {
    // collect data for the day and update the state
    final updatedDayData = await _retrieveDayData(year, month, day);

    final monthKey = '$year-$month';
    final updatedMonth = state.value!.months[monthKey]?.copyWith(
      days: {...state.value!.months[monthKey]!.days, day: updatedDayData},
    );

    if (updatedMonth != null) {
      state = AsyncData(
        state.value!.copyWith(
          months: {...state.value!.months, monthKey: updatedMonth},
        ),
      );
    }
  }

  /// When a user adds a swim to the logbook, this method retrieves the current day again and updates the state.
  Future<void> reRetrieveToday() async {
    print('running reRetrieveToday');
    final now = DateTime.now();

    await _updateDayData(now.year, now.month, now.day);
  }

  Future<void> checkMonthVisitedAndUpdateData(int year, int month) async {
    final monthKey = '$year-$month';

    if (!state.value!.months.containsKey(monthKey)) {
      print('Month not visited, retrieving data for $monthKey');
      // If the month is not present, retrieve and update it
      await _updateMonthData(year, month);
    }
  }
}

final logbookProvider =
    AsyncNotifierProvider<LogbookProvider, LogbookStateModel>(
      LogbookProvider.new,
    );
