import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

final testSelectedProvider = StateProvider.autoDispose<bool>((ref) => false);

class AnimatedAddButtonWidget extends ConsumerWidget {
  final bool visible;

  const AnimatedAddButtonWidget({super.key, this.visible = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = ref.watch(testSelectedProvider);

    // target size based on both selection & visibility
    final double targetSize = visible
        ? (isSelected ? 2000 : 60) // background circle size
        : 0; // hidden

    final double iconScale = visible ? 1.0 : 0.0; // scale icon in/out

    return Transform.translate(
      offset: const Offset(140, 300),
      child: OverflowBox(
        alignment: Alignment.center,
        maxWidth: double.infinity,
        maxHeight: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Expanding background circle
            IgnorePointer(
              ignoring: true,
              child: AnimatedContainer(
                width: targetSize,
                height: targetSize,
                duration: const Duration(milliseconds: 400),
                curve: Curves.fastEaseInToSlowEaseOut,
                decoration: const BoxDecoration(
                  color: metricBlue,
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // Touchable icon
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (visible) {
                  ref.read(testSelectedProvider.notifier).state = !isSelected;
                }
              },
              child: AnimatedScale(
                scale: iconScale,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                child: AnimatedRotation(
                  turns: isSelected ? .375 : 0.0, // rotate 45 degrees
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  child: SvgPicture.asset(
                    'assets/svg/add.svg',
                    width: 50,
                    height: 50,
                    colorFilter: ColorFilter.mode(
                      colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
