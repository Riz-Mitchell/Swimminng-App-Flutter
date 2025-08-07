import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/selected_event_stroke_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/selected_distance_enum.dart';

class SelectedDistanceLogSwimsProvider extends Notifier<SelectedDistanceEnum> {
  @override
  SelectedDistanceEnum build() => SelectedDistanceEnum.unselected;

  void selectDistance(SelectedDistanceEnum distance) {
    state = distance;
  }

  List<SelectedDistanceEnum> getAvailableDistances() {
    final selectedStrokeNotifier = ref.read(
      selectedEventStrokeLogSwimsProvider.notifier,
    );

    if (selectedStrokeNotifier.isIndividualMedleySelected()) {
      return [
        SelectedDistanceEnum.twoHundred,
        SelectedDistanceEnum.fourHundred,
      ];
    } else if (selectedStrokeNotifier.isFreestyleSelected()) {
      return [
        SelectedDistanceEnum.fifty,
        SelectedDistanceEnum.oneHundred,
        SelectedDistanceEnum.twoHundred,
        SelectedDistanceEnum.fourHundred,
        SelectedDistanceEnum.eightHundred,
        SelectedDistanceEnum.oneThousandFiveHundred,
      ];
    } else {
      return [SelectedDistanceEnum.oneHundred, SelectedDistanceEnum.twoHundred];
    }
  }
}
