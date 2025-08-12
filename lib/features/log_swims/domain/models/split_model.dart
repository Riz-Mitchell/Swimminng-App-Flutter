class SplitModel {
  final double intervalDistance;
  final double intervalTime;
  final double intervalStrokeRate;
  final double intervalStrokeCount;

  SplitModel({
    required this.intervalDistance,
    required this.intervalTime,
    required this.intervalStrokeRate,
    required this.intervalStrokeCount,
  });

  SplitModel copyWith({
    double? intervalDistance,
    double? intervalTime,
    double? intervalStrokeRate,
    double? intervalStrokeCount,
  }) {
    return SplitModel(
      intervalDistance: intervalDistance ?? this.intervalDistance,
      intervalTime: intervalTime ?? this.intervalTime,
      intervalStrokeRate: intervalStrokeRate ?? this.intervalStrokeRate,
      intervalStrokeCount: intervalStrokeCount ?? this.intervalStrokeCount,
    );
  }
}
