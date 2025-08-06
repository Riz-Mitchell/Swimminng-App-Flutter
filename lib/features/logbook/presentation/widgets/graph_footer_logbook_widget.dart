import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

class GraphFooterLogbookWidget extends ConsumerWidget {
  const GraphFooterLogbookWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                color: metricRed,
                borderRadius: BorderRadius.circular(5),
              ),
              child: SvgPicture.asset(
                colorFilter: ColorFilter.mode(
                  metricRedSecondary,
                  BlendMode.srcIn,
                ),
                'assets/svg/up_arrow.svg',
                width: 15,
                height: 15,
              ),
            ),
            Text(
              'Bad',
              style: TextTheme.of(
                context,
              ).headlineMedium!.copyWith(color: colorScheme.secondary),
            ),
          ],
        ),
        Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Good',
              style: TextTheme.of(
                context,
              ).headlineMedium!.copyWith(color: colorScheme.secondary),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                color: metricPurple,
                borderRadius: BorderRadius.circular(5),
              ),
              child: RotatedBox(
                quarterTurns: 2,
                child: SvgPicture.asset(
                  colorFilter: ColorFilter.mode(
                    metricPurpleSecondary,
                    BlendMode.srcIn,
                  ),
                  'assets/svg/up_arrow.svg',
                  width: 15,
                  height: 15,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
