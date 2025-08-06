import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/status_log_swim_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/models/log_swim_state_model.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';

class LogSwimProvider extends Notifier<LogSwimStateModel> {
  @override
  LogSwimStateModel build() =>
      LogSwimStateModel(status: StatusLogSwimsEnum.selectPoolType);

  void navigateToNextStep() {
    final currentStatus = state.status;
    final nextStatusIndex = currentStatus.index + 1;

    if (nextStatusIndex < StatusLogSwimsEnum.values.length) {
      final nextStatus = StatusLogSwimsEnum.values[nextStatusIndex];
      _updatePageStatus(nextStatus);
      switch (nextStatus) {
        case StatusLogSwimsEnum.selectStroke:
          ref.read(routerProvider).go('/add-swim-stroke');
        case StatusLogSwimsEnum.selectDistance:
          ref.read(routerProvider).go('/add-swim-distance');
        case StatusLogSwimsEnum.addSplits:
          ref.read(routerProvider).go('/add-swim-splits');
        case StatusLogSwimsEnum.completeQuestionnaire:
          ref.read(routerProvider).go('/add-swim-questionnaire');
        case StatusLogSwimsEnum.complete:
          ref.read(routerProvider).go('/add-swim-complete');
        default:
          break;
      }
    } else {
      ref.read(routerProvider).go('/logbook-landing');
    }
  }

  StatusLogSwimsEnum getCurrentPageStatus() {
    return state.status;
  }

  void _updatePageStatus(StatusLogSwimsEnum newStatus) {
    state = state.copyWith(status: newStatus);
  }

  void _reset() {
    state = LogSwimStateModel(status: StatusLogSwimsEnum.selectPoolType);
  }
}

final logSwimProvider = NotifierProvider<LogSwimProvider, LogSwimStateModel>(
  () => LogSwimProvider(),
);
