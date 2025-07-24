import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/swims/enum/time_period_enum.dart';
import 'package:swimming_app_frontend/features/swims/presentation/widgets/time_period_group.dart';
import 'package:swimming_app_frontend/features/swims/application/providers/swim_graph_provider.dart';

class SwimGraph extends ConsumerWidget {
  const SwimGraph({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(swimGraphControllerProvider);
    final stateNotifier = ref.read(swimGraphControllerProvider.notifier);
    final currSpots = stateNotifier.getGraphSpots();

    final spotsDisplayTextMap = stateNotifier.getSpotsDisplayTextMap();

    print('On Reload:');
    for (FlSpot spot in currSpots) {
      print('spot: x: ${spot.x}, y: ${spot.y}');
    }

    final xMin = stateNotifier.getXMin();
    final xMax = stateNotifier.getXMax();

    print('in the widget xMax: ${xMax}, xMin: ${xMin}');

    final startStr = stateNotifier.getStartStr();
    final endStr = stateNotifier.getEndStr();

    final averageYDisplayStr = stateNotifier.getAverageYDisplayStr();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        spacing: 20,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Average Off',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    averageYDisplayStr,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),

              TimePeriodGroup(),
            ],
          ),
          AspectRatio(
            aspectRatio: 1.5,
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (touchedSpot) =>
                        Theme.of(context).colorScheme.primary,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((LineBarSpot touchedSpot) {
                        final double x = touchedSpot.x;

                        final timeRepStr = spotsDisplayTextMap[x] ?? '';

                        final yVal = touchedSpot.y.toStringAsFixed(2);
                        final prefix = touchedSpot.y > 0 ? '+' : '';

                        return LineTooltipItem(
                          '$prefix$yVal% at $timeRepStr',
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: false,
                    spots: currSpots,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],

                minX: xMin,
                maxX: xMax,
                titlesData: FlTitlesData(
                  show:
                      true, // still required, but individual sides can be disabled
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                startStr,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Text(
                endStr,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
