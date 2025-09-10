import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrimaryButtonWidget extends ConsumerWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? overrideBgColor;
  final Color? overrideColor;
  final TextStyle? overrideStyle;

  const PrimaryButtonWidget({
    super.key,
    required this.text,
    this.onPressed,
    this.overrideBgColor,
    this.overrideColor,
    this.overrideStyle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _handleOnPressed(),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: (overrideBgColor != null)
              ? overrideBgColor!
              : Theme.of(context).colorScheme.primary,
        ),
        child: Text(
          text,
          style: (overrideStyle != null)
              ? overrideStyle
              : Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: (overrideColor != null)
                      ? overrideColor
                      : Theme.of(context).colorScheme.onPrimary,
                ),
        ),
      ),
    );
  }

  void _handleOnPressed() {
    if (onPressed != null) {
      onPressed!();
    }
  }
}
