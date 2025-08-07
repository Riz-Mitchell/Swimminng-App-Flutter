import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/stroke_enum.dart';

class SelectedEventStrokeLogSwimsProvider
    extends Notifier<Map<StrokeEnum, bool>> {
  @override
  Map<StrokeEnum, bool> build() => {
    StrokeEnum.freestyle: false,
    StrokeEnum.backstroke: false,
    StrokeEnum.breaststroke: false,
    StrokeEnum.butterfly: false,
  };

  void handleTappedStroke(StrokeEnum stroke) {
    state = {
      ...state,
      ...{stroke: !state[stroke]!},
    };
  }

  bool isStrokeSelected(StrokeEnum stroke) {
    return state[stroke] ?? false;
  }

  bool isValidSelection() {
    int selectedCount = state.values.where((v) => v).length;
    return selectedCount == 1 || selectedCount == 4;
  }

  bool isIndividualMedleySelected() {
    int selectedCount = state.values.where((v) => v).length;
    return selectedCount == 4;
  }

  bool isFreestyleSelected() {
    if (!isValidSelection()) {
      return false;
    }

    return state[StrokeEnum.freestyle] ?? false;
  }
}

final selectedEventStrokeLogSwimsProvider =
    NotifierProvider<
      SelectedEventStrokeLogSwimsProvider,
      Map<StrokeEnum, bool>
    >(SelectedEventStrokeLogSwimsProvider.new);
