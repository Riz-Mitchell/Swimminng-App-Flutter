import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AddSplitStatus {
  selectDistance,
  selectTime,
  selectStrokeRate,
  selectStrokeCount,
}

class AddSplitNavigationController extends AutoDisposeNotifier<AddSplitStatus> {
  @override
  AddSplitStatus build() => AddSplitStatus.selectDistance;

  bool nextStep() {
    switch (state) {
      case AddSplitStatus.selectDistance:
        state = AddSplitStatus.selectTime;
        return false;
      case AddSplitStatus.selectTime:
        state = AddSplitStatus.selectStrokeRate;
        return false;
      case AddSplitStatus.selectStrokeRate:
        state = AddSplitStatus.selectStrokeCount;
        return false;
      case AddSplitStatus.selectStrokeCount:
        return true; // Signals to widget to close
    }
  }

  bool backStep() {
    switch (state) {
      case AddSplitStatus.selectDistance:
        return true; // Pop modal from first screen
      case AddSplitStatus.selectTime:
        state = AddSplitStatus.selectDistance;
        return false;
      case AddSplitStatus.selectStrokeRate:
        state = AddSplitStatus.selectTime;
        return false;
      case AddSplitStatus.selectStrokeCount:
        state = AddSplitStatus.selectStrokeRate;
        return false;
    }
  }
}

final addSplitNavigationProvider =
    AutoDisposeNotifierProvider<AddSplitNavigationController, AddSplitStatus>(
      () => AddSplitNavigationController(),
    );
