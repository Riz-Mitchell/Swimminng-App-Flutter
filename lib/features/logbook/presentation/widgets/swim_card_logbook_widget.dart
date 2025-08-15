import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/selected_pool_type_enum.dart';
import 'package:swimming_app_frontend/shared/enum/event_enum.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/swim_entity.dart';

class SwimCardLogbookWidget extends ConsumerWidget {
  final GetSwimEntity swim;

  const SwimCardLogbookWidget({super.key, required this.swim});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

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
      child: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getTimeString(swim.recordedAt),
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.secondary,
                ),
              ),
              SvgPicture.asset(
                _getAssetPath(),
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
                        _getFinalTimeString(),
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
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Distance',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.secondary,
                        ),
                      ),
                      Text(
                        _getFinalSplitDistance(),
                        style: textTheme.headlineSmall?.copyWith(
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
                        'Pace',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.secondary,
                        ),
                      ),
                      Text(
                        _getPace(),
                        style: textTheme.headlineSmall?.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Pool',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.secondary,
                        ),
                      ),
                      Text(
                        _getPoolType(),
                        style: textTheme.headlineSmall?.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Off By',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.secondary,
                        ),
                      ),
                      Text(
                        _getPercentageOffPB(),
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

  String _getTimeString(DateTime time) {
    final localTime = time.toLocal();

    final hour = localTime.hour % 12 == 0 ? 12 : localTime.hour % 12;
    final minute = localTime.minute.toString().padLeft(2, '0');
    final period = localTime.hour >= 12 ? 'pm' : 'am';
    return '$hour:$minute$period';
  }

  String _getFinalTimeString() {
    final double finalSplitTime = swim.getFinalSplitTime();

    final minutes = (finalSplitTime / 60).floor();
    final seconds = (finalSplitTime % 60);

    if (minutes > 0) {
      return '${minutes}m ${seconds.toStringAsFixed(2)}s';
    } else {
      return '${seconds.toStringAsFixed(2)}s';
    }
  }

  String _getFinalSplitDistance() {
    final int finalSplitDistance = swim.getFinalSplitDistance();

    String splitDistString = finalSplitDistance.toString();

    switch (swim.poolType) {
      case SelectedPoolTypeEnum.shortCourseMeters:
      case SelectedPoolTypeEnum.longCourseMeters:
      case SelectedPoolTypeEnum.unselected:
        splitDistString = '${splitDistString}m';
        break;
      case SelectedPoolTypeEnum.shortCourseYards:
        splitDistString = '${splitDistString}yd';
        break;
    }

    return splitDistString;
  }

  String _getPace() {
    switch (swim.event) {
      case EventEnum.freestyle50:
        return '50';
      case EventEnum.freestyle100:
      case EventEnum.butterfly100:
      case EventEnum.backstroke100:
      case EventEnum.breaststroke100:
        return '100';
      case EventEnum.freestyle200:
      case EventEnum.butterfly200:
      case EventEnum.backstroke200:
      case EventEnum.breaststroke200:
      case EventEnum.individualMedley200:
        return '200';
      case EventEnum.freestyle400:
      case EventEnum.individualMedley400:
        return '400';
      case EventEnum.freestyle800:
        return '800';
      case EventEnum.freestyle1500:
        return '1500';
      case EventEnum.none:
        return '';
    }
  }

  String _getPoolType() {
    switch (swim.poolType) {
      case SelectedPoolTypeEnum.shortCourseMeters:
        return 'SCM';
      case SelectedPoolTypeEnum.longCourseMeters:
        return 'LCM';
      case SelectedPoolTypeEnum.shortCourseYards:
        return 'SCY';
      case SelectedPoolTypeEnum.unselected:
        return 'Unselected';
    }
  }

  String _getQuestionnaireCompleteness() {
    return '${swim.swimQuestionnaire.getQuestionnaireCompleteness().toStringAsFixed(2)}% done';
  }

  String _getAssetPath() {
    switch (swim.event) {
      case EventEnum.freestyle50:
      case EventEnum.freestyle100:
      case EventEnum.freestyle200:
      case EventEnum.freestyle400:
      case EventEnum.freestyle800:
      case EventEnum.freestyle1500:
        return 'assets/svg/Freestyle.svg';
      case EventEnum.butterfly100:
      case EventEnum.butterfly200:
        return 'assets/svg/Butterfly.svg';
      case EventEnum.backstroke100:
      case EventEnum.backstroke200:
        return 'assets/svg/Backstroke.svg';
      case EventEnum.breaststroke100:
      case EventEnum.breaststroke200:
        return 'assets/svg/Breaststroke.svg';
      case EventEnum.individualMedley200:
      case EventEnum.individualMedley400:
        return 'assets/svg/Freestyle.svg';
      default:
        return 'assets/svg/none.svg';
    }
  }

  String _getPercentageOffPB() {
    final percentageOff = swim.getFinalSplitPercentageOffPB();
    return percentageOff != 0.0
        ? '${percentageOff.toStringAsFixed(2)}%'
        : '0.00%';
  }
}
