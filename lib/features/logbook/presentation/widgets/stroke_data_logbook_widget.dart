import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/logbook/application/selected_event_logbook_provider.dart';
import 'package:swimming_app_frontend/shared/enum/event_enum.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/gradient_mapper.dart';

class StrokeDataLogbookWidget extends ConsumerWidget {
  final EventEnum event;
  final double averagePerOffPb;
  final double highestPerOffPb;
  final double lowestPerOffPb;

  const StrokeDataLogbookWidget({
    super.key,
    required this.event,
    required this.averagePerOffPb,
    required this.highestPerOffPb,
    required this.lowestPerOffPb,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final isSelected = ref.watch(selectedEventLogbookProvider) == event;

    return GestureDetector(
      onTap: () {
        final selectedEventLogbookNotifier = ref.read(
          selectedEventLogbookProvider.notifier,
        );
        if (isSelected) {
          selectedEventLogbookNotifier.state = EventEnum.none;
        } else {
          selectedEventLogbookNotifier.state = event;
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: 150,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: (isSelected)
                    ? mapValueToColor(averagePerOffPb, 1)
                    : mapValueToColor(averagePerOffPb, 0.25),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    event.getAssetPath(),
                    width: 25,
                    height: 25,
                    colorFilter: ColorFilter.mode(
                      colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  Text(
                    '${averagePerOffPb.toStringAsFixed(2)}%',
                    style: textTheme.headlineMedium?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              event.toReadableString(),
              style: textTheme.headlineMedium?.copyWith(
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
