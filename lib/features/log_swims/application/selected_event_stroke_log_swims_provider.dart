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
}
