import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class HeaderProfileWidget extends ConsumerWidget {
  final String name;
  final int swims;
  final DateTime joinedDate;
  final int friends;

  const HeaderProfileWidget({
    super.key,
    required this.name,
    required this.swims,
    required this.joinedDate,
    required this.friends,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      padding: const EdgeInsets.only(top: 80, left: 12, right: 12, bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/svg/user_placeholder.svg',
            width: 100,
            height: 100,
            colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
          ),
          Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Rizzle',
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Swims',
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.secondary,
                        ),
                      ),
                      Text(
                        '$swims',
                        style: textTheme.headlineSmall?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Joined',
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.secondary,
                        ),
                      ),
                      Text(
                        'Jan 2025',
                        style: textTheme.headlineSmall?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Friends',
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.secondary,
                        ),
                      ),
                      Text(
                        '$friends',
                        style: textTheme.headlineSmall?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
