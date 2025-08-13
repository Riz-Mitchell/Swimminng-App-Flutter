import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/log_swim_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/application/selected_event_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/application/selected_split_distance_index_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/status_log_split_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/models/log_split_state_model.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/splits/stroke_count_input_log_swims_widget.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/splits/stroke_rate_input_log_swims_widget.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/widgets/splits/time_input_log_swims_widget.dart';
import 'package:swimming_app_frontend/features/swims/presentation/widgets/add_split/select_interval_time_widget.dart';

class LogSplitLogSwimsProvider extends Notifier<LogSplitStateModel> {
  @override
  LogSplitStateModel build() {
    final selectedEventState = ref.watch(selectedEventProvider);

    print('LogSplitLogSwimsProvider: $selectedEventState');

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
      reset();
    }
  }

  void navigateToNextStep(
    BuildContext context,
    void Function(BuildContext context, StatusLogSplitEnum nextStep)
    navigateToStep,
  ) {
    final currentStatus = state.status;
    final nextStatusIndex = currentStatus.index + 1;

    print('Current time: ${state.time}');
    print('Current count: ${state.count}');
    print('Current rate: ${state.rate}');
    print('Current distance: ${state.distance}');

    if (nextStatusIndex < StatusLogSplitEnum.values.length) {
      final nextStatus = StatusLogSplitEnum.values[nextStatusIndex];
      _updatePageStatus(nextStatus);
      // Logic to navigate to the next step
      navigateToStep(context, nextStatus);
    } else {
      // Logic to handle the case when there is no next step

      // Add split to the swim model
      ref.read(logSwimProvider.notifier).addSplit(state);
      Navigator.of(context, rootNavigator: true).pop();
      reset();
      return;
    }
  }

  void _updatePageStatus(StatusLogSplitEnum status) {
    state = state.copyWith(status: status);
  }

  void updateRate(int rate) {
    state = state.copyWith(rate: rate);
  }

  void updateCount(int count) {
    state = state.copyWith(count: count);
  }

  void updateDistance(int distance) {
    state = state.copyWith(distance: distance);
  }

  void updateTime(double time) {
    state = state.copyWith(time: time);
  }

  /// Resets all dependent states and resets self
  void reset() {
    ref.invalidate(minuteProvider);
    ref.invalidate(secondsProvider);
    ref.invalidate(hundredthsProvider);
    ref.invalidate(selectedSplitDistanceIndexProvider);
    ref.invalidate(strokeCountProvider);
    ref.invalidate(strokeRateProvider);
    ref.invalidateSelf();
  }
}

final logSplitProvider =
    NotifierProvider<LogSplitLogSwimsProvider, LogSplitStateModel>(
      LogSplitLogSwimsProvider.new,
    );
