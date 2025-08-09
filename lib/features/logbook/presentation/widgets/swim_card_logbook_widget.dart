import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/swims/domain/models/swim_model.dart';
import 'package:swimming_app_frontend/features/swims/enum/event_enum.dart';

class SwimCardLogbookWidget extends ConsumerWidget {
  final String asset;
  late GetSwimResDTO? swim;

  SwimCardLogbookWidget({super.key, required this.asset, this.swim});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    swim =
        swim ??
        GetSwimResDTO(
          id: '1',
          event: EventEnum
              .freestyle50, // Provide appropriate default or mock value
          splits: const [], // Provide appropriate default or mock value
          goalSwim: false, // Provide appropriate default or mock value
          recordedAt:
              DateTime.now(), // Provide appropriate default or mock value
        );

    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: colorScheme.primary,
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(20),
      //   color: colorScheme.surface,
      // ),
      child: (swim == null)
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
                      '2:15pm',
                      style: textTheme.headlineSmall?.copyWith(
                        color: colorScheme.secondary,
                      ),
                    ),
                    SvgPicture.asset(
                      asset,
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        colorScheme.secondary,
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
                                color: colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.secondary,
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
                                color: colorScheme.secondary,
                              ),
                            ),
                            Text(
                              '50m',
                              style: textTheme.headlineSmall?.copyWith(
                                color: colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          spacing: 5,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Pace',
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.secondary,
                              ),
                            ),
                            Text(
                              '100',
                              style: textTheme.headlineSmall?.copyWith(
                                color: colorScheme.onPrimary,
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
                              'Pool',
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.secondary,
                              ),
                            ),
                            Text(
                              'SC',
                              style: textTheme.headlineSmall?.copyWith(
                                color: colorScheme.onPrimary,
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
                              'Reflection',
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.secondary,
                              ),
                            ),
                            Text(
                              'Incomplete',
                              style: textTheme.headlineSmall?.copyWith(
                                color: colorScheme.onPrimary,
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
