import 'package:flutter/material.dart';
import 'package:swimming_app_frontend/shared/enum/stroke_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/models/split_model.dart';
import 'package:swimming_app_frontend/shared/helper/json_formatting.dart';

@immutable
class GetSplitEntity {
  final String id; // Primary Key
  final StrokeEnum stroke; // Stroke type for this split
  final double intervalTime; // Time for this split in seconds
  final int intervalDistance; // Distance for this split in meters
  final int? intervalStrokeRate; // Stroke rate for this split
  final int? intervalStrokeCount; // Stroke count for this split
  final double? perOffPBIntervalTime; // Percentage off PB time
  final double? perOffPBStrokeRate; // Percentage off PB stroke rate
  final double? perOffGoalTime; // Percentage off goal time
  final double? perOffGoalStrokeRate; // Percentage off goal stroke rate
  final bool dive; // Indicates if from dive start

  const GetSplitEntity({
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

  factory GetSplitEntity.fromJson(Map<String, dynamic> json) {
    return GetSplitEntity(
      id: json['id'] as String,
      stroke: enumFromJson(StrokeEnum.values, json['stroke']),
      intervalTime: (json['intervalTime'] as num).toDouble(),
      intervalDistance: json['intervalDistance'] as int,
      intervalStrokeRate: json['intervalStrokeRate'] as int?,
      intervalStrokeCount: json['intervalStrokeCount'] as int?,
      perOffPBIntervalTime: (json['perOffPBIntervalTime'] as num?)?.toDouble(),
      perOffPBStrokeRate: (json['perOffPBStrokeRate'] as num?)?.toDouble(),
      perOffGoalTime: (json['perOffGoalTime'] as num?)?.toDouble(),
      perOffGoalStrokeRate: (json['perOffGoalStrokeRate'] as num?)?.toDouble(),
      dive: json['dive'] as bool,
    );
  }

  String getTimeString() {
    final minutes = (intervalTime / 60).floor();
    final seconds = (intervalTime % 60).toStringAsFixed(2);

    if (minutes > 0) {
      return '${minutes}m${seconds}s';
    } else {
      return '${seconds}s';
    }
  }

  double getSecondsOffPB() {
    if (perOffPBIntervalTime == null) return 0.0;
    print('perOffPBIntervalTime: $perOffPBIntervalTime');

    if (perOffPBIntervalTime! < 0) {
      return -1 *
          (intervalTime - intervalTime * (1 + perOffPBIntervalTime! / 100));
    } else {
      return intervalTime - intervalTime * (1 + perOffPBIntervalTime! / 100);
    }
  }

  double getSecondsOffGoal() {
    if (perOffGoalTime == null) return 0.0;
    return intervalTime - intervalTime * (1 + perOffGoalTime! / 100);
  }

  double getStrokeRateOffPB() {
    if (perOffPBStrokeRate == null) return 0.0;
    return intervalStrokeRate != null
        ? intervalStrokeRate! -
              intervalStrokeRate! * (1 + perOffPBStrokeRate! / 100)
        : 0.0;
  }

  double getStrokeRateOffGoal() {
    if (perOffGoalStrokeRate == null) return 0.0;
    return intervalStrokeRate != null
        ? intervalStrokeRate! -
              intervalStrokeRate! * (1 + perOffGoalStrokeRate! / 100)
        : 0.0;
  }
}

@immutable
class CreateSplitEntity {
  final StrokeEnum stroke; // Stroke type for this split
  final double intervalTime; // Time for this split in seconds
  final int intervalDistance; // Distance for this split in meters
  final int? intervalStrokeRate; // Stroke rate for this split
  final int? intervalStrokeCount; // Stroke count for this split
  final bool dive; // Indicates if from dive start

  const CreateSplitEntity({
    required this.stroke,
    required this.intervalTime,
    required this.intervalDistance,
    this.intervalStrokeRate,
    this.intervalStrokeCount,
    required this.dive,
  });

  Map<String, dynamic> toJson() {
    return {
      'stroke': enumToJson(stroke),
      'intervalTime': intervalTime,
      'intervalDistance': intervalDistance,
      'intervalStrokeRate': intervalStrokeRate,
      'intervalStrokeCount': intervalStrokeCount,
      'dive': dive,
    };
  }
}

class SplitMapper {
  static CreateSplitEntity fromModelToEntity(SplitModel model) {
    return CreateSplitEntity(
      stroke: model.stroke,
      intervalTime: model.intervalTime,
      intervalDistance: model.intervalDistance,
      intervalStrokeRate: model.intervalStrokeRate,
      intervalStrokeCount: model.intervalStrokeCount,
      dive: true, // Currently hardcoded as true
    );
  }
}
