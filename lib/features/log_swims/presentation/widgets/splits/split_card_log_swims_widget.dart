import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swimming_app_frontend/features/log_swims/application/log_swim_provider.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/selected_pool_type_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/models/split_model.dart';
import 'package:swimming_app_frontend/features/swims/enum/event_enum.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/icon_button_widget.dart';

class SplitCardLogSwimsWidget extends ConsumerWidget {
  final int distance;
  final double time;
  final int? count;
  final int? rate;

  final SplitModel splitRef;

  const SplitCardLogSwimsWidget({
    super.key,
    required this.distance,
    required this.time,
    this.count,
    this.rate,
    required this.splitRef,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    final logSwimState = ref.watch(logSwimProvider);

    final SelectedPoolTypeEnum poolType = logSwimState.poolType;
    final EventEnum event = logSwimState.event;

    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: colorScheme.surface,
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(20),
      //   color: colorScheme.surface,
      // ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // SizedBox(width: 20, height: 20),
              Text(
                '${_eventEnumToStroke(event)} Split',
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.secondary,
                ),
              ),
              IconButtonWidget(
                path: 'assets/svg/close.svg',
                isActive: true,
                overrideColor: colorScheme.error,
                onTapped: () =>
                    ref.read(logSwimProvider.notifier).removeSplit(splitRef),
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
                        _timeToString(time),
                        style: textTheme.displayLarge?.copyWith(
                          color: colorScheme.primary,
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
                mainAxisAlignment: (count == null && rate == null)
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Distance',
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.secondary,
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.center,

                        _distanceToString(poolType),
                        style: textTheme.headlineSmall?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  (rate != null)
                      ? Column(
                          spacing: 5,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              textAlign: TextAlign.center,

                              'Stroke Rate',
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.secondary,
                              ),
                            ),
                            Text(
                              textAlign: TextAlign.center,

                              '${rate!} cyc/min',
                              style: textTheme.headlineSmall?.copyWith(
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                  (count != null)
                      ? Column(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              textAlign: TextAlign.center,

                              'Stroke Count',
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.secondary,
                              ),
                            ),
                            Text(
                              textAlign: TextAlign.center,

                              '${count!} strokes',
                              style: textTheme.headlineSmall?.copyWith(
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ],
              ), // Bottom row with less relevant info
            ],
          ),
        ],
      ),
    );
  }

  String _eventEnumToStroke(EventEnum event) {
    switch (event) {
      case EventEnum.none:
        return 'None';
      // Add other cases for EventEnum if needed
      case EventEnum.freestyle50:
      case EventEnum.freestyle100:
      case EventEnum.freestyle200:
      case EventEnum.freestyle400:
      case EventEnum.freestyle800:
      case EventEnum.freestyle1500:
        return 'Freestyle';
      case EventEnum.backstroke100:
      case EventEnum.backstroke200:
        return 'Backstroke';
      case EventEnum.breaststroke100:
      case EventEnum.breaststroke200:
        return 'Breaststroke';
      case EventEnum.butterfly100:
      case EventEnum.butterfly200:
        return 'Butterfly';
      case EventEnum.individualMedley200:
      case EventEnum.individualMedley400:
        return 'Individual Medley';
    }
  }

  String _timeToString(double time) {
    final minutes = (time / 60).floor();

    if (minutes == 0) {
      return '${time.toStringAsFixed(2)}s';
    } else {
      final seconds = (time % 60).toStringAsFixed(2);
      return '${minutes}m ${seconds}s';
    }
  }

  String _distanceToString(SelectedPoolTypeEnum poolType) {
    switch (poolType) {
      case SelectedPoolTypeEnum.unselected:
      case SelectedPoolTypeEnum.longCourseMeters:
      case SelectedPoolTypeEnum.shortCourseMeters:
        return '${distance}m';
      case SelectedPoolTypeEnum.shortCourseYards:
        return '${distance}y';
    }
  }

  String _getSvgPath(EventEnum event) {
    switch (event) {
      case EventEnum.none:
        return 'assets/svg/add.svg';
      // Add other cases for EventEnum if needed
      case EventEnum.freestyle50:
      case EventEnum.freestyle100:
      case EventEnum.freestyle200:
      case EventEnum.freestyle400:
      case EventEnum.freestyle800:
      case EventEnum.freestyle1500:
        return 'assets/svg/Freestyle.svg';
      case EventEnum.backstroke100:
      case EventEnum.backstroke200:
        return 'assets/svg/Backstroke.svg';
      case EventEnum.breaststroke100:
      case EventEnum.breaststroke200:
        return 'assets/svg/BreastStroke.svg';
      case EventEnum.butterfly100:
      case EventEnum.butterfly200:
        return 'assets/svg/Butterfly.svg';
      case EventEnum.individualMedley200:
      case EventEnum.individualMedley400:
        return 'assets/svg/swimmer_icon.svg';
    }
  }
}
