import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/swims/domain/models/swim_model.dart';
import 'package:swimming_app_frontend/features/swims/enum/event_enum.dart';

class BasicCardSquadWidget extends ConsumerWidget {
  BasicCardSquadWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    final squad = 's';

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
      child: (squad == null)
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
                      'National Open · Nunawading',
                      style: textTheme.headlineMedium?.copyWith(
                        color: colorScheme.secondary,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/svg/group.svg',
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
                      spacing: 20,

                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Text(
                        //   'Final Time',
                        //   style: textTheme.bodyMedium!.copyWith(
                        //     color: colorScheme.secondary,
                        //   ),
                        // ),
                        Text(
                          '35.5km',
                          style: textTheme.displayLarge?.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                        Text(
                          'This Week',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.secondary,
                      thickness: 1,
                      radius: BorderRadius.circular(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          spacing: 5,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Average',
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.secondary,
                              ),
                            ),
                            Text(
                              '5.0km',
                              style: textTheme.headlineLarge?.copyWith(
                                color: colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          spacing: 5,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Athletes',
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.secondary,
                              ),
                            ),
                            Text(
                              '26',
                              style: textTheme.headlineLarge?.copyWith(
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
