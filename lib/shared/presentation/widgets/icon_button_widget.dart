import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class IconButtonWidget extends ConsumerWidget {
  final String path;
  final VoidCallback? onTapped;

  const IconButtonWidget({super.key, required this.path, this.onTapped});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: colorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          path,
          width: 25,
          height: 25,
          colorFilter: ColorFilter.mode(colorScheme.onPrimary, BlendMode.srcIn),
        ),
      ),
      onTap: () {
        if (onTapped != null) {
          onTapped!();
        }
      },
    );
  }
}
