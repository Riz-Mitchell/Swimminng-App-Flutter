import 'package:swimming_app_frontend/api/models/split_model.dart';

enum EventEnum {
  freestyle,
  backstroke,
  breaststroke,
  butterfly,
  medley,
  // Add all your C# enum values here
}

enum TimePeriod {
  day,
  week,
  month,
  year,
  all,
  // Match your backend Enum.TimePeriod values
}

class GetSwimsQuery {
  final String? userId;
  final EventEnum? event;
  final bool onlyPersonalBest;
  final bool onlyGoalSwim;
  final bool onlyDive;
  final TimePeriod timePeriod;
  final int page;
  final int pageSize;

  GetSwimsQuery({
    this.userId,
    this.event,
    this.onlyPersonalBest = false,
    this.onlyGoalSwim = false,
    this.onlyDive = false,
    this.timePeriod = TimePeriod.week,
    this.page = 1,
    this.pageSize = 10,
  });

  Map<String, dynamic> toJson() => {
    if (userId != null) 'UserId': userId,
    if (event != null) 'Event': event!.name,
    'OnlyPersonalBest': onlyPersonalBest,
    'OnlyGoalSwim': onlyGoalSwim,
    'OnlyDive': onlyDive,
    'TimePeriod': timePeriod.name,
    'Page': page,
    'PageSize': pageSize,
  };
}

class GetSwimResDTO {
  final String id;
  final EventEnum event;
  final List<GetSplitResDTO> splits;
  final int? perceivedExertion;
  final bool goalSwim;
  final DateTime recordedAt;

  GetSwimResDTO({
    required this.id,
    required this.event,
    required this.splits,
    this.perceivedExertion,
    required this.goalSwim,
    required this.recordedAt,
  });

  factory GetSwimResDTO.fromJson(Map<String, dynamic> json) {
    return GetSwimResDTO(
      id: json['Id'],
      event: EventEnum.values.byName(json['Event']),
      splits: (json['Splits'] as List<dynamic>)
          .map((e) => GetSplitResDTO.fromJson(e))
          .toList(),
      perceivedExertion: json['PerceivedExertion'],
      goalSwim: json['GoalSwim'],
      recordedAt: DateTime.parse(json['RecordedAt']),
    );
  }
}

class CreateSwimReqDTO {
  final EventEnum event;
  final int? perceivedExertion;
  final List<CreateSplitReqDTO> splits;
  final bool goalSwim;

  CreateSwimReqDTO({
    required this.event,
    this.perceivedExertion,
    required this.splits,
    this.goalSwim = false,
  });

  Map<String, dynamic> toJson() => {
    'Event': event.name,
    'PerceivedExertion': perceivedExertion,
    'Splits': splits.map((e) => e.toJson()).toList(),
    'GoalSwim': goalSwim,
  };
}

class UpdateSwimReqDTO {
  final EventEnum? event;
  final int? perceivedExertion;
  final bool? goalSwim;

  UpdateSwimReqDTO({this.event, this.perceivedExertion, this.goalSwim});

  Map<String, dynamic> toJson() => {
    if (event != null) 'Event': event!.name,
    if (perceivedExertion != null) 'PerceivedExertion': perceivedExertion,
    if (goalSwim != null) 'GoalSwim': goalSwim,
  };
}
