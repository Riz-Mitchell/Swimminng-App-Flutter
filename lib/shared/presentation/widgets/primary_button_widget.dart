import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrimaryButtonWidget extends ConsumerWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? overrideBgColor;
  final Color? overrideColor;

  const PrimaryButtonWidget({
    super.key,
    required this.text,
    this.onPressed,
    this.overrideBgColor,
    this.overrideColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          backgroundColor: (overrideBgColor != null)
              ? overrideBgColor!
              : Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () => _handleOnPressed(),

        child: Text(
          text,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
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
