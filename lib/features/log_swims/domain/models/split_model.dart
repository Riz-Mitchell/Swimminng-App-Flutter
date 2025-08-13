class SplitModel {
  final int intervalDistance;
  final double intervalTime;
  final int? intervalStrokeRate;
  final int? intervalStrokeCount;

  SplitModel({
    required this.intervalDistance,
    required this.intervalTime,
    required this.intervalStrokeRate,
    required this.intervalStrokeCount,
  });

  SplitModel copyWith({
    int? intervalDistance,
    double? intervalTime,
    int? intervalStrokeRate,
    int? intervalStrokeCount,
  }) {
    return SplitModel(
      intervalDistance: intervalDistance ?? this.intervalDistance,
      intervalTime: intervalTime ?? this.intervalTime,
      intervalStrokeRate: intervalStrokeRate ?? this.intervalStrokeRate,
      intervalStrokeCount: intervalStrokeCount ?? this.intervalStrokeCount,
    );
  }
}
