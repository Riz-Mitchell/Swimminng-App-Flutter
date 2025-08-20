import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/swim_entity.dart';

class SwimViewerGraphLogbookWidget extends ConsumerWidget {
  final GetSwimEntity swim;

  const SwimViewerGraphLogbookWidget({required this.swim, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final List<FlSpot> spots = swim.getVelocitySpots();

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: LineChart(
        LineChartData(
          minY: 1.0,
          maxY: 3.0,
          minX: 0.0,
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
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 24, // Try 24–32 depending on your font size
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final velocity = value.toStringAsFixed(1);
                  return Text(
                    velocity,
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
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              curveSmoothness: 0.05,
              barWidth: 3,
              color: Theme.of(context).colorScheme.primary,
              dotData: FlDotData(show: false),
            ),
          ],
          lineTouchData: LineTouchData(
            touchSpotThreshold: 200,
            handleBuiltInTouches: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (touchedSpot) => colorScheme.primary,
              fitInsideHorizontally: true,
              fitInsideVertically: true,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  return LineTooltipItem(
                    (spot.y == 0 || spot.y < 0)
                        ? '${spot.y.toStringAsFixed(2)}m/s'
                        : '${spot.y.toStringAsFixed(2)}m/s',
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
          gridData: FlGridData(
            show: true,
            horizontalInterval: 1,
            verticalInterval: 1,
          ),
        ),
      ),
    );
  }
}
