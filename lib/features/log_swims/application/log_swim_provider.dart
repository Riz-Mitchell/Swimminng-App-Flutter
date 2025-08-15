import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/post_swim_questionnaire_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/application/selected_distance_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/application/selected_event_stroke_log_swims_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/questionnaire_options_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/selected_pool_type_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/status_log_swim_enum.dart';
import 'package:swimming_app_frontend/features/logbook/application/logbook_provider.dart';
import 'package:swimming_app_frontend/shared/enum/stroke_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/models/log_split_state_model.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/models/log_swim_state_model.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/models/post_swim_questionnaire_model.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/models/split_model.dart';
import 'package:swimming_app_frontend/providers/swim_service_provider.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';
import 'package:swimming_app_frontend/shared/enum/event_enum.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/split_entity.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/swim_entity.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/swim_questionnaire_entity.dart';

class LogSwimProvider extends Notifier<LogSwimStateModel> {
  @override
  LogSwimStateModel build() {
    return LogSwimStateModel(
      splits: [],
      poolType: SelectedPoolTypeEnum.unselected,
      event: EventEnum.none,
      status: StatusLogSwimsEnum.selectPoolType,
      questionnaire: CreateSwimQuestionnaireModel(),
    );
  }

  void navigateToPrevStep() {
    final currentStatus = state.status;
    final prevStatusIndex = currentStatus.index - 1;

    // Override the attempted change to status if it is complete
    if (currentStatus == StatusLogSwimsEnum.complete) {
      ref.read(routerProvider).go('/logbook-landing');
      _reset();
      return;
    }

    if (prevStatusIndex >= 0) {
      final prevStatus = StatusLogSwimsEnum.values[prevStatusIndex];
      _updatePageStatus(prevStatus);
      switch (prevStatus) {
        case StatusLogSwimsEnum.selectPoolType:
          ref.read(routerProvider).go('/add-swim-landing');
          break;
        case StatusLogSwimsEnum.selectStroke:
          ref.read(routerProvider).go('/add-swim-stroke');
          break;
        case StatusLogSwimsEnum.selectDistance:
          ref.read(routerProvider).go('/add-swim-distance');
          break;
        case StatusLogSwimsEnum.addSplits:
          ref.read(routerProvider).go('/add-swim-splits');
          break;
        case StatusLogSwimsEnum.completeQuestionnaire:
          ref.read(routerProvider).go('/add-swim-questionnaire');
          break;
        default:
          break;
      }
    } else {
      ref.read(routerProvider).go('/logbook-landing');
      _reset();
      return;
    }
  }

  Future<void> navigateToNextStep() async {
    print('\n\n\nNavigating to next step with state:');
    printState();
    print('--------------------------------\n\n\n');
    final currentStatus = state.status;
    final nextStatusIndex = currentStatus.index + 1;

    if (nextStatusIndex < StatusLogSwimsEnum.values.length) {
      final nextStatus = StatusLogSwimsEnum.values[nextStatusIndex];
      _updatePageStatus(nextStatus);
      switch (nextStatus) {
        case StatusLogSwimsEnum.selectStroke:
          ref.read(routerProvider).go('/add-swim-stroke');
          break;
        case StatusLogSwimsEnum.selectDistance:
          ref.read(routerProvider).go('/add-swim-distance');
          break;
        case StatusLogSwimsEnum.addSplits:
          ref.read(routerProvider).go('/add-swim-splits');
          break;
        case StatusLogSwimsEnum.completeQuestionnaire:
          ref.read(routerProvider).go('/add-swim-questionnaire');
          break;
        case StatusLogSwimsEnum.complete:
          await _submitSwimAsync();
          ref.read(routerProvider).go('/add-swim-complete');
          break;
        default:
          break;
      }
    } else {
      await ref.read(logbookProvider.notifier).reRetrieveToday();
      ref.read(routerProvider).go('/logbook-landing');
      _reset();
      return;
    }
  }

