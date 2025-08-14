import 'package:flutter/widgets.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/selected_pool_type_enum.dart';
import 'package:swimming_app_frontend/features/swims/enum/event_enum.dart';
import 'package:swimming_app_frontend/features/swims/enum/time_period_enum.dart';
import 'package:swimming_app_frontend/shared/helper/json_formatting.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/split_entity.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/swim_questionnaire_entity.dart';

@immutable
class GetSwimEntity {
  final String id;
  final EventEnum event;
  final SelectedPoolTypeEnum poolType;
  final List<GetSplitEntity> splits;
  final GetSwimQuestionnaireEntity questionnaire;
  final DateTime recordedAt;

  const GetSwimEntity({
    required this.id,
    required this.event,
    required this.poolType,
    required this.splits,
    required this.questionnaire,
    required this.recordedAt,
  });

  factory GetSwimEntity.fromJson(Map<String, dynamic> json) {
    return GetSwimEntity(
      id: json['id'],
      event: enumFromJson(EventEnum.values, json['event']),
      poolType: enumFromJson(SelectedPoolTypeEnum.values, json['poolType']),
      splits: (json['splits'] as List<dynamic>)
          .map((e) => GetSplitEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      questionnaire: GetSwimQuestionnaireEntity.fromJson(
        json['swimQuestionnaire'] as Map<String, dynamic>,
      ),
      recordedAt: DateTime.parse(json['recordedAt'] as String),
    );
  }

  double getFinalSplitPercentageOffPB() {
    if (splits.isEmpty) return 0.0;

    final lastSplit = splits.reduce(
      (a, b) => a.intervalDistance > b.intervalDistance ? a : b,
    );

    if (lastSplit.perOffPBIntervalTime == null) return 0.0;

    return lastSplit.perOffPBIntervalTime!;
  }
}

@immutable
class CreateSwimEntity {
  final EventEnum event; // Event type
  final List<CreateSplitEntity> splits; // Splits for this swim
  final bool goalSwim; // Whether this is a goal swim
  final SelectedPoolTypeEnum poolType; // Pool type
  final CreateSwimQuestionnaireEntity questionnaire;

  const CreateSwimEntity({
    required this.event,
    required this.splits,
    this.goalSwim = false,
    required this.poolType,
    required this.questionnaire,
  });

  Map<String, dynamic> toJson() {
    return {
      'event': event.name,
      'splits': splits.map((e) => e.toJson()).toList(),
      'goalSwim': goalSwim,
      'poolType': poolType.name,
      'questionnaire': questionnaire.toJson(),
    };
  }
}

class UpdateSwimEntity {}

@immutable
class QuerySwimEntity {
  final String? userId;
  final EventEnum? event;
  final bool onlyPersonalBest;
  final bool onlyGoalSwim;
  final bool onlyDive;
  final TimePeriodEnum timePeriodEnum;
  final int page;
  final int pageSize;

  const QuerySwimEntity({
    this.userId,
    this.event,
    this.onlyPersonalBest = false,
    this.onlyGoalSwim = false,
    this.onlyDive = false,
    this.timePeriodEnum = TimePeriodEnum.week,
    this.page = 1,
    this.pageSize = 10,
  });

  Map<String, dynamic> toJson() => {
    if (userId != null) 'UserId': userId,
    if (event != null) 'Event': event!.name,
    'OnlyPersonalBest': onlyPersonalBest,
    'OnlyGoalSwim': onlyGoalSwim,
    'OnlyDive': onlyDive,
    'TimePeriodEnum': timePeriodEnum.name,
    'Page': page,
    'PageSize': pageSize,
  };
}
