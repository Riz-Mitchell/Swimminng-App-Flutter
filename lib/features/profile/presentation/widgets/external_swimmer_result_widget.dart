import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/external/aus/application/link_external_swims_provider.dart';

class ExternalSwimmerResultWidget extends ConsumerWidget {
  final String id;
  final String fullName;
  final String? club;
  final VoidCallback onTap;
  final bool isSelected;

  const ExternalSwimmerResultWidget({
    super.key,
    required this.id,
    required this.fullName,
    this.club,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: textTheme.headlineSmall?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
                Text(
                  club ?? 'N/A',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.secondary,
                  ),
                ),
              ],
            ),
            Animate(
              target: isSelected ? 1 : 0, // 1 = forward, 0 = reverse
              effects: [
                FadeEffect(duration: 500.ms, curve: Curves.easeInOut),
                MoveEffect(
                  begin: const Offset(20, 0), // start 50px to the right
                  end: Offset.zero, // slide into place
                  duration: 400.ms,
                  curve: Curves.easeInOut,
                ),
              ],
              child: SvgPicture.asset(
                'assets/svg/Return_Icon.svg',
                width: 25,
                height: 25,
                colorFilter: ColorFilter.mode(
                  isSelected ? colorScheme.primary : colorScheme.secondary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
