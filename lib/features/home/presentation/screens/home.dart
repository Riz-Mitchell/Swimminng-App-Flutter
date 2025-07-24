import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/swims/domain/models/split_model.dart';
import 'package:swimming_app_frontend/features/home/application/providers/home_provider.dart';
import 'package:swimming_app_frontend/features/home/presentation/widgets/swim_card_widget.dart';
import 'package:swimming_app_frontend/features/swims/domain/models/swim_model.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/button_widget.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homePageData = ref.watch(homePageDataProvider);

    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Container(
            margin: const EdgeInsets.symmetric(vertical: 70, horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Column(
                      spacing: 10,
                      children: [
                        Row(
                          spacing: 30,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/Water_Drop_Under.svg',
                                  width: 100,
                                  height: 100,
                                ),
                                Positioned(
                                  bottom: 6,
                                  child: SvgPicture.asset(
                                    'assets/svg/Water_Drop.svg',
                                    width: 85,
                                    height: 85,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 5,
                              children: [
                                Text(
                                  '22',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                ),
                                Text(
                                  'Days Active',
                                  style: Theme.of(context).textTheme.bodyMedium
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
                        Divider(
                          color: Theme.of(context).colorScheme.secondary,
                          thickness: 1,
                          radius: BorderRadius.circular(20),
                        ),
                        Column(children: []),
                      ],
                    ),
                  ),
                  homePageData.when(
                    data: (data) {
                      GetSwimResDTO swimData = data.latestSwimData;
                      GetSplitResDTO finalSplit = swimData.splits.first;
                      GetSplitResDTO firstSplit = swimData.splits.last;

                      final int? finalRate = finalSplit.intervalStrokeRate;
                      final int? finalStrokes = finalSplit.intervalStrokeCount;
                      final int? exertion = swimData.perceivedExertion;
                      final double? firstSplitTime = firstSplit.intervalTime;

                      return SwimCardWidget(
                        finalTime: finalSplit.intervalTime,
                        event: swimData.event,
                        finalRate: finalRate,
                        finalStrokes: finalStrokes,
                        exertion: exertion,
                        splitsCount: swimData.splits.length,
                        firstSplit: firstSplitTime,
                        isLoading: false,
                      );
                    },
                    loading: () => SwimCardWidget(isLoading: true),
                    error: (error, stackTrace) =>
                        SwimCardWidget(isLoading: true),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Column(
                      spacing: 15,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sessions',
                              style: Theme.of(context).textTheme.displayMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                            ),
                            Text(
                              '>',
                              style: Theme.of(context).textTheme.displayMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                            ),
                          ],
                        ),
                        Column(
                          spacing: 5,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 20,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.purpleAccent,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Thursday · Night',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium
                                            ?.copyWith(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                            ),
                                      ),
                                      Text(
                                        'Pace 50s on 2:00, with a side of nut trucking',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.secondary,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              spacing: 20,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Wednesday · Night',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium
                                            ?.copyWith(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                            ),
                                      ),
                                      Text(
                                        'Speed work. Lots of dives',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.secondary,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        ButtonWidget(text: 'Add To Diary'),
                      ],
                    ),
                  ),
                  ButtonWidget(
                    text: 'Measure HR',
                    onPressed: () {
                      ref.read(routerProvider).go('/heart-rate');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
