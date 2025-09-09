import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExternalSwimmerResultWidget extends ConsumerWidget {
  final String fullName;
  final String? club;
  final VoidCallback onTap;

  const ExternalSwimmerResultWidget({
    super.key,
    required this.fullName,
    this.club,
    required this.onTap,
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
        child: Column(
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
      ),
    );
  }
}
