import 'package:swimming_app_frontend/shared/enum/stroke_enum.dart';

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
  });

  factory GetSplitResDTO.fromJson(Map<String, dynamic> json) {
    return GetSplitResDTO(
      id: json['id'] as String,
      stroke: Stroke.values.byName((json['stroke'] as String).toLowerCase()),
      intervalTime: (json['intervalTime'] as num).toDouble(),
      intervalDistance: json['intervalDistance'] as int,
      intervalStrokeRate: json['intervalStrokeRate'],
      intervalStrokeCount: json['intervalStrokeCount'],
      perOffPBIntervalTime: (json['perOffPBIntervalTime'] as num?)?.toDouble(),
      perOffPBStrokeRate: (json['perOffPBStrokeRate'] as num?)?.toDouble(),
      perOffGoalTime: (json['perOffGoalTime'] as num?)?.toDouble(),
      perOffGoalStrokeRate: (json['perOffGoalStrokeRate'] as num?)?.toDouble(),
      dive: json['dive'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stroke': stroke.name,
      'intervalTime': intervalTime,
      'intervalDistance': intervalDistance,
      'intervalStrokeRate': intervalStrokeRate,
      'intervalStrokeCount': intervalStrokeCount,
      'perOffPBIntervalTime': perOffPBIntervalTime,
      'perOffPBStrokeRate': perOffPBStrokeRate,
      'perOffGoalTime': perOffGoalTime,
      'perOffGoalStrokeRate': perOffGoalStrokeRate,
      'dive': dive,
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
      'stroke': stroke.name,
      'intervalTime': intervalTime,
      'intervalDistance': intervalDistance,
      'intervalStrokeRate': intervalStrokeRate,
      'intervalStrokeCount': intervalStrokeCount,
      'dive': dive,
    };
  }

  factory CreateSplitReqDTO.fromJson(Map<String, dynamic> json) {
    return CreateSplitReqDTO(
      stroke: Stroke.values.byName(json['stroke']),
      intervalTime: (json['intervalTime'] as num).toDouble(),
      intervalDistance: json['intervalDistance'] as int,
      intervalStrokeRate: json['intervalStrokeRate'],
      intervalStrokeCount: json['intervalStrokeCount'],
      dive: json['dive'] as bool,
    );
  }

  CreateSplitReqDTO copyWith({
    Stroke? stroke,
    double? intervalTime,
    int? intervalDistance,
    int? intervalStrokeRate,
    int? intervalStrokeCount,
    bool? dive,
  }) {
    return CreateSplitReqDTO(
      stroke: stroke ?? this.stroke,
      intervalTime: intervalTime ?? this.intervalTime,
      intervalDistance: intervalDistance ?? this.intervalDistance,
      intervalStrokeRate: intervalStrokeRate ?? this.intervalStrokeRate,
      intervalStrokeCount: intervalStrokeCount ?? this.intervalStrokeCount,
      dive: dive ?? this.dive,
    );
  }
}
