import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DataProfileWidget extends ConsumerWidget {
  final dynamic data;
  final String text;
  final String asset;

  const DataProfileWidget({
    super.key,
    required this.data,
    required this.text,
    required this.asset,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        spacing: 30,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              asset,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end, // Pushes to bottom
            crossAxisAlignment: CrossAxisAlignment.start, // Aligns left
            mainAxisSize: MainAxisSize.max, // Fills vertical space
            children: [
              Text(
                data.toString(),
                style: textTheme.displayMedium?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              Text(
                text,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
