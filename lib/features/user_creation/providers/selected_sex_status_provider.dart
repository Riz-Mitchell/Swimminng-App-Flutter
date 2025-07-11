import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/api/models/user_model.dart';

enum SelectedSexStatus { unselected, male, female }

class SelectedSexStatusNotifier extends Notifier<SelectedSexStatus> {
  @override
  SelectedSexStatus build() => SelectedSexStatus.unselected;

  void selectMan() {
    if (state != SelectedSexStatus.male) {
      state = SelectedSexStatus.male;
    } else {
      state = SelectedSexStatus.unselected;
    }
  }

  void selectWoman() {
    if (state != SelectedSexStatus.female) {
      state = SelectedSexStatus.female;
    } else {
      state = SelectedSexStatus.unselected;
    }
  }

  void select(SelectedSexStatus selected, SelectedSexStatus curr) {
    if (curr == selected) {
      state = SelectedSexStatus.unselected;
    } else if (selected == SelectedSexStatus.male) {
      state = SelectedSexStatus.male;
    } else {
      state = SelectedSexStatus.female;
    }
  }
}

final selectedSexStatusProvider =
    NotifierProvider<SelectedSexStatusNotifier, SelectedSexStatus>(
      () => SelectedSexStatusNotifier(),
    );
