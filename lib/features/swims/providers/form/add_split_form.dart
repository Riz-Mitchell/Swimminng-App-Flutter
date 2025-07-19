import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/api/models/split_model.dart';
import 'package:swimming_app_frontend/shared/enum/stroke_enum.dart';

class AddSplitForm extends Notifier<CreateSplitReqDTO> {
  @override
  CreateSplitReqDTO build() {
    return CreateSplitReqDTO(
      stroke: Stroke.freestyle,
      intervalDistance: 0,
      intervalTime: 0.0,
      intervalStrokeCount: null,
      intervalStrokeRate: null,
      dive: true,
    );
  }

  void updateStroke(Stroke stroke) {
    state = state.copyWith(stroke: stroke);
  }

  void updateIntervalDistance(int intervalDistance) {
    state = state.copyWith(intervalDistance: intervalDistance);
  }

  void updateIntervalTime(double intervalTime) {
    state = state.copyWith(intervalTime: intervalTime);
  }

  void updateStrokeCount(int intervalStrokeCount) {
    state = state.copyWith(intervalStrokeCount: intervalStrokeCount);
  }

  void updateStrokeRate(int intervalStrokeRate) {
    state = state.copyWith(intervalStrokeRate: intervalStrokeRate);
  }

  void updateDive(bool dive) {
    state = state.copyWith(dive: dive);
  }
}

final addSplitFormProvider = NotifierProvider<AddSplitForm, CreateSplitReqDTO>(
  () => AddSplitForm(),
);
