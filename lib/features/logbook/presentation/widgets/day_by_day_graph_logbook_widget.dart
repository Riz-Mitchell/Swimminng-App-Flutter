import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

class DayByDayGraphLogbookWidget extends ConsumerWidget {
  const DayByDayGraphLogbookWidget({super.key, required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 300,
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
                showTitles: true,
                reservedSize: 28, // Try 24–32 depending on your font size
                interval: 4,
                // getTitlesWidget: (value, meta) {
                //   return Padding(
                //     padding: const EdgeInsets.only(right: 8),
                //     child: Text(
                //       value.toString(),
                //       style: const TextStyle(fontSize: 10),
                //       textAlign: TextAlign.right,
                //     ),
                //   );
                // },
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
