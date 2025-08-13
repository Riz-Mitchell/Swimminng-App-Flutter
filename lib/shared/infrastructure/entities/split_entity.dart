import 'package:swimming_app_frontend/features/log_swims/domain/enum/stroke_enum.dart';

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

  GetSplitEntity({
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
}

class CreateSplitEntity {
  final StrokeEnum stroke; // Stroke type for this split
  final double intervalTime; // Time for this split in seconds
  final int intervalDistance; // Distance for this split in meters
  final int? intervalStrokeRate; // Stroke rate for this split
  final int? intervalStrokeCount; // Stroke count for this split
  final bool dive; // Indicates if from dive start

  CreateSplitEntity({
    required this.stroke,
    required this.intervalTime,
    required this.intervalDistance,
    this.intervalStrokeRate,
    this.intervalStrokeCount,
    required this.dive,
  });
}
