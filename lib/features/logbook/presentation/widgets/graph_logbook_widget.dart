import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/logbook/application/logbook_provider.dart';
import 'package:swimming_app_frontend/features/logbook/application/selected_day_logbook_provider.dart';
import 'package:swimming_app_frontend/features/logbook/application/selected_swim_logbook_provider.dart';
import 'package:swimming_app_frontend/features/logbook/domain/models/logbook_state_model.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/gradient_mapper.dart';
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

    final double highestY = spots.isNotEmpty
        ? spots.map((s) => s.y).reduce((a, b) => a > b ? a : b)
        : 0;
    final double lowestY = spots.isNotEmpty
        ? spots.map((s) => s.y).reduce((a, b) => a < b ? a : b)
        : 0;

    final gradientStops = calculateStops(lowestY, highestY);

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
              bottom: BorderSide(
                color: colorScheme.secondary,
                width: 0.5,
                style: BorderStyle.solid,
              ), //(color: colorScheme.secondary, width: 2),
              top: BorderSide(
                color: colorScheme.secondary,
                width: 0.5,
                style: BorderStyle.solid,
              ), // no top border
              right: BorderSide.none, // no right border
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  metricPurple,
                  metricPurple,
                  metricBlue,
                  metricBlue,
                  metricOrange,
                  metricOrange,
                ],
                stops: gradientStops,
                // [
                //   0.0, // -8
                //   0.1875, // -5
                //   0.25, // -4
                //   0.75, // 4
                //   0.8125, // 5
                //   1.0, // 8
                // ],
              ),
              spots: spots,
              isCurved: true,
              curveSmoothness: 0.1,
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
                showTitles: true,
                reservedSize: 28, // Try 24–32 depending on your font size
                interval: 4,
                getTitlesWidget: (value, meta) {
                  final percentage = value.toStringAsFixed(0);
                  return Text(
                    (value == 0 || value < 0)
                        ? '$percentage%'
                        : '+$percentage%',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.secondary,
                    ),
                  );
                },
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
            touchSpotThreshold: 50,
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
                    dashArray: [4, 2],
                    color: colorScheme.primary,
                    strokeWidth: 1,
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
