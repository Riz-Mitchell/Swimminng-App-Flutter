enum Stroke { freestyle, backstroke, breaststroke, butterfly }

class GetSplitResDTO {
  final String id;
  final Stroke stroke;
  final double intervalTime;
  final int intervalDistance;
  final int? intervalStrokeRate;
  final int? intervalStrokeCount;
  final double? perOffPBIntervalTime;
  final double? perOffPBStrokeRate;
  final double? perOffGoalTime;
  final double? perOffGoalStrokeRate;
  final bool dive;
  final DateTime recordedAt;

  GetSplitResDTO({
    required this.id,
    required this.stroke,
    required this.intervalTime,
    required this.intervalDistance,
    this.intervalStrokeRate,
    this.intervalStrokeCount,
    this.perOffPBIntervalTime,
    this.perOffPBStrokeRate,
    this.perOffGoalTime,
    this.perOffGoalStrokeRate,
    required this.dive,
    required this.recordedAt,
  });

  factory GetSplitResDTO.fromJson(Map<String, dynamic> json) {
    return GetSplitResDTO(
      id: json['Id'] as String,
      stroke: Stroke.values.byName(json['Stroke']),
      intervalTime: (json['IntervalTime'] as num).toDouble(),
      intervalDistance: json['IntervalDistance'] as int,
      intervalStrokeRate: json['IntervalStrokeRate'],
      intervalStrokeCount: json['IntervalStrokeCount'],
      perOffPBIntervalTime: (json['PerOffPBIntervalTime'] as num?)?.toDouble(),
      perOffPBStrokeRate: (json['PerOffPBStrokeRate'] as num?)?.toDouble(),
      perOffGoalTime: (json['PerOffGoalTime'] as num?)?.toDouble(),
      perOffGoalStrokeRate: (json['PerOffGoalStrokeRate'] as num?)?.toDouble(),
      dive: json['Dive'] as bool,
      recordedAt: DateTime.parse(json['RecordedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Stroke': stroke.name,
      'IntervalTime': intervalTime,
      'IntervalDistance': intervalDistance,
      'IntervalStrokeRate': intervalStrokeRate,
      'IntervalStrokeCount': intervalStrokeCount,
      'PerOffPBIntervalTime': perOffPBIntervalTime,
      'PerOffPBStrokeRate': perOffPBStrokeRate,
      'PerOffGoalTime': perOffGoalTime,
      'PerOffGoalStrokeRate': perOffGoalStrokeRate,
      'Dive': dive,
      'RecordedAt': recordedAt.toIso8601String(),
    };
  }
}

class CreateSplitReqDTO {
  final Stroke stroke;
  final double intervalTime;
  final int intervalDistance;
  final int? intervalStrokeRate;
  final int? intervalStrokeCount;
  final bool dive;

  CreateSplitReqDTO({
    required this.stroke,
    required this.intervalTime,
    required this.intervalDistance,
    this.intervalStrokeRate,
    this.intervalStrokeCount,
    required this.dive,
  });

  Map<String, dynamic> toJson() {
    return {
      'Stroke': stroke.name,
      'IntervalTime': intervalTime,
      'IntervalDistance': intervalDistance,
      'IntervalStrokeRate': intervalStrokeRate,
      'IntervalStrokeCount': intervalStrokeCount,
      'Dive': dive,
    };
  }

  factory CreateSplitReqDTO.fromJson(Map<String, dynamic> json) {
    return CreateSplitReqDTO(
      stroke: Stroke.values.byName(json['Stroke']),
      intervalTime: (json['IntervalTime'] as num).toDouble(),
      intervalDistance: json['IntervalDistance'] as int,
      intervalStrokeRate: json['IntervalStrokeRate'],
      intervalStrokeCount: json['IntervalStrokeCount'],
      dive: json['Dive'] as bool,
    );
  }
}
