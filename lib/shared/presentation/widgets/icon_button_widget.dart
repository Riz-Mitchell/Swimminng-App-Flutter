import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class IconButtonWidget extends ConsumerWidget {
  final String path;
  final VoidCallback? onTapped;
  final bool isActive;
  final bool isInvisible;
  final Color? overrideColor;

  const IconButtonWidget({
    super.key,
    required this.path,
    this.onTapped,
    this.isActive = true,
    this.isInvisible = false,
    this.overrideColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: [
            // BoxShadow(
            //   color: colorScheme.primary.withOpacity(0.4),
            //   blurRadius: 4,
            //   spreadRadius: 20,
            // ),
          ],
        ),
        child: SvgPicture.asset(
          path,
          width: 25,
          height: 25,
          colorFilter: ColorFilter.mode(
            (overrideColor != null)
                ? overrideColor!
                : (isInvisible)
                ? Colors.transparent
                : (isActive)
                ? colorScheme.primary
                : colorScheme.secondary,
            BlendMode.srcIn,
          ),
        ),
      ),
      onTap: () {
        if (onTapped != null && !isInvisible) {
          onTapped!();
        }
      },
    );
  }
}
