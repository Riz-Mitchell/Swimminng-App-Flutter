import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/swims/enum/event_enum.dart';
import 'package:swimming_app_frontend/features/swims/providers/form/add_swim_form.dart';
import 'package:swimming_app_frontend/shared/enum/stroke_enum.dart';

class EventSelectionState {
  final Map<Stroke, bool> selectedStrokes;
  final int selectedDistance;

  EventSelectionState({
    required this.selectedStrokes,
    required this.selectedDistance,
  });

  EventSelectionState copyWith({
    Map<Stroke, bool>? selectedStrokes,
    int? selectedDistance,
  }) {
    return EventSelectionState(
      selectedStrokes: selectedStrokes ?? this.selectedStrokes,
      selectedDistance: selectedDistance ?? this.selectedDistance,
    );
  }
}

class EventSelectionNotifier extends Notifier<EventSelectionState> {
  @override
  EventSelectionState build() {
    final initSelectedStrokesMap = {
      for (var stroke in Stroke.values) stroke: false,
    };
    return EventSelectionState(
      selectedStrokes: initSelectedStrokesMap,
      selectedDistance: 200,
    );
  }

  void toggleStroke(Stroke tappedStroke) {
    state = state.copyWith(
      selectedStrokes: {
        ...state.selectedStrokes,
        tappedStroke: !(state.selectedStrokes[tappedStroke] ?? false),
      },
    );

    if (isValidSelection()) {
      final selectedCount = state.selectedStrokes.values
          .where((selected) => selected)
          .length;

      if (selectedCount == 4) {
        // IM selection
        ref
            .read(addSwimFormProvider.notifier)
            .updateEvent(
              EventEnumExtension.getEventByStrokeAndDistance(
                stroke: null,
                distance: state.selectedDistance,
              ),
            );
      } else if (selectedCount == 1) {
        // Single stroke selection
        ref
            .read(addSwimFormProvider.notifier)
            .updateEvent(
              EventEnumExtension.getEventByStrokeAndDistance(
                stroke: state.selectedStrokes.entries
                    .where((entry) => entry.value)
                    .map((entry) => entry.key)
                    .first,
                distance: state.selectedDistance,
              ),
            );
      }
    }
  }

  bool isSelected(Stroke stroke) => state.selectedStrokes[stroke] ?? false;

  bool isValidSelection() {
    final selectedCount = state.selectedStrokes.values
        .where((selected) => selected)
        .length;
    return selectedCount == 1 || selectedCount == 4;
  }
}

final eventSelectionProvider =
    NotifierProvider<EventSelectionNotifier, EventSelectionState>(
      () => EventSelectionNotifier(),
    );
