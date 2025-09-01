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

    final thisMonthData = await _retrieveMonthData(now);

    return LogbookStateModel(
      months: {'${now.year}-${now.month}': thisMonthData},
    );
  }

  Future<MonthLogModel> _retrieveMonthData(DateTime time) async {
    // Retrieve the swims for the specified month and organize them by day
    final List<GetSwimEntity> unsortedMonthSwims = await ref
        .read(swimServiceProvider)
        .getSwimsByMonthAsync(time);

    final Map<int, List<GetSwimEntity>> swimsByDay = {};

    for (final swim in unsortedMonthSwims) {
      final day = swim.recordedAt.day;
      swimsByDay.putIfAbsent(day, () => []).add(swim);
    }

    final Map<int, DayLogModel> days = {};
    swimsByDay.forEach((day, swims) {
      days[day] = DayLogModel(dayOfMonth: day, swims: swims);
    });

    return MonthLogModel(year: time.year, month: time.month, days: days);
  }

  Future<void> _updateMonthData(DateTime time) async {
    // collect data for the month and update the state

    final updatedMonthData = await _retrieveMonthData(time);

    state = AsyncData(
      state.value!.copyWith(
        months: {
          ...state.value!.months,
          '${time.year}-${time.month}': updatedMonthData,
        },
      ),
    );
  }

  Future<DayLogModel> _retrieveDayData(DateTime time) async {
    // Retrieve the specific day data from the service
    final swims = await ref.read(swimServiceProvider).getSwimsByDayAsync(time);

    for (final swim in swims) {
      print(
        'Retrieved swim on ${swim.recordedAt} with ID: ${swim.id} event was ${swim.event} with ${swim.splits.length} splits',
      );
    }

    return DayLogModel(dayOfMonth: time.day, swims: swims);
  }

  Future<void> _updateDayData(DateTime time) async {
    // collect data for the day and update the state
    final updatedDayData = await _retrieveDayData(time);

    final monthKey = '${time.year}-${time.month}';
    final updatedMonth = state.value!.months[monthKey]?.copyWith(
      days: {...state.value!.months[monthKey]!.days, time.day: updatedDayData},
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

    await _updateDayData(now);
  }

  Future<void> checkMonthVisitedAndUpdateData(DateTime time) async {
    final monthKey = '${time.year}-${time.month}';

    if (!state.value!.months.containsKey(monthKey)) {
      print('Month not visited, retrieving data for $monthKey');
      // If the month is not present, retrieve and update it
      await _updateMonthData(time);
    }
  }

  Future<void> handleDeleteSwim(DateTime recordedAt) async {
    await _updateDayData(recordedAt);
  }
}

final logbookProvider =
    AsyncNotifierProvider<LogbookProvider, LogbookStateModel>(
      LogbookProvider.new,
    );
