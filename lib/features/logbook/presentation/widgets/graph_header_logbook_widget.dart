import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

class GraphHeaderLogbookWidget extends ConsumerWidget {
  const GraphHeaderLogbookWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '-0.52%',
              style: textTheme.displayMedium!.copyWith(
                color: colorScheme.primary,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 25),
              child: Text(
                'Off Pb Pace',
                style: textTheme.bodyMedium!.copyWith(
                  color: colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
        Divider(color: colorScheme.secondary),
        Container(
          margin: EdgeInsets.only(right: 25),
          child: Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Worst:',
                    style: textTheme.bodyMedium!.copyWith(
                      color: colorScheme.secondary,
                    ),
                  ),
                  Text(
                    'Best:',
                    style: textTheme.bodyMedium!.copyWith(
                      color: colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '+4.10%',
                    style: textTheme.headlineMedium!.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  Text(
                    '-4.35%',
                    style: textTheme.headlineMedium!.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
