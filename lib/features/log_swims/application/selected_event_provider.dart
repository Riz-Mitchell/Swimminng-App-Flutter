import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/selected_distance_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/application/selected_event_stroke_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/selected_distance_enum.dart';
import 'package:swimming_app_frontend/shared/enum/stroke_enum.dart';
import 'package:swimming_app_frontend/shared/enum/event_enum.dart';

class SelectedEventNotifier extends Notifier<EventEnum> {
  @override
  EventEnum build() {
    EventEnum event;

    final eventStrokeMap = ref.watch(selectedEventStrokeLogSwimsProvider);
    final eventDistance = ref.watch(selectedDistanceLogSwimsProvider);

    final eventStrokeProvider = ref.read(
      selectedEventStrokeLogSwimsProvider.notifier,
    );

    if (eventStrokeProvider.isValidSelection()) {
      if (eventStrokeProvider.isIndividualMedleySelected()) {
        event = EventEnumExtension.getEventByStrokeAndDistance(
          stroke: null,
          distance: SelectedDistanceEnumExtension.getIntDistanceByEnum(
            eventDistance,
          ),
        );
      } else if (eventStrokeProvider.isFreestyleSelected()) {
        event = EventEnumExtension.getEventByStrokeAndDistance(
          stroke: StrokeEnum.freestyle,
          distance: SelectedDistanceEnumExtension.getIntDistanceByEnum(
            eventDistance,
          ),
        );
      } else {
        // If a valid stroke is selected but not freestyle or IM, return the event based on the selected stroke
        final selectedStroke = eventStrokeMap.keys.firstWhere(
          (stroke) => eventStrokeMap[stroke] == true,
        );
        event = EventEnumExtension.getEventByStrokeAndDistance(
          stroke: selectedStroke,
          distance: SelectedDistanceEnumExtension.getIntDistanceByEnum(
            eventDistance,
          ),
        );
      }
    } else {
      event = EventEnum.none;
    }

    return event;
  }
}

final selectedEventProvider =
    NotifierProvider<SelectedEventNotifier, EventEnum>(
      SelectedEventNotifier.new,
    );