  Future<void> _submitSwimAsync() async {
    final questionnaire = SwimQuestionnaireMapper.fromModelToEntity(
      state.questionnaire,
    );

    final swim = CreateSwimEntity(
      event: state.event,
      splits: state.splits
          .map((split) => SplitMapper.fromModelToEntity(split))
          .toList(),
      poolType: state.poolType,
      swimQuestionnaire: questionnaire,
    );
    print('Submitting swim with state:');
    printState();
    print('--------------------------------');

    await ref.read(swimServiceProvider).createSwim(swim);
  }

  StatusLogSwimsEnum getCurrentPageStatus() {
    return state.status;
  }

  void _updatePageStatus(StatusLogSwimsEnum newStatus) {
    state = state.copyWith(status: newStatus);

    print('Updated page status to: $newStatus');
  }

  void _reset() {
    // print('Resting LogSwimProvider');
    // final stackTrace = StackTrace.current;
    // print('Reset called from:\n$stackTrace');
    state = state.copyWith(status: StatusLogSwimsEnum.selectPoolType);
    ref.invalidate(selectedEventStrokeLogSwimsProvider);
    ref.invalidate(selectedDistanceLogSwimsProvider);
    ref.invalidate(postSwimQuestionnaireLogSwimsProvider);
    ref.invalidateSelf();
  }

  void resetSplitsOnEventChange() {
    // Reset splits when event changes
    state = state.copyWith(splits: []);
  }

  void addSplit(LogSplitStateModel splitState) {
    // Add split to the swim model
    if (!splitState.isValid()) {
      return;
    }

    final currentSplits = state.splits;
    final SplitModel newSplit = SplitModel(
      stroke: getDefaultStrokeByEvent(state.event),
      intervalDistance: splitState.distance!,
      intervalTime: splitState.time!,
      intervalStrokeRate: splitState.rate,
      intervalStrokeCount: splitState.count,
    );
    final List<SplitModel> updatedSplits = [...currentSplits, newSplit];
    updatedSplits.sort(
      (a, b) => b.intervalDistance.compareTo(a.intervalDistance),
    );

    state = state.copyWith(splits: updatedSplits);
  }

  void removeSplit(SplitModel split) {
    final currentSplits = state.splits;

    final updatedSplits = List<SplitModel>.from(currentSplits);
    updatedSplits.remove(split);

    updatedSplits.sort(
      (a, b) => b.intervalDistance.compareTo(a.intervalDistance),
    );

    state = state.copyWith(splits: updatedSplits);
  }

  void updatePoolType(SelectedPoolTypeEnum poolType) {
    state = state.copyWith(poolType: poolType);
  }

  void updateEvent(EventEnum event) {
    state = state.copyWith(event: event);
  }

  // Automatically updates the questionnaire when questionnaire is changes
  void updateQuestionnaire() {
    print('Updating questionnaire in LogSwimProvider');
    print('\n\n\nCurrent state before update:');
    printState();
    print('-' * 50 + '\n\n\n');
    print('questionnaire updated');
    final questionnaire = ref.read(postSwimQuestionnaireLogSwimsProvider);

    state = state.copyWith(questionnaire: questionnaire);
  }

  void printState() {
    print('Current Log Swim State:');
    print('Pool Type: ${state.poolType}');
    print('Event: ${state.event}');
    print('Status: ${state.status}');
    print('Splits: ${state.splits.length}');
    for (var split in state.splits) {
      print(
        'Split - Distance: ${split.intervalDistance}, Time: ${split.intervalTime}, Rate: ${split.intervalStrokeRate}, Count: ${split.intervalStrokeCount}',
      );
    }
    print('Questionnaire: ${state.questionnaire}');
    print(
      'motivationalPositive: ${state.questionnaire.selfTalk[SelfTalkOptionsEnum.motivationalPositive]}',
    );
    print(
      'motivationalNegative: ${state.questionnaire.selfTalk[SelfTalkOptionsEnum.motivationalNegative]}',
    );
  }
}

final logSwimProvider = NotifierProvider<LogSwimProvider, LogSwimStateModel>(
  () => LogSwimProvider(),
);
