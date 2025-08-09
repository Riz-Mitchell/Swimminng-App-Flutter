import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class RankingListItemSquadWidget extends ConsumerWidget {
  final String name;
  final int rank;
  final String result;

  const RankingListItemSquadWidget({
    super.key,
    this.name = 'Holly',
    this.rank = 1,
    this.result = '26.89s',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final backgroundColour = rank == 1
        ? Colors.yellow[800]
        : rank == 2
        ? Colors.grey[400]
        : rank == 3
        ? Colors.brown[400]
        : colorScheme.surface;

    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backgroundColour,
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 50,
            children: [
              Text(
                _formatRank(rank),
                style: (rank <= 3)
                    ? textTheme.displaySmall?.copyWith(
                        color: colorScheme.primary,
                      )
                    : textTheme.headlineSmall?.copyWith(
                        color: colorScheme.primary,
                      ),
              ),
              Row(
                spacing: 10,
                children: [
                  SvgPicture.asset(
                    'assets/svg/user_placeholder.svg',
                    width: 30,
                    height: 30,
                    colorFilter: ColorFilter.mode(
                      colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  Text(
                    name,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            result,
            style: textTheme.headlineSmall?.copyWith(
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  String _formatRank(int rank) {
    switch (rank) {
      case 1:
        return '1st';
      case 2:
        return '2nd';
      case 3:
        return '3rd';
      default:
        return '${rank}th';
    }
  }
}
