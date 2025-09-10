import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/split_entity.dart';

class PotentialTimeLogbookWidget extends ConsumerWidget {
  final GetSplitEntity split;

  const PotentialTimeLogbookWidget({super.key, required this.split});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        spacing: 20,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Potential Time',
                style: textTheme.headlineSmall!.copyWith(
                  color: colorScheme.secondary,
                ),
              ),
              SvgPicture.asset(
                'assets/svg/lightning.svg',
                width: 25,
                height: 25,
                colorFilter: ColorFilter.mode(
                  colorScheme.secondary,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
          Text(
            split.getPotentialRaceTimeString(),
            style: textTheme.displayLarge!.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
          Text(
            textAlign: TextAlign.center,
            'Your potential race time if you maintain the speed for the whole distance.',
            style: textTheme.bodySmall!.copyWith(color: colorScheme.secondary),
          ),
        ],
      ),
    );
  }
}
