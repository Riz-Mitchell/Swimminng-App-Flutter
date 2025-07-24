import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataLogbookWidget extends ConsumerWidget {
  final dynamic data;
  final String text;

  const DataLogbookWidget({super.key, required this.data, required this.text});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        spacing: 1,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.toString(),
            style: textTheme.displayLarge?.copyWith(color: colorScheme.primary),
          ),
          Text(
            text,
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.secondary),
          ),
        ],
      ),
    );
  }
}
