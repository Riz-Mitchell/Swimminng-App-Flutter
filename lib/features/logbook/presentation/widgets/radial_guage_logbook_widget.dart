import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/split_entity.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/icon_button_widget.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialGaugeLogbookWidget extends ConsumerWidget {
  final double innerOpacity;
  final GetSplitEntity? split;

  const RadialGaugeLogbookWidget({
    super.key,
    this.innerOpacity = 0.3,
    this.split,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final percentage = split?.perOffPBIntervalTime ?? 0.0;

    print('Percentage: $percentage');

    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          ClipRect(
            child: Align(
              alignment: Alignment.topCenter,
              heightFactor: 0.7,
              child: SizedBox(
                height: 420,
                width: 380,
                child: SfRadialGauge(
                  animationDuration: 1000,
                  enableLoadingAnimation: true,
                  backgroundColor: Colors.transparent,
                  axes: [
                    RadialAxis(
                      centerX: 0.5,
                      centerY: 0.425,
                      canScaleToFit: false,
                      startAngle: 160,
                      endAngle: 20,
                      minimum: -8,
                      maximum: 8,
                      showLabels: true,
                      showFirstLabel: true,
                      showLastLabel: true,
                      axisLabelStyle: GaugeTextStyle(
                        color: colorScheme.secondary,
                        fontSize: textTheme.bodyMedium?.fontSize,
                        fontWeight: textTheme.bodyMedium?.fontWeight,
                        fontFamily: textTheme.bodyMedium?.fontFamily,
                      ),
                      onLabelCreated: (value) {
                        switch (value.text) {
                          case '8':
                            value.text = '8%';
                          case '-8':
                            value.text = '-8%';
                          default:
                            value.text = '';
                        }
                      },
                      labelsPosition: ElementsPosition.inside,
                      showTicks: false,
                      radiusFactor: 1,
                      useRangeColorForAxis: true,
                      axisLineStyle: AxisLineStyle(
                        thickness: 20,
                        cornerStyle: CornerStyle.bothCurve,

                        gradient: SweepGradient(
                          colors: [
                            metricPurple.withOpacity(innerOpacity), // at -8
                            metricPurple.withOpacity(
                              innerOpacity,
                            ), // at -5 (still purple)
                            metricBlue.withOpacity(
                              innerOpacity,
                            ), // at -4 (transition starts here)
                            metricBlue.withOpacity(innerOpacity), // at 4
                            metricOrange.withOpacity(innerOpacity), // at 5
                            metricOrange.withOpacity(innerOpacity), // at 8
                          ],
                          stops: [
                            0.0, // -8
                            0.1875, // -5
                            0.25, // -4
                            0.75, // 4
                            0.8125, // 5
                            1.0, // 8
                          ],
                        ),
                      ),
                      ranges: <GaugeRange>[
                        GaugeRange(
                          startWidth: 5,
                          endWidth: 5,
                          startValue: -8,
                          endValue: -5,
                          color: metricPurple,
                        ),
                        GaugeRange(
                          startWidth: 5,
                          endWidth: 5,
                          startValue: -5,
                          endValue: -4,
                          gradient: SweepGradient(
                            colors: [metricPurple, metricBlue],
                          ),
                        ),
                        GaugeRange(
                          startWidth: 5,
                          endWidth: 5,
                          startValue: -4,
                          endValue: 4,
                          color: metricBlue,
                        ),
                        GaugeRange(
                          startWidth: 5,
                          endWidth: 5,
                          startValue: 4,
                          endValue: 5,
                          gradient: SweepGradient(
                            colors: [metricBlue, metricOrange],
                          ),
                        ),
                        GaugeRange(
                          startWidth: 5,
                          endWidth: 5,
                          startValue: 5,
                          endValue: 8,
                          color: metricOrange,
                        ),
                      ],
                      pointers: [
                        NeedlePointer(
                          enableAnimation: true,
                          animationType: AnimationType.ease,
                          animationDuration: 1000,
                          tailStyle: TailStyle(
                            color: colorScheme.surface.withOpacity(0.5),
                            length: 0.1,
                          ),
                          value: percentage!, // your metric value
                          needleLength:
                              1.0, // fraction of radius (1 = full radius)
                          needleStartWidth: 5, // thickness near center
                          needleEndWidth: 5, // thickness at tip
                          needleColor: colorScheme.primary,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              colorScheme.primary,
                              colorScheme.primary,
                              colorScheme.primary.withOpacity(0.5),
                              Colors.transparent,
                            ],
                            stops: [0.0, 0.1, 0.10000001, 0.5],
                          ),
                          knobStyle: KnobStyle(knobRadius: 0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 140,
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(
                    split?.getTimeString() ?? 's',
                    style: textTheme.displayLarge!.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  _getTLDRWidget(textTheme, colorScheme),
                  // Text(
                  //   'You were ${split?.getSecondsOffPB().toStringAsFixed(2)}s or',
                  //   style: textTheme.bodyMedium!.copyWith(
                  //     color: colorScheme.secondary,
                  //   ),
                  // ),
                  // Text(
                  //   '${split?.perOffPBIntervalTime!.toStringAsFixed(2)}% off your PB Pace',
                  //   style: textTheme.headlineSmall!.copyWith(
                  //     color: colorScheme.primary,
                  //   ),
                  // ),
                  Text(
                    textAlign: TextAlign.center,
                    _getSuggestionString(),
                    style: textTheme.bodySmall!.copyWith(
                      color: colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.topRight,
            child: IconButtonWidget(
              path: 'assets/svg/information.svg',
              overrideColor: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTLDRWidget(TextTheme textTheme, ColorScheme colorScheme) {
    switch (split?.perOffPBIntervalTime) {
      case double n when n >= 4.5:
        return Text(
          'HIGH',
          style: textTheme.headlineMedium!.copyWith(color: metricOrange),
        );
      case double n when n >= -4.5:
        return Text(
          'GOOD',
          style: textTheme.headlineMedium!.copyWith(color: metricBlue),
        );
      case double n when n >= -8.0:
        return Text(
          'AMAZING',
          style: textTheme.headlineMedium!.copyWith(color: metricPurple),
        );
      default:
        return Text(
          'Unavailable',
          style: textTheme.headlineMedium!.copyWith(color: metricRed),
        );
    }
  }

  String _getSuggestionString() {
    final offBy = split?.getSecondsOffPB() ?? 0.0;

    String offByString = (offBy >= 0 ? '+' : '') + offBy.toStringAsFixed(2);

    switch (split?.perOffPBIntervalTime) {
      case double n when n >= 4.5:
        return 'Don\'t give up! What can you change to reduce your time by $offByString seconds?';
      case double n when n >= -4.5:
        return 'Nice job. You\'re $offByString seconds off your PB pace. Keep it up!';
      case double n when n >= -8.0:
        return 'AMAZING! You\'re $offByString seconds under your PB pace. Think about why this is faster.';
      default:
        return 'Unavailable';
    }
  }
}
