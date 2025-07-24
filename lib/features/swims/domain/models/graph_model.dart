import 'package:fl_chart/fl_chart.dart';
import 'package:swimming_app_frontend/features/swims/enum/time_period_enum.dart';
import 'package:swimming_app_frontend/features/swims/domain/models/swim_model.dart';

class SwimGraphModel {
  final TimePeriod timePeriod;
  final List<GetSwimResDTO> resData;

  late TimeGraphModel pbTimeGraphData;
  late RateGraphModel pbRateGraphData;
  // late CountGraphModel pbCountGraphData;

  late TimeGraphModel goalTimeGraphData;
  late RateGraphModel goalRateGraphData;
  // late CountGraphModel goalCountGraphData;

  SwimGraphModel({required this.resData, required this.timePeriod}) {
    pbTimeGraphData = TimeGraphModel(
      resData: resData,
      timePeriod: timePeriod,
      goalData: false,
    );
    pbRateGraphData = RateGraphModel(
      resData: resData,
      timePeriod: timePeriod,
      goalData: false,
    );

    goalTimeGraphData = TimeGraphModel(
      resData: resData,
      timePeriod: timePeriod,
      goalData: true,
    );
    goalRateGraphData = RateGraphModel(
      resData: resData,
      timePeriod: timePeriod,
      goalData: true,
    );
  }
}

class TimeGraphModel {
  final double xMin = 0;
  late double xMax;
  late Map<double, String> spotsDisplayTextMap;
  late List<FlSpot> spots;
  late String xMinDisplayStr;
  late String xMaxDisplayStr;
  late String averageYDisplayStr;
  late double averageY;

  TimeGraphModel({
    required List<GetSwimResDTO> resData,
    required TimePeriod timePeriod,
    required bool goalData,
  }) {
    final timeRange = getTimeRange(timePeriod);
    final startTime = timeRange[0];
    final endTime = timeRange[1];

    xMaxDisplayStr = DateLabelConverter.format(endTime, timePeriod);
    xMinDisplayStr = DateLabelConverter.format(startTime, timePeriod);

    spots = [];
    spotsDisplayTextMap = {};

    for (var swim in resData) {
      // Get split with greatest interval distance
      final maxSplit = swim.splits.reduce(
        (curr, next) =>
            next.intervalDistance > curr.intervalDistance ? next : curr,
      );

      final secondsSinceStart = swim.recordedAt
          .difference(startTime)
          .inSeconds
          .toDouble();
      final perOffTime =
          ((goalData)
              ? maxSplit.perOffGoalTime
              : maxSplit.perOffPBIntervalTime) ??
          0.0;

      print(
        'seconds since start in constructor SwimGraphModel; ${secondsSinceStart}',
      );
      final spot = FlSpot(secondsSinceStart, perOffTime);
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

    averageY = spots.isEmpty
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

class RateGraphModel {
  final double xMin = 0;
  late double xMax;
  late Map<double, String> spotsDisplayTextMap;
  late List<FlSpot> spots;
  late String xMinDisplayStr;
  late String xMaxDisplayStr;
  late String averageYDisplayStr;
  late double averageY;

  RateGraphModel({
    required List<GetSwimResDTO> resData,
    required TimePeriod timePeriod,
    required bool goalData,
  }) {
    final timeRange = getTimeRange(timePeriod);
    final startTime = timeRange[0];
    final endTime = timeRange[1];

    xMaxDisplayStr = DateLabelConverter.format(endTime, timePeriod);
    xMinDisplayStr = DateLabelConverter.format(startTime, timePeriod);

    spots = [];
    spotsDisplayTextMap = {};

    for (var swim in resData) {
      // Get split with greatest interval distance
      final splitsWithRate = swim.splits
          .where(
            (split) =>
                split.intervalStrokeRate != null &&
                split.intervalStrokeRate != 0,
          )
          .toList();

      if (splitsWithRate.isEmpty) {
        continue;
      }

      final maxSplit = splitsWithRate.reduce(
        (curr, next) =>
            next.intervalDistance > curr.intervalDistance ? next : curr,
      );

      final secondsSinceStart = swim.recordedAt
          .difference(startTime)
          .inSeconds
          .toDouble();

      final perOffRate =
          ((goalData)
              ? maxSplit.perOffGoalStrokeRate
              : maxSplit.perOffPBStrokeRate) ??
          0.0;

      print(
        'seconds since start in constructor SwimGraphModel; ${secondsSinceStart}',
      );
      final spot = FlSpot(secondsSinceStart, perOffRate);
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

    averageY = spots.isEmpty
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
