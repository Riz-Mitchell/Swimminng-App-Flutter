import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/swims/enum/event_enum.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';

class SwimCardWidget extends ConsumerWidget {
  const SwimCardWidget({
    this.finalTime,
    this.event,
    this.finalRate,
    this.finalStrokes,
    this.exertion,
    this.splitsCount,
    this.firstSplit,
    super.key,
    required this.isLoading,
  });

  final double? finalTime;
  final EventEnum? event;
  final int? finalRate;
  final int? finalStrokes;
  final int? exertion;
  final int? splitsCount;
  final double? firstSplit;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => ref.read(routerProvider).go('/swims-landing'),
      child: Column(
        spacing: 30,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Swims',
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    Text(
                      '>',
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          spacing: 16,
                          children: [
                            Text(
                              '${(!isLoading) ? finalTime : '-'}s',

                              style: Theme.of(context).textTheme.displayLarge
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 10,
                              children: [
                                Text(
                                  '${(!isLoading && finalRate != null) ? finalRate : '-'}cyc/min',
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                      ),
                                ),
                                Text(
                                  '${(!isLoading && finalStrokes != null) ? finalStrokes : '-'} strokes',
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ), // Top row with more important info
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
                          'Ev.',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                        Text(
                          '${(!isLoading && event != null) ? event!.toReadableString() : '-'}',
                          style: Theme.of(context).textTheme.displayMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                    if (firstSplit != null)
                      Column(
                        spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '1st Split',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                          ),
                          Text(
                            '${firstSplit}s',
                            style: Theme.of(context).textTheme.displayMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
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
                          'Exertion',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                        Text(
                          (!isLoading && exertion != null)
                              ? exertion.toString()
                              : '-',
                          style: Theme.of(context).textTheme.displayMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
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
                          'Counts',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                        Text(
                          '${(!isLoading && splitsCount != null) ? splitsCount : '-'}',
                          style: Theme.of(context).textTheme.displayMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                  ],
                ), // Bottom row with less relevant info
              ],
            ),
          ),
        ],
      ),
    );
  }
}
