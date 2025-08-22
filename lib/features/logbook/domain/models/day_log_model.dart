import 'package:swimming_app_frontend/shared/enum/event_enum.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/swim_entity.dart';

class DayLogModel {
  final int dayOfMonth;
  final List<GetSwimEntity> swims;
  final double? avPercentOffPb;
  final double? lowPercentOffPb;
  final double? highPercentOffPb;
  final List<EventEnum> eventsSwumToday;

  DayLogModel({required this.dayOfMonth, required this.swims})
    : avPercentOffPb = _calculateAveragePercentOffPb(swims),
      lowPercentOffPb = _calculateLowPercentOffPb(swims),
      highPercentOffPb = _calculateHighPercentOffPb(swims),
      eventsSwumToday = _getEventsSwumToday(swims);

  static double? _calculateAveragePercentOffPb(
    List<GetSwimEntity> swims, {
    EventEnum? event,
  }) {
    if (swims.isEmpty) return null;

    double totalPercentOffPb = 0.0;
    int count = 0;

    for (var swim in swims) {
      if (event != null && swim.event != event) continue;

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

    return count > 0 ? totalPercentOffPb / count : null;
  }

  static _calculateLowPercentOffPb(
    List<GetSwimEntity> swims, {
    EventEnum? event,
  }) {
    if (swims.isEmpty) return null;

    double minPercentOffPb = double.infinity;

    for (var swim in swims) {
      if (event != null && swim.event != event) continue;

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

    return minPercentOffPb == double.infinity ? null : minPercentOffPb;
  }

  static _calculateHighPercentOffPb(
    List<GetSwimEntity> swims, {
    EventEnum? event,
  }) {
    if (swims.isEmpty) return null;

    double maxPercentOffPb = double.negativeInfinity;

    for (var swim in swims) {
      if (event != null && swim.event != event) continue;
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

    return maxPercentOffPb == double.negativeInfinity ? null : maxPercentOffPb;
  }

  double calculateAveragePercentOffPbByEvent(EventEnum event) {
    double totalPercentOffPb = 0.0;
    int count = 0;

    for (var swim in swims) {
      if (swim.event != event) continue;

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

    return count > 0 ? totalPercentOffPb / count : 0;
  }

  double calculateLowPercentOffPbByEvent(EventEnum event) {
    double minPercentOffPb = double.infinity;

    for (var swim in swims) {
      if (swim.event != event) continue;

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

  double calculateHighPercentOffPbByEvent(EventEnum event) {
    double maxPercentOffPb = double.negativeInfinity;

    for (var swim in swims) {
      if (swim.event != event) continue;
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

  static List<EventEnum> _getEventsSwumToday(List<GetSwimEntity> swims) {
    final events = <EventEnum>{};

    for (var swim in swims) {
      print('Swim event: ${swim.event}');
      events.add(swim.event);
    }

    return events.toList();
  }
}
