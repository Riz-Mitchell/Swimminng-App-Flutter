import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

class StrokeDistributionRadarProfileWidget extends ConsumerWidget {
  const StrokeDistributionRadarProfileWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 200,
      width: screenWidth,
      child: RadarChart(
        RadarChartData(
          dataSets: [
            RadarDataSet(
              dataEntries: [
                RadarEntry(value: 0.4), // Freestyle
                RadarEntry(value: 0), // Backstroke
                RadarEntry(value: 0), // Breaststroke
                RadarEntry(value: 0.5), // Butterfly
              ],
              borderColor: metricBlue,
              fillColor: metricBlue.withOpacity(0.3),
              entryRadius: 3,
              borderWidth: 2,
            ),
          ],
          radarBackgroundColor: Colors.transparent,
          tickCount: 5,
          ticksTextStyle: textTheme.bodyMedium?.copyWith(
            color: Colors.transparent,
          ),
          gridBorderData: BorderSide(color: colorScheme.surface),
          getTitle: (index, angle) {
            const titles = [
              'Freestyle',
              'Backstroke',
              'Breaststroke',
              'Butterfly',
            ];
            return RadarChartTitle(text: titles[index]);
          },
          titleTextStyle: textTheme.bodyMedium?.copyWith(
            color: colorScheme.primary,
          ),
          radarShape: RadarShape.polygon,
          radarBorderData: BorderSide(color: colorScheme.surface),
          tickBorderData: BorderSide(color: colorScheme.surface),
        ),
      ),
    );
  }
}
