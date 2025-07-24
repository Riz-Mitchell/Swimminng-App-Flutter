import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/swims/domain/models/split_model.dart';
import 'package:swimming_app_frontend/features/swims/enum/event_enum.dart';
import 'package:swimming_app_frontend/features/swims/domain/models/swim_model.dart';

class AddSwimForm extends Notifier<CreateSwimReqDTO> {
  @override
  CreateSwimReqDTO build() {
    return CreateSwimReqDTO(
      event: EventEnum.freestyle50,
      perceivedExertion: null,
      splits: [],
      goalSwim: false,
    );
  }

  void updateEvent(EventEnum event) {
    state = state.copyWith(event: event);
  }

  void updatePercievedExertion(int exertion) {
    state = state.copyWith(perceivedExertion: exertion);
  }

  void addSplit(CreateSplitReqDTO splitSchema) {
    final updatedSplits = [...state.splits, splitSchema];

    updatedSplits.sort(
      (a, b) => b.intervalDistance.compareTo(a.intervalDistance),
    );

    state = state.copyWith(splits: updatedSplits);
  }
}

final addSwimFormProvider = NotifierProvider<AddSwimForm, CreateSwimReqDTO>(
  () => AddSwimForm(),
);
