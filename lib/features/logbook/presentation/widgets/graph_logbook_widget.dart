import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

class GraphLogbookWidget extends ConsumerWidget {
  final double graphHeight;

  const GraphLogbookWidget({super.key, required this.graphHeight});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
                colors: [metricRed, metricYellow, metricPurple],
              ),
              spots: [
                FlSpot(0, 2.3),
                FlSpot(1, 3.8),
                FlSpot(2, 1.5),
                FlSpot(3, 1.1),
                FlSpot(4, 0.2),
                FlSpot(5, 0.9),
                FlSpot(6, -2.0),
                FlSpot(7, 0.5),
                FlSpot(8, 2.7),
                FlSpot(9, 0.2),
                FlSpot(10, -0.2),
                FlSpot(11, 4.0),
                FlSpot(12, -1.0),
                FlSpot(13, -3.3),
                FlSpot(14, -3.5),
                FlSpot(15, -4.5),
                FlSpot(16, -0.8),
              ],
              isCurved: true,
              barWidth: 3,
              color: Colors.blue,
              dotData: FlDotData(show: false),
            ),
          ],
          minX: 0,
          maxX: 16,
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
}
