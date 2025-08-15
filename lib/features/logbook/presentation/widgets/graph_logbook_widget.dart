import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/logbook/application/logbook_provider.dart';
import 'package:swimming_app_frontend/features/logbook/application/selected_day_logbook_provider.dart';
import 'package:swimming_app_frontend/features/logbook/application/selected_swim_logbook_provider.dart';
import 'package:swimming_app_frontend/features/logbook/domain/models/logbook_state_model.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

class GraphLogbookWidget extends ConsumerWidget {
  final double graphHeight;

  const GraphLogbookWidget({super.key, required this.graphHeight});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final logbookState = ref.watch(logbookProvider);

    final selectedDate = ref.watch(selectedDayLogbookProvider);

    final spots = _generateSpots(logbookState, selectedDate);

    final maxX = spots.length.toDouble() - 1;

    final selectedCarouselIndex = ref.watch(selectedSwimLogbookProvider);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: graphHeight,
      child: LineChart(
        LineChartData(
          backgroundColor: Colors.transparent,
          borderData: FlBorderData(
            border: Border(
              left: BorderSide.none, //(color: colorScheme.secondary, width: 2),
              bottom:
                  BorderSide.none, //(color: colorScheme.secondary, width: 2),
              top: BorderSide.none, // no top border
              right: BorderSide.none, // no right border
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  metricRed.withOpacity(1),
                  metricYellow.withOpacity(1),
                  metricPurple.withOpacity(1),
                ],
              ),
              spots: spots,
              isCurved: true,
              barWidth: 1.5,
              color: Colors.blue,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: (index == selectedCarouselIndex) ? 2.5 : 0,
                    color: colorScheme.primary,
                  );
                },
              ),
            ),
          ],
          minX: 0,
          maxX: maxX,
          minY: -8,
          maxY: 8,
          gridData: FlGridData(
            show: true,
            horizontalInterval: 4,
            verticalInterval: 2,
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
                reservedSize: 28, // Try 24–32 depending on your font size
                interval: 4,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
                reservedSize: 32, // Try 24–32 depending on your font size
                interval: 2, // Optional: controls how often labels appear
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false), // 🔕 Hide right
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false), // 🔕 Hide top
            ),
          ),
          lineTouchData: LineTouchData(
            handleBuiltInTouches: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (touchedSpot) => colorScheme.primary,
              fitInsideHorizontally: true,
              fitInsideVertically: true,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  return LineTooltipItem(
                    (spot.y == 0 || spot.y < 0)
                        ? '${spot.y.toStringAsFixed(2)}%'
                        : '+${spot.y.toStringAsFixed(2)}%',
                    textTheme.headlineSmall!.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  );
                }).toList();
              },
            ),
            enabled: true,
            getTouchedSpotIndicator: (barData, spotIndexes) {
              return spotIndexes.map((index) {
                return TouchedSpotIndicatorData(
                  FlLine(
                    color: colorScheme.primary,
                    strokeWidth: 2,
                  ), // highlight line near point
                  FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, bar, index) =>
                        FlDotCirclePainter(
                          radius: 1,
                          color: colorScheme.primary,
                          strokeWidth: 2,
                          strokeColor: colorScheme.primary,
                        ),
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }

  List<FlSpot> _generateSpots(
    AsyncValue<LogbookStateModel> logbookState,
    DateTime time,
  ) {
    return logbookState.when(
      data: (data) {
        final dayData = data.getDayData(time.year, time.month, time.day);

        if (dayData == null) {
          return [];
        }
        double index = dayData.swims.length.toDouble();
        return dayData.swims.map((swim) {
          final percentageOff = swim.getFinalSplitPercentageOffPB();
          index--;
          return FlSpot(index, percentageOff);
        }).toList();
      },
      error: (error, stack) => [],
      loading: () => [],
    );
  }
}
