import 'package:swimming_app_frontend/shared/infrastructure/entities/swim_entity.dart';

class DayLogModel {
  final int dayOfMonth;
  final List<GetSwimEntity> swims;
  final double avPercentOffPb;
  final double lowPercentOffPb;
  final double highPercentOffPb;

  DayLogModel({required this.dayOfMonth, required this.swims})
    : avPercentOffPb = _calculateAveragePercentOffPb(swims),
      lowPercentOffPb = _calculateLowPercentOffPb(swims),
      highPercentOffPb = _calculateHighPercentOffPb(swims);

  static _calculateAveragePercentOffPb(List<GetSwimEntity> swims) {
    if (swims.isEmpty) return 0.0;

    double totalPercentOffPb = 0.0;
    int count = 0;

    for (var swim in swims) {
      // Add all splits' perOffPBIntervalTime
      for (var split in swim.splits) {
        if (split.perOffPBIntervalTime != null) {
          totalPercentOffPb += split.perOffPBIntervalTime!;
          count++;
        }
      }
      // Find the last split (with highest distance)
      if (swim.splits.isNotEmpty) {
        var lastSplit = swim.splits.reduce(
          (a, b) => (a.intervalDistance > b.intervalDistance) ? a : b,
        );
        if (lastSplit.perOffPBIntervalTime != null) {
          totalPercentOffPb += lastSplit.perOffPBIntervalTime!;
          count++;
        }
      }
    }

    return count > 0 ? totalPercentOffPb / count : 0.0;
  }

  static _calculateLowPercentOffPb(List<GetSwimEntity> swims) {
    if (swims.isEmpty) return 0.0;

    double minPercentOffPb = double.infinity;

    for (var swim in swims) {
      for (var split in swim.splits) {
        if (split.perOffPBIntervalTime != null &&
            split.perOffPBIntervalTime! < minPercentOffPb) {
          minPercentOffPb = split.perOffPBIntervalTime!;
        }
      }
      if (swim.splits.isNotEmpty) {
        var lastSplit = swim.splits.reduce(
          (a, b) => (a.intervalDistance > b.intervalDistance) ? a : b,
        );
        if (lastSplit.perOffPBIntervalTime != null &&
            lastSplit.perOffPBIntervalTime! < minPercentOffPb) {
          minPercentOffPb = lastSplit.perOffPBIntervalTime!;
        }
      }
    }

    return minPercentOffPb == double.infinity ? 0.0 : minPercentOffPb;
  }

  static _calculateHighPercentOffPb(List<GetSwimEntity> swims) {
    if (swims.isEmpty) return 0.0;

    double maxPercentOffPb = double.negativeInfinity;

    for (var swim in swims) {
      for (var split in swim.splits) {
        if (split.perOffPBIntervalTime != null &&
            split.perOffPBIntervalTime! > maxPercentOffPb) {
          maxPercentOffPb = split.perOffPBIntervalTime!;
        }
      }
      if (swim.splits.isNotEmpty) {
        var lastSplit = swim.splits.reduce(
          (a, b) => (a.intervalDistance > b.intervalDistance) ? a : b,
        );
        if (lastSplit.perOffPBIntervalTime != null &&
            lastSplit.perOffPBIntervalTime! > maxPercentOffPb) {
          maxPercentOffPb = lastSplit.perOffPBIntervalTime!;
        }
      }
    }

    return maxPercentOffPb == double.negativeInfinity ? 0.0 : maxPercentOffPb;
  }
}
