import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/selected_event_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/status_log_split_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/models/log_split_state_model.dart';

class LogSplitLogSwimsProvider extends Notifier<LogSplitStateModel> {
  @override
  LogSplitStateModel build() {
    final selectedEventState = ref.watch(selectedEventProvider);

    return LogSplitStateModel(
      event: selectedEventState,
      status: StatusLogSplitEnum.selectDistance,
    );
  }

  void navigateToPrevStep(BuildContext context) {
    final currentStatus = state.status;
    final prevStatusIndex = currentStatus.index - 1;

    if (prevStatusIndex >= 0) {
      final prevStatus = StatusLogSplitEnum.values[prevStatusIndex];
      _updatePageStatus(prevStatus);

      // Pop the current page to go back to the previous step in the modal Navigator
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    } else {
      // No previous step: close modal and reset state
      print('closing modal and resetting state');
      Navigator.of(context, rootNavigator: true).pop();
      // Navigator.of(context).pop();
      _reset();
    }
  }

  void navigateToNextStep(
    BuildContext context,
    void Function(BuildContext context, StatusLogSplitEnum nextStep)
    navigateToStep,
  ) {
    final currentStatus = state.status;
    final nextStatusIndex = currentStatus.index + 1;

    if (nextStatusIndex < StatusLogSplitEnum.values.length) {
      final nextStatus = StatusLogSplitEnum.values[nextStatusIndex];
      _updatePageStatus(nextStatus);
      // Logic to navigate to the next step
      navigateToStep(context, nextStatus);
    } else {
      // Logic to handle the case when there is no next step

      // Add split to the swim model
      Navigator.of(context, rootNavigator: true).pop();
      _reset();
      return;
    }
  }

  void _updatePageStatus(StatusLogSplitEnum status) {
    state = state.copyWith(status: status);
  }

  /// Resets all dependent states and resets self
  void _reset() {
    ref.invalidateSelf();
  }
}

final logSplitProvider =
    NotifierProvider<LogSplitLogSwimsProvider, LogSplitStateModel>(
      LogSplitLogSwimsProvider.new,
    );
