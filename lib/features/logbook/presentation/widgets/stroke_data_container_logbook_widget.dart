import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/logbook/application/logbook_provider.dart';
import 'package:swimming_app_frontend/features/logbook/application/selected_day_logbook_provider.dart';
import 'package:swimming_app_frontend/features/logbook/domain/models/logbook_state_model.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/stroke_data_logbook_widget.dart';
import 'package:swimming_app_frontend/shared/enum/event_enum.dart';

class StrokeDataContainerLogbookWidget extends ConsumerWidget {
  const StrokeDataContainerLogbookWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final logbookState = ref.watch(logbookProvider);
    final selectedDate = ref.watch(selectedDayLogbookProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'By Events',
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.secondary,
                ),
              ),
              SvgPicture.asset(
                'assets/svg/swimmer_icon.svg',
                width: 25,
                height: 25,
                colorFilter: ColorFilter.mode(
                  colorScheme.secondary,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
        Column(
          spacing: 5,
          children: [..._buildStrokeDataWidgets(logbookState, selectedDate)],
        ),
      ],
    );
  }

  List<Widget> _buildStrokeDataWidgets(
    AsyncValue<LogbookStateModel> logbookState,
    DateTime time,
  ) {
    return logbookState.when(
      data: (data) {
        final dayData = data.getDayData(time.year, time.month, time.day);

        if (dayData == null) {
          return [];
        }

        final List<EventEnum> events = dayData.eventsSwumToday;

        return events.map((event) {
          final averagePerOffPb = dayData.calculateAveragePercentOffPbByEvent(
            event,
          );
          final highestPerOffPb = dayData.calculateHighPercentOffPbByEvent(
            event,
          );
          final lowestPerOffPb = dayData.calculateLowPercentOffPbByEvent(event);

          return StrokeDataLogbookWidget(
            event: event,
            averagePerOffPb: averagePerOffPb,
            highestPerOffPb: highestPerOffPb,
            lowestPerOffPb: lowestPerOffPb,
          );
        }).toList();
      },
      loading: () => [],
      error: (error, stack) => [Text('Error loading stroke data: $error')],
    );
  }
}
