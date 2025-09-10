import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/external/aus/domain/models/aus_swim_model.dart';
import 'package:swimming_app_frontend/features/link_external_swims/domain/models/link_external_swims_model.dart';
import 'package:swimming_app_frontend/shared/enum/event_enum.dart';

class MostRecentSwimCardWidget extends ConsumerWidget {
  final CreateAusSwimModel externalSwim;

  const MostRecentSwimCardWidget({super.key, required this.externalSwim});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                textAlign: TextAlign.center,
                'Most recent swim',
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.secondary,
                ),
              ),
              SvgPicture.asset(
                'assets/svg/personal_best.svg',
                width: 25,
                height: 25,
                colorFilter: ColorFilter.mode(
                  colorScheme.secondary,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            formatSwimTime(externalSwim.splits.last.splitTime),
            style: textTheme.displayLarge?.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
          SizedBox(height: 5),
          Text(
            textAlign: TextAlign.center,
            'In the ${externalSwim.event.toReadableString()} at the ${externalSwim.meetName}',
            style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary),
          ),
        ],
      ),
    );
  }

  String formatSwimTime(double timeInSeconds) {
    final minutes = timeInSeconds ~/ 60;
    final seconds = timeInSeconds % 60;

    if (minutes > 0) {
      return '${minutes}:${seconds.toStringAsFixed(2).padLeft(5, '0')}s';
    } else {
      return '${timeInSeconds.toStringAsFixed(2)}s';
    }
  }
}
