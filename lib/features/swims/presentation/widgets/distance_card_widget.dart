import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/swims/application/providers/event_selection_provider.dart.dart';

class DistanceCardWidget extends ConsumerWidget {
  final double height = 100;
  final int distance;

  const DistanceCardWidget({super.key, required this.distance});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventSelectionState = ref.watch(eventSelectionProvider);
    final eventSelectionNotifier = ref.read(eventSelectionProvider.notifier);
    final isSelected = eventSelectionNotifier.isSelectedDistance(distance);

    print('isValidSelection: ${eventSelectionNotifier.isValidSelection()}');

    return GestureDetector(
      onTap: () {
        print('tapped');
        eventSelectionNotifier.toggleDistance(this.distance);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
          ),
        ),
        child: TweenAnimationBuilder<Color?>(
          duration: Duration(milliseconds: 300),
          tween: ColorTween(
            begin: isSelected
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.primary,
            end: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
          ),
          builder: (context, color, _) => Text(
            '${distance} Meters',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: color!),
          ),
        ),
      ),
    );
  }
}
