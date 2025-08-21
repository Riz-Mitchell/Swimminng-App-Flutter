import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/stroke_data_logbook_widget.dart';
import 'package:swimming_app_frontend/shared/enum/event_enum.dart';

class StrokeDataContainerLogbookWidget extends ConsumerWidget {
  const StrokeDataContainerLogbookWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Strokes Data',
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.secondary,
                ),
              ),
              SvgPicture.asset(
                'assets/svg/swimmer_icon.svg',
                width: 25,
                height: 25,
                colorFilter: ColorFilter.mode(
                  colorScheme.secondary,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
        StrokeDataLogbookWidget(
          event: EventEnum.freestyle50,
          highestPerOffPb: 4.25,
          averagePerOffPb: 1,
          lowestPerOffPb: -6.51,
          isSelected: true,
        ),
      ],
    );
  }
}
