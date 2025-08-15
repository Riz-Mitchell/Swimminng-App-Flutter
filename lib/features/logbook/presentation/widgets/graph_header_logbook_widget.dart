import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/logbook/application/logbook_provider.dart';
import 'package:swimming_app_frontend/features/logbook/application/selected_day_logbook_provider.dart';
import 'package:swimming_app_frontend/features/logbook/domain/models/logbook_state_model.dart';

class GraphHeaderLogbookWidget extends ConsumerWidget {
  const GraphHeaderLogbookWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final logbookState = ref.watch(logbookProvider);

    // Replace with current date being looked at
    final selectedDate = ref.watch(selectedDayLogbookProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _getAverageString(logbookState, selectedDate),
              style: textTheme.displayMedium!.copyWith(
                color: colorScheme.primary,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 25),
              child: Text(
                'Off Pb Pace',
                style: textTheme.bodyMedium!.copyWith(
                  color: colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
        Divider(color: colorScheme.secondary),
        Container(
          margin: EdgeInsets.only(right: 25),
          child: Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Worst:',
                    style: textTheme.bodyMedium!.copyWith(
                      color: colorScheme.secondary,
                    ),
                  ),
                  Text(
                    'Best:',
                    style: textTheme.bodyMedium!.copyWith(
                      color: colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _getHighString(logbookState, selectedDate),
                    style: textTheme.headlineSmall!.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  Text(
                    _getLowString(logbookState, selectedDate),
                    style: textTheme.headlineSmall!.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getHighString(
    AsyncValue<LogbookStateModel> logbookState,
    DateTime time,
  ) {
    return logbookState.when(
      data: (data) {
        final dayData = data.getDayData(time.year, time.month, time.day);

        if (dayData != null) {
          return (dayData.highPercentOffPb != null)
              ? '${dayData.highPercentOffPb!.toStringAsFixed(2)}%'
              : '-';
        } else {
          return '-';
        }
      },
      loading: () => 'Loading...',
      error: (error, stack) => 'err',
    );
  }

  String _getLowString(
    AsyncValue<LogbookStateModel> logbookState,
    DateTime time,
  ) {
    return logbookState.when(
      data: (data) {
        final dayData = data.getDayData(time.year, time.month, time.day);

        if (dayData != null) {
          return (dayData.lowPercentOffPb != null)
              ? '${dayData.lowPercentOffPb!.toStringAsFixed(2)}%'
              : '-';
        } else {
          return '-';
        }
      },
      loading: () => 'Loading...',
      error: (error, stack) => 'err',
    );
  }

  String _getAverageString(
    AsyncValue<LogbookStateModel> logbookState,
    DateTime time,
  ) {
    return logbookState.when(
      data: (data) {
        final dayData = data.getDayData(time.year, time.month, time.day);

        if (dayData != null) {
          return (dayData.avPercentOffPb != null)
              ? '${dayData.avPercentOffPb!.toStringAsFixed(2)}%'
              : '-';
        } else {
          return '-';
        }
      },
      loading: () => 'Loading...',
      error: (error, stack) => 'err',
    );
  }
}
