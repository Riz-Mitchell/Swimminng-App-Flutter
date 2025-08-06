import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/stroke_enum.dart';

class StrokeButtonLogSwimsWidget extends ConsumerWidget {
  final VoidCallback? onTap;
  final StrokeEnum stroke;

  const StrokeButtonLogSwimsWidget({
    super.key,
    this.onTap,
    required this.stroke,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _handleOnTap(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).colorScheme.onPrimary,
            width: 2,
          ),
        ),
        child: Text(
          stroke.name,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }

  void _handleOnTap() {
    if (onTap != null) {
      onTap!.call();
    }
  }
}
