import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/squad/presentation/widgets/ranking_list_item_squad_widget.dart';

class LeaderboardSquadWidget extends ConsumerWidget {
  const LeaderboardSquadWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          'assets/svg/podium.svg',
          width: 100,
          height: 100,
          colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
        ),
        Column(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RankingListItemSquadWidget(
              rank: 1,
              name: 'Holly',
              result: '26.89s',
            ),
            RankingListItemSquadWidget(rank: 2, name: 'Liam', result: '27.15s'),
            RankingListItemSquadWidget(rank: 3, name: 'Emma', result: '27.45s'),
            RankingListItemSquadWidget(
              rank: 4,
              name: 'Olivia',
              result: '27.60s',
            ),
            RankingListItemSquadWidget(rank: 5, name: 'Noah', result: '27.75s'),
          ],
        ),
      ],
    );
  }
}
