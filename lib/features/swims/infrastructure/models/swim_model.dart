import 'package:swimming_app_frontend/api/models/split_model.dart';

enum EventEnum {
  freestyle50,
  freestyle100,
  freestyle200,
  freestyle400,
  freestyle800,
  freestyle1500,
  backstroke100,
  backstroke200,
  breaststroke100,
  breaststroke200,
  butterfly100,
  butterfly200, // Add all your C# enum values here
}

extension EventEnumExtension on EventEnum {
  String toReadableString() {
    switch (this) {
      case EventEnum.freestyle50:
        return '50 Free';
      case EventEnum.freestyle100:
        return '100 Free';
      case EventEnum.freestyle200:
        return '200 Free';
      case EventEnum.freestyle400:
        return '400 Free';
      case EventEnum.freestyle800:
        return '800 Free';
      case EventEnum.freestyle1500:
        return '1500 Free';
      case EventEnum.backstroke100:
        return '100 Back';
      case EventEnum.backstroke200:
        return '200 Back';
      case EventEnum.breaststroke100:
        return '100 Breast';
      case EventEnum.breaststroke200:
        return '200 Breast';
      case EventEnum.butterfly100:
        return '100 Fly';
      case EventEnum.butterfly200:
        return '200 Fly';
    }
  }
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
      id: json['id'],
      event: EventEnum.values.byName((json['event'] as String).toLowerCase()),
      splits: (json['splits'] as List<dynamic>)
          .map((e) => GetSplitResDTO.fromJson(e))
          .toList(),
      perceivedExertion: json['perceivedExertion'],
      goalSwim: json['goalSwim'],
      recordedAt: DateTime.parse(json['recordedAt']),
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

class SwimGraphModel {
  final List<GetSwimResDTO> pastWeek;
  final List<GetSwimResDTO> pastMonth;
  final List<GetSwimResDTO> pastThreeMonths;
  final List<GetSwimResDTO> pastSixMonths;
  final List<GetSwimResDTO> pastYear;

  SwimGraphModel({
    required this.pastWeek,
    required this.pastMonth,
    required this.pastThreeMonths,
    required this.pastSixMonths,
    required this.pastYear,
  });

  // Implement methods for class
  // ........
  // ........
  // ........
  // ........
  // ........
}
