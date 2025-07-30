import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

class PbCardProfileWidget extends ConsumerWidget {
  final String asset;
  final swim;

  PbCardProfileWidget({super.key, required this.asset, required this.swim});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: metricPurple,
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(20),
      //   color: colorScheme.surface,
      // ),
      child: (swim != null)
          ? SizedBox.shrink()
          : Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '50m · Race',
                      style: textTheme.headlineMedium?.copyWith(
                        color: metricPurpleSecondary,
                      ),
                    ),
                    SvgPicture.asset(
                      asset,
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        metricPurpleSecondary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   'Final Time',
                            //   style: textTheme.bodyMedium!.copyWith(
                            //     color: colorScheme.secondary,
                            //   ),
                            // ),
                            Text(
                              '23.60s',
                              style: textTheme.displayLarge?.copyWith(
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      color: metricPurpleSecondary,
                      thickness: 1,
                      radius: BorderRadius.circular(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          spacing: 5,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Distance',
                              style: textTheme.bodyMedium?.copyWith(
                                color: metricPurpleSecondary,
                              ),
                            ),
                            Text(
                              '50m',
                              style: textTheme.headlineMedium?.copyWith(
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fina Pts',
                              style: textTheme.bodyMedium?.copyWith(
                                color: metricPurpleSecondary,
                              ),
                            ),
                            Text(
                              '783',
                              style: textTheme.headlineMedium?.copyWith(
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PB By',
                              style: textTheme.bodyMedium?.copyWith(
                                color: metricPurpleSecondary,
                              ),
                            ),
                            Text(
                              '0.24s',
                              style: textTheme.headlineMedium?.copyWith(
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ), // Bottom row with less relevant info
                  ],
                ),
              ],
            ),
    );
  }
}
