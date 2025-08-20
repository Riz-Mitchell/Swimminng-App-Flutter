import 'package:fl_chart/src/chart/base/axis_chart/axis_chart_data.dart';
import 'package:flutter/widgets.dart';
import 'package:swimming_app_frontend/external/aus/domain/models/aus_swim_model.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/questionnaire_options_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/selected_pool_type_enum.dart';
import 'package:swimming_app_frontend/shared/enum/event_enum.dart';
import 'package:swimming_app_frontend/shared/enum/stroke_enum.dart';
import 'package:swimming_app_frontend/shared/enum/time_period_enum.dart';
import 'package:swimming_app_frontend/shared/helper/json_formatting.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/split_entity.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/swim_questionnaire_entity.dart';

@immutable
class GetSwimEntity {
  final String id;
  final EventEnum event;
  final SelectedPoolTypeEnum poolType;
  final List<GetSplitEntity> splits;
  final GetSwimQuestionnaireEntity swimQuestionnaire;
  final DateTime recordedAt;

  const GetSwimEntity({
    required this.id,
    required this.event,
    required this.poolType,
    required this.splits,
    required this.swimQuestionnaire,
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
      swimQuestionnaire: GetSwimQuestionnaireEntity.fromJson(
        json['swimQuestionnaire'] as Map<String, dynamic>,
      ),
      recordedAt: DateTime.parse(json['recordedAt'] as String).toLocal(),
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

  double getFinalSplitTime() {
    final lastSplit = splits.reduce(
      (a, b) => a.intervalDistance > b.intervalDistance ? a : b,
    );

    return lastSplit.intervalTime;
  }

  int getFinalSplitDistance() {
    final lastSplit = splits.reduce(
      (a, b) => a.intervalDistance > b.intervalDistance ? a : b,
    );

    return lastSplit.intervalDistance;
  }

  List<FlSpot> getVelocitySpots() {
    int index = splits.length;
    return splits.map((split) {
      index--;
      final velocity = split.intervalDistance / split.intervalTime;
      return FlSpot(index.toDouble(), velocity);
    }).toList();
  }
}

@immutable
class CreateSwimEntity {
  final EventEnum event; // Event type
  final List<CreateSplitEntity> splits; // Splits for this swim
  final bool goalSwim; // Whether this is a goal swim
  final SelectedPoolTypeEnum poolType; // Pool type
  final CreateSwimQuestionnaireEntity swimQuestionnaire;

  const CreateSwimEntity({
    required this.event,
    required this.splits,
    this.goalSwim = false,
    required this.poolType,
    required this.swimQuestionnaire,
  });

  Map<String, dynamic> toJson() {
    return {
      'event': event.name,
      'splits': splits.map((e) => e.toJson()).toList(),
      'goalSwim': goalSwim,
      'poolType': poolType.name,
      'swimQuestionnaire': swimQuestionnaire.toJson(),
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
  final TimePeriodEnum timePeriod;
  final int? year;
  final int? month;
  final int? day;
  final int page;
  final int pageSize;

  const QuerySwimEntity({
    this.userId,
    this.event,
    this.onlyPersonalBest = false,
    this.onlyGoalSwim = false,
    this.onlyDive = false,
    this.timePeriod = TimePeriodEnum.week,
    this.year,
    this.month,
    this.day,
    this.page = 1,
    this.pageSize = 10,
  });

  Map<String, dynamic> toJson() => {
    if (userId != null) 'UserId': userId,
    if (event != null) 'Event': event!.name,
    'OnlyPersonalBest': onlyPersonalBest,
    'OnlyGoalSwim': onlyGoalSwim,
    'OnlyDive': onlyDive,
    'TimePeriodEnum': timePeriod.name,
    if (year != null) 'Year': year,
    if (month != null) 'Month': month,
    if (day != null) 'Day': day,
    'Page': page,
    'PageSize': pageSize,
  };
}

class SwimEntityMapper {
  static CreateSwimEntity fromAusModelToLocalEntity(
    CreateAusSwimModel ausSwimModel,
  ) {
    return CreateSwimEntity(
      event: ausSwimModel.event,
      splits: ausSwimModel.splits.map((split) {
        return CreateSplitEntity(
          intervalDistance: split.splitDistance,
          intervalTime: split.splitTime,
          dive: false,
          stroke: _getSplitStrokeFromAusModelData(ausSwimModel, split),
        );
      }).toList(),
      goalSwim: false, // Default value, can be modified later
      poolType: ausSwimModel.poolType,
      swimQuestionnaire: CreateSwimQuestionnaireEntity(
        selfTalk: SelfTalkOptionsEnum.unselected,
        nerves: [NervesOptionsEnum.unselected],
        energyLevel: EnergyLevelOptionsEnum.unselected,
        breathing: BreathingOptionsEnum.unselected,
        catchFeel: [CatchFeelOptionsEnum.unselected],
        strokeLength: StrokeLengthOptionsEnum.unselected,
        kickTechnique: KickTechniqueOptionsEnum.unselected,
        kickThroughout: KickThroughoutOptionsEnum.unselected,
        headPosition: [HeadPositionOptionsEnum.unselected],
        turn: [TurnOptionsEnum.unselected],
      ),
    );
  }

  static StrokeEnum _getSplitStrokeFromAusModelData(
    CreateAusSwimModel ausSwimModel,
    CreateAusSplitModel currentSplit,
  ) {
    switch (ausSwimModel.event) {
      case EventEnum.freestyle50:
      case EventEnum.freestyle100:
      case EventEnum.freestyle200:
      case EventEnum.freestyle400:
      case EventEnum.freestyle800:
      case EventEnum.freestyle1500:
        return StrokeEnum.freestyle;
      case EventEnum.backstroke50:
      case EventEnum.backstroke100:
      case EventEnum.backstroke200:
        return StrokeEnum.backstroke;
      case EventEnum.breaststroke50:
      case EventEnum.breaststroke100:
      case EventEnum.breaststroke200:
        return StrokeEnum.breaststroke;
      case EventEnum.butterfly50:
      case EventEnum.butterfly100:
      case EventEnum.butterfly200:
        return StrokeEnum.butterfly;
      case EventEnum.individualMedley100:
        switch (currentSplit.splitDistance) {
          case <= 25:
            return StrokeEnum.butterfly;
          case <= 50:
            return StrokeEnum.backstroke;
          case <= 75:
            return StrokeEnum.breaststroke;
          case <= 100:
            return StrokeEnum.freestyle;
        }
      case EventEnum.individualMedley200:
        switch (currentSplit.splitDistance) {
          case <= 50:
            return StrokeEnum.butterfly;
          case <= 100:
            return StrokeEnum.backstroke;
          case <= 150:
            return StrokeEnum.breaststroke;
          case <= 200:
            return StrokeEnum.freestyle;
        }
      case EventEnum.individualMedley400:
        switch (currentSplit.splitDistance) {
          case <= 100:
            return StrokeEnum.butterfly;
          case <= 200:
            return StrokeEnum.backstroke;
          case <= 300:
            return StrokeEnum.breaststroke;
          case <= 400:
            return StrokeEnum.freestyle;
        }
      case EventEnum.none:
        return StrokeEnum.freestyle; // Default stroke if none specified
    }
    throw ArgumentError(
      'Issue converting swims to local: ${ausSwimModel.event}',
    );
  }
}
