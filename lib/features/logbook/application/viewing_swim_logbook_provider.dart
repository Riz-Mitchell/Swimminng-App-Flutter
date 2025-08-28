import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/logbook/domain/models/viewing_swim_model.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/swim_entity.dart';

class ViewingSwimLogbookNotifier extends Notifier<ViewingSwimModel> {
  @override
  ViewingSwimModel build() {
    return ViewingSwimModel(swim: null, selectedSplit: null);
  }

  void setSwimAndSplit(GetSwimEntity swim) {
    final swimWithSortedSplits = swim.copyWith(
      splits: List.from(swim.splits)
        ..sort((a, b) => a.intervalDistance.compareTo(b.intervalDistance)),
    );

    print('Setting swim and split in ViewingSwimLogbookNotifier');
    state = state.copyWith(
      swim: swimWithSortedSplits,
      selectedSplit: swimWithSortedSplits.splits.first,
    );
  }

  bool canGoForward() {
    if (state.swim == null || state.selectedSplit == null) {
      print('Returning false for canGoForward due to null state');
      return false;
    }

    if (getSelectedSplitIndex() == state.swim!.splits.length - 1) {
      print('Returning false for canGoForward because at the last split');
      return false;
    } else {
      print('Returning true for canGoForward');
      return true;
    }
  }

  bool canGoBack() {
    if (state.swim == null || state.selectedSplit == null) {
      print('Returning false for canGoBack due to null state');
      return false;
    }

    if (getSelectedSplitIndex() == 0) {
      print('Returning false for canGoBack because at the first split');
      return false;
    } else {
      return true;
    }
  }

  void goForward() {
    if (state.swim == null || state.selectedSplit == null) {
      print('Cannot go forward, swim or selectedSplit is null');
      return;
    }

    if (canGoForward()) {
      final nextSplit = state.swim!.splits[getSelectedSplitIndex() + 1];
      state = state.copyWith(selectedSplit: nextSplit);
    }
  }

  void goBack() {
    if (state.swim == null || state.selectedSplit == null) {
      print('Cannot go back, swim or selectedSplit is null');
      return;
    }

    if (canGoBack()) {
      final previousSplit = state.swim!.splits[getSelectedSplitIndex() - 1];
      state = state.copyWith(selectedSplit: previousSplit);
    }
  }

  int getSelectedSplitIndex() {
    if (state.swim == null || state.selectedSplit == null) {
      return 0;
    }

    return state.swim!.splits.indexOf(state.selectedSplit!);
  }
}

final viewingSwimLogbookProvider =
    NotifierProvider<ViewingSwimLogbookNotifier, ViewingSwimModel>(
      ViewingSwimLogbookNotifier.new,
    );
