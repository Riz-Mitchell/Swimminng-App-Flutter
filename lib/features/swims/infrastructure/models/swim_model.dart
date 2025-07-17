import 'package:fl_chart/fl_chart.dart';
import 'package:swimming_app_frontend/api/models/split_model.dart';
import 'package:swimming_app_frontend/features/swims/enum/time_period_enum.dart';

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

  CreateSwimReqDTO copyWith({
    EventEnum? event,
    int? perceivedExertion,
    List<CreateSplitReqDTO>? splits,
    bool? goalSwim,
  }) {
    return CreateSwimReqDTO(
      event: event ?? this.event,
      perceivedExertion: perceivedExertion ?? this.perceivedExertion,
      goalSwim: goalSwim ?? this.goalSwim,
      splits: splits ?? this.splits,
    );
  }

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
  final TimePeriod timePeriod;
  final List<GetSwimResDTO> resData;
  final double xMin = 0;
  late double xMax;
  late Map<double, String> spotsDisplayTextMap;
  late List<FlSpot> spots;
  late String xMinDisplayStr;
  late String xMaxDisplayStr;
  late String averageYDisplayStr;

  SwimGraphModel({required this.resData, required this.timePeriod}) {
    final timeRange = getTimeRange(timePeriod);
    final startTime = timeRange[0];
    final endTime = timeRange[1];

    print('there are ${resData.length} swims in this model');

    xMaxDisplayStr = DateLabelConverter.format(endTime, timePeriod);
    xMinDisplayStr = DateLabelConverter.format(startTime, timePeriod);

    spots = [];
    spotsDisplayTextMap = {};

    for (var swim in resData) {
      final maxSplit = swim.splits.reduce(
        (curr, next) =>
            next.intervalDistance > curr.intervalDistance ? next : curr,
      );

      final secondsSinceStart = swim.recordedAt
          .difference(startTime)
          .inSeconds
          .toDouble();
      final percentOffPB = maxSplit.perOffPBIntervalTime ?? 0.0;

      print(
        'seconds since start in constructor SwimGraphModel; ${secondsSinceStart}',
      );
      final spot = FlSpot(secondsSinceStart, percentOffPB);
      spots.add(spot);

      final spotDateTime = startTime.add(
        Duration(seconds: secondsSinceStart.toInt()),
      );
      final String displayText = DateLabelConverter.format(
        spotDateTime,
        timePeriod,
      );

      spotsDisplayTextMap[secondsSinceStart] = displayText;
    }

    spots.sort((a, b) => a.x.compareTo(b.x));

    final averageY = spots.isEmpty
        ? 0.0
        : spots.map((spot) => spot.y).reduce((a, b) => a + b) / spots.length;

    averageYDisplayStr = (averageY > 0)
        ? "+${averageY.toStringAsFixed(2)}%"
        : "${averageY.toStringAsFixed(2)}%";

    final today = DateTime.now();
    final clampedToday = today.isAfter(endTime) ? endTime : today;
    xMax = clampedToday.difference(startTime).inSeconds.toDouble();
  }
}
