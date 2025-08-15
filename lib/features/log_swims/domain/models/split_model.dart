import 'package:swimming_app_frontend/shared/enum/stroke_enum.dart';

class SplitModel {
  final StrokeEnum stroke;
  final int intervalDistance;
  final double intervalTime;
  final int? intervalStrokeRate;
  final int? intervalStrokeCount;

  SplitModel({
    required this.stroke,
    required this.intervalDistance,
    required this.intervalTime,
    required this.intervalStrokeRate,
    required this.intervalStrokeCount,
  });

  SplitModel copyWith({
    StrokeEnum? stroke,
    int? intervalDistance,
    double? intervalTime,
    int? intervalStrokeRate,
    int? intervalStrokeCount,
  }) {
    return SplitModel(
      stroke: stroke ?? this.stroke,
      intervalDistance: intervalDistance ?? this.intervalDistance,
      intervalTime: intervalTime ?? this.intervalTime,
      intervalStrokeRate: intervalStrokeRate ?? this.intervalStrokeRate,
      intervalStrokeCount: intervalStrokeCount ?? this.intervalStrokeCount,
    );
  }
}
